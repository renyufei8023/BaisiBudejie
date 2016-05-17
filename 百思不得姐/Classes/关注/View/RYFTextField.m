//
//  RYFTextField.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/30.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RYFTextField.h"

@implementation RYFTextField

static NSString * const PlacerholderColorKeyPath = @"_placeholderLabel.textColor";

- (void)drawPlaceholderInRect:(CGRect)rect
{
    [super drawPlaceholderInRect:rect];
    //需要设置位置
    [self.placeholder drawInRect:CGRectMake(0, 5, 0, 0) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)awakeFromNib
{
    //设置光标颜色和文字颜色一样
    self.tintColor = self.textColor;
    
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    [self setValue:[UIColor whiteColor] forKeyPath:PlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:PlacerholderColorKeyPath];
    return [super resignFirstResponder];
}
@end
