//
//  RYFNavigationController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/23.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RYFNavigationController.h"

@implementation RYFNavigationController

/**
 *  当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    //更改title文字可以设置self.navigationItem.titleView也可以设置setTitleTextAttributes
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [navigationBar setTitleTextAttributes:dict];//UI_APPEARANCE_SELECTOR设置一次就行了
#warning <#message#>
    //设置barbuttonitem属性
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs= [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitle:@"返回" forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        btn.size = CGSizeMake(70, 30);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
