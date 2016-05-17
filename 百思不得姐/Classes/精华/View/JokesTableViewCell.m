//
//  JokesTableViewCell.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/31.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "JokesTableViewCell.h"
#import "JokesModel.h"
#import "JokesPictureView.h"
#import "JokesVoiceView.h"
#import "JokesVideoView.h"
#import "CommentModel.h"

@interface JokesTableViewCell ()
@property (nonatomic, strong) JokesPictureView *jokePicView;
@property (nonatomic, strong) JokesVoiceView *jokeVoiceView;
@property (nonatomic, strong) JokesVideoView *jokeVideoView;
@end

@implementation JokesTableViewCell

+ (instancetype)jokesTableViewCell
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (JokesPictureView *)jokePicView
{
    if (!_jokePicView) {
        _jokePicView = [JokesPictureView pictureView];
        [self.contentView addSubview:_jokePicView];
    }
    return _jokePicView;
}

- (JokesVoiceView *)jokeVoiceView
{
    if (!_jokeVoiceView) {
        _jokeVoiceView = [JokesVoiceView voiceView];
        [self.contentView addSubview:_jokeVoiceView];
    }
    return _jokeVoiceView;
}

- (JokesVideoView *)jokeVideoView
{
    if (!_jokeVideoView) {
        _jokeVideoView = [JokesVideoView videoView];
        [self.contentView addSubview:_jokeVideoView];
    }
    return _jokeVideoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageView;
    
}

- (void)setJokeModel:(JokesModel *)jokeModel
{
    _jokeModel = jokeModel;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:jokeModel.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _iconImageView.image = image ? [image circleImage] : [UIImage imageNamed:@"defaultUserIcon"];
    }];
    _nameLab.text = jokeModel.name;
    _timeLab.text = jokeModel.passtime;
    [self setupBtnTitle:_starBtn conunt:jokeModel.ding];
    [self setupBtnTitle:_caiBtn conunt:jokeModel.cai];
    [self setupBtnTitle:_shareBtn conunt:jokeModel.repost];
    [self setupBtnTitle:_commentBtn conunt:jokeModel.comment];
    
    _timeLab.text = jokeModel.lasttime;
    _text_label.text = jokeModel.text;
    
    if (jokeModel.type == ControllerTypePicture) {
        self.jokePicView.jokesModel = jokeModel;
        self.jokePicView.frame = jokeModel.picF;
        self.jokeVideoView.hidden = YES;
        self.jokeVoiceView.hidden = YES;
        self.jokePicView.hidden = NO;
    }else if (jokeModel.type == ControllerTypeVoice) {
        self.jokeVoiceView.jokeModel = jokeModel;
        self.jokeVoiceView.frame = jokeModel.voiceF;
        self.jokePicView.hidden = YES;
        self.jokeVideoView.hidden = YES;
        self.jokeVoiceView.hidden = NO;
    }else if (jokeModel.type == ControllerTypeVideo) {
        self.jokeVideoView.jokeModel = jokeModel;
        self.jokeVideoView.frame = jokeModel.videoF;
        self.jokePicView.hidden = YES;
        self.jokeVoiceView.hidden = YES;
        self.jokeVideoView.hidden = NO;
    }else{
        self.jokeVoiceView.hidden = YES;
        self.jokePicView.hidden = YES;
        self.jokeVideoView.hidden = YES;
    }
    
    CommentModel *cmtModel = [jokeModel.top_cmt firstObject];
    if (cmtModel) {
        self.cmtBgView.hidden = NO;
        self.cmtcontentLab.text = [NSString stringWithFormat:@"%@ : %@",cmtModel.user.username,cmtModel.content];
    }else{
        self.cmtBgView.hidden = YES;
    }
}


/**
 *  计算时间差值
 *
 *  @param passTime <#passTime description#>
 */
- (void)testDate:(NSString *)passTime
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *creat = [fmt dateFromString:passTime];
    NSTimeInterval dalta = [creat timeIntervalSinceDate:now];
    
    
}
- (void)setupBtnTitle:(UIButton *)btn conunt:(NSInteger)count
{
    NSString *title = nil;
    if (count > 10000) {
        title = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else{
        title = [NSString stringWithFormat:@"%zd",count];
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    //这样就不会当这个cell作为评论控制器的tableHeaderView的时候高度一直减小了
    frame.size.height = self.jokeModel.cellHeight - margin;
//    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end
