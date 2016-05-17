//
//  RYFTabBar.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/22.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RYFTabBar.h"
#import "PublishViewController.h"
#import "PublishView.h"
#import "RYFNavigationController.h"

@interface RYFTabBar ()
@property (nonatomic, strong) UIButton *plusButton;

@end
@implementation RYFTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_plusButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [_plusButton addTarget:self action:@selector(plusSignClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_plusButton];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _plusButton.bounds = CGRectMake(0, 0, _plusButton.currentBackgroundImage.size.width, _plusButton.currentBackgroundImage.size.height);
    _plusButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    NSInteger index = 0;

    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            CGFloat buttonX = buttonW * ((index > 1) ? (index + 1) : index);
            view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index ++;
        }
    }
}

#warning 整理代码的时候看下
- (void)plusSignClick
{
    if ([self.tabBarDelegate respondsToSelector:@selector(plusBtnClick)]) {
        [self.tabBarDelegate plusBtnClick];
    }
    //1.model出来
    PublishViewController *VC = [[PublishViewController alloc]init];
    RYFNavigationController *nav = [[RYFNavigationController alloc] initWithRootViewController:VC];
    
    // 这里不能使用self来弹出其他控制器, 因为self执行了dismiss操作
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    [root presentViewController:nav animated:YES completion:nil];

    //2.view添加上去
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    PublishView *view = [PublishView publishView];
//    view.frame = window.bounds;
//    [window addSubview:view];
    
    //3.通过UIWindow添加
//    [PublishView show];
}
@end
