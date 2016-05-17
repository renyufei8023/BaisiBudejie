
//
//  ToTopWindow.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/15.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "ToTopWindow.h"

static UIWindow *window;

@implementation ToTopWindow

+ (void)initialize
{
    window = [[UIWindow alloc]init];
    window.frame = CGRectMake(0, 0, SCREENWIDTH, 20);
    window.windowLevel = UIWindowLevelAlert;
    window.backgroundColor = [UIColor clearColor];
    [window addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)windowClick
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:keyWindow];
}

+ (void)show
{
    window.hidden = NO;
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *view in superview.subviews) {
        if ([view isKindOfClass:[UIScrollView class]] && [view isShowOnWindow]) {
            CGPoint offset = view.contentOffset;
            offset.y = - view.contentInset.top;
            [view setContentOffset:offset];
        }
        [self searchScrollViewInView:view];
    }
}
@end
