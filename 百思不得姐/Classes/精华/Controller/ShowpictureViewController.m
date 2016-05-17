//
//  ShowpictureViewController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/7.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ShowpictureViewController.h"
#import "JokesModel.h"
#import "DALabeledCircularProgressView.h"

@interface ShowpictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation ShowpictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _imageView = [[UIImageView alloc]init];
    [_scrollView addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    
    _progressView.roundedCorners = 2;
    
    [_progressView setProgress:_jokesModel.picLoadProgress animated:NO];
    
    //下载图片，显示进度
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_jokesModel.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        _progressView.hidden = NO;
        
        //下载进度
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        _jokesModel.picLoadProgress = progress;
        progress = (progress < 0 ? 0 : progress);
        
        [_progressView setProgress:progress];
        _progressView.progressLabel.text = [NSString stringWithFormat:@"%0.f%%",progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _progressView.hidden = YES;
    }];

//    [_imageView sd_setImageWithURL:[NSURL URLWithString:_jokesModel.large_image]];
    CGFloat imageH =  SCREENWIDTH * [_jokesModel.height floatValue] / [_jokesModel.width floatValue];
    
    if ([_jokesModel.height floatValue] > SCREENHEIGHT) {
        
        _imageView.frame = CGRectMake(0, 0, SCREENWIDTH, imageH);
        _scrollView.contentSize = CGSizeMake(0, imageH);
        
    }else{
        _imageView.centerY = SCREENWIDTH * 0.5 ;
        _imageView.width = SCREENWIDTH;
        _imageView.height = imageH;
    }
    
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)savePic:(id)sender {
    if (_imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"请等待图片加载完毕~"];
        return;
    }
    
    UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
@end
