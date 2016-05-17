//
//  PushGuideView.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/30.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "PushGuideView.h"

@implementation PushGuideView

+ (instancetype)pushguideView
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (IBAction)closeBtnClick {
    [self removeFromSuperview];
}
@end
