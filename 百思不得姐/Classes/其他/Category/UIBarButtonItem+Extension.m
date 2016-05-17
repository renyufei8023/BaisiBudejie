//
//  UIBarButtonItem+Extension.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/23.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithimage:(NSString *)image heighlitImage:(NSString *)heighlitImage target:(id)target ation:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:heighlitImage] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentBackgroundImage.size;
    return [[self alloc]initWithCustomView:btn];
}
@end
