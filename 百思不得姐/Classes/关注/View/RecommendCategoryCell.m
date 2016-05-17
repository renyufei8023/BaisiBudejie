//
//  RecommendCategoryCell.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/28.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RecommendCategoryCell.h"
#import "CategoryModel.h"

@interface RecommendCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *selectView;

@end
@implementation RecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RGBCOLOR(244, 244, 244);
//    self.textLabel.textColor = RGBCOLOR(74, 74, 74);
//    //highlightedTextColor可以设置选中时候字体的颜色
//    self.textLabel.highlightedTextColor = RGBCOLOR(215, 27, 26);

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    /**
     *  当选中cell的时候如果设置了selectionStyle为none的话会造成self.textLabel.highlightedTextColor这个颜色无法正常显示，解决这个问题的方法就是在- (void)setSelected:(BOOL)selected animated:(BOOL)animated这个方法中设置选中时字体颜色以及普通状态下的文字颜色,cell被选中时内部子控件不会进入高亮状态
     *
     *
     */
    _selectView.hidden = !selected;
    self.textLabel.textColor = !selected ? RGBCOLOR(74, 74, 74) : RGBCOLOR(215, 27, 26);
}

- (void)setCategoryModel:(CategoryModel *)categoryModel
{
    _categoryModel = categoryModel;
    
    self.textLabel.text = categoryModel.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //如果想改变系统中某一个控件的位置可以在layoutSubviews重新设置控件的位置
    self.textLabel.height = self.height - 2;
}
@end
