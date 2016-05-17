//
//  JokesVideoView.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/13.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "JokesVideoView.h"
#import "JokesModel.h"
@interface JokesVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playountLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end
@implementation JokesVideoView

+ (instancetype)videoView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setJokeModel:(JokesModel *)jokeModel
{
    _jokeModel = jokeModel;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:jokeModel.large_image] placeholderImage:nil];
    _playountLab.text = [NSString stringWithFormat:@"%zd次播放",jokeModel.playcount];
    
    NSInteger second = jokeModel.videotime / 60;
    NSInteger min = jokeModel.videotime % 60;
    _timeLab.text = [NSString stringWithFormat:@"%02zd:%02zd",min,second];

    
}
@end
