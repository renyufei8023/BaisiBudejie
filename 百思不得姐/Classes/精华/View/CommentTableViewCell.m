//
//  CommentTableViewCell.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/15.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "CommentModel.h"

@interface CommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *likeNumLab;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

@end

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageView;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCommentModel:(CommentModel *)commentModel
{
    _commentModel = commentModel;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _iconImageView.image = image ? [image circleImage] : [UIImage imageNamed:@"defaultUserIcon"];
    }];
    _sexView.image = [commentModel.user.sex isEqualToString:@"m"] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    _nameLab.text = commentModel.user.username;
    _contentLab.text = commentModel.content;
    _likeNumLab.text = [NSString stringWithFormat:@"%zd",commentModel.like_count];
    
    if (commentModel.voicetime) {
        _voiceBtn.hidden = NO;
        [_voiceBtn setTitle:[NSString stringWithFormat:@"%zd",commentModel.voicetime] forState:UIControlStateNormal];
        
    }else{
        _voiceBtn.hidden = YES;
    }
}


- (void)setFrame:(CGRect)frame
{
    frame.origin.x += TopicCellMargin;
    frame.size.width -= 2 * TopicCellMargin;
    
    [super setFrame:frame];
}
@end
