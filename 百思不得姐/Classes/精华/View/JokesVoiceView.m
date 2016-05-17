//
//  JokesVoiceView.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/13.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "JokesVoiceView.h"
#import "JokesModel.h"

@interface JokesVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end
@implementation JokesVoiceView

+ (instancetype)voiceView
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
    _playCountLab.text = [NSString stringWithFormat:@"%zd次播放",jokeModel.playcount];
    
    NSInteger second = jokeModel.voicetime / 60;
    NSInteger min = jokeModel.voicetime % 60;
    _timeLab.text = [NSString stringWithFormat:@"%02zd:%02zd",min,second];
    
}

@end
