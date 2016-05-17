//
//  JokesTableViewCell.h
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/31.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JokesModel;

@interface JokesTableViewCell : UITableViewCell
@property (nonatomic, strong) JokesModel *jokeModel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *starBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIImageView *vipView;
@property (weak, nonatomic) IBOutlet UILabel *cmtcontentLab;
@property (weak, nonatomic) IBOutlet UIView *cmtBgView;

+ (instancetype)jokesTableViewCell;
@end
