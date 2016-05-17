//
//  SubCategoryTableViewCell.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/28.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "SubCategoryTableViewCell.h"
#import "SubCategoryModel.h"

@interface SubCategoryTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconIMG;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;
@property (weak, nonatomic) IBOutlet UIButton *fourceBtn;

@end
@implementation SubCategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RGBCOLOR(244, 244, 244);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSubcategoryModel:(SubCategoryModel *)subcategoryModel
{
    _subcategoryModel = subcategoryModel;
    [_iconIMG sd_setImageWithURL:[NSURL URLWithString:subcategoryModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    _nameLab.text = subcategoryModel.screen_name;
    _descLab.text = [NSString stringWithFormat:@"%@人关注",subcategoryModel.tiezi_count];
}

@end
