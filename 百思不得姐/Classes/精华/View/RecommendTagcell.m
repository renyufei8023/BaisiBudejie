//
//  RecommendTagcell.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/29.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RecommendTagcell.h"
#import "RecommendTagModel.h"

@interface RecommendTagcell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageListImg;
@property (weak, nonatomic) IBOutlet UILabel *themeName;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLab;

@end
@implementation RecommendTagcell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendTagModel:(RecommendTagModel *)recommendTagModel
{
    _recommendTagModel = recommendTagModel;
    
    [_imageListImg sd_setImageWithURL:[NSURL URLWithString:recommendTagModel.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    _themeName.text = recommendTagModel.theme_name;
    
    NSString *subNumber = nil;
    if (recommendTagModel.sub_number > 10000) {
        subNumber = [NSString stringWithFormat:@"%.1f万人关注",recommendTagModel.sub_number / 10000.0];
    }else{
        subNumber = [NSString stringWithFormat:@"%ld人关注",recommendTagModel.sub_number];
    }
    _subNumberLab.text = subNumber;
}

/**
 *  修改父类中的东西可以在这个方法中进行设置，这个方法会覆盖之前所有的frame
 *
 *  @param frame <#frame description#>
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    
    [super setFrame:frame];
}
@end
