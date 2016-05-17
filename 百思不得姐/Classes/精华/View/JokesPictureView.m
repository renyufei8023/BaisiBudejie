//
//  JokesPictureView.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/6.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "JokesPictureView.h"
#import "JokesModel.h"
#import "DALabeledCircularProgressView.h"
#import "ShowpictureViewController.h"

@interface JokesPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seebigView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end
@implementation JokesPictureView

+ (instancetype)pictureView
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib
{
    //不设置的话会出现就是你已经设置好frame了 但是他自己会拉伸然后还有其他的 不是你自己想要的效果
    self.autoresizingMask = UIViewAutoresizingNone;
    _progressView.roundedCorners = 2;
    _progressView.progressLabel.textColor = [UIColor whiteColor];
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)];
    [_imageView addGestureRecognizer:tap];
    
}

- (void)showPicture
{
    ShowpictureViewController *showPicture = [[ShowpictureViewController alloc]init];
    showPicture.jokesModel = _jokesModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setJokesModel:(JokesModel *)jokesModel
{
    _jokesModel = jokesModel;
    
    [_progressView setProgress:jokesModel.picLoadProgress];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:jokesModel.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        _progressView.hidden = NO;
        
        //下载进度
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        jokesModel.picLoadProgress = progress;
        progress = (progress < 0 ? 0 : progress);
        
        [_progressView setProgress:progress];
        _progressView.progressLabel.text = [NSString stringWithFormat:@"%0.f%%",progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _progressView.hidden = YES;
        
        if (jokesModel.isBigPicture == NO) {
            return ;
        }
        //在这里设置长图片显示最上方的一部分
        UIGraphicsBeginImageContextWithOptions(jokesModel.picF.size, YES, 0.0);
        
        CGFloat width = jokesModel.picF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }];
    
    
    NSString *GIF = jokesModel.large_image.pathExtension;
    _gifView.hidden = ![GIF.lowercaseString isEqualToString:@"gif"];
    
    if (jokesModel.isBigPicture == YES) {//大图
        _seebigView.hidden = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }else{//非大图
        _seebigView.hidden = YES;
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    
}
@end
