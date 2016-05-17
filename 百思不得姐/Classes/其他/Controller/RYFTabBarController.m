//
//  RYFTabBarController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/22.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RYFTabBarController.h"
#import "MeViewController.h"
#import "EssenceViewController.h"
#import "FriendTrendsViewController.h"
#import "NewViewController.h"
#import "RYFTabBar.h"
#import "RYFNavigationController.h"

@interface RYFTabBarController ()

@end

@implementation RYFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [self addChildVIewController:[[EssenceViewController alloc]init] title:@"精华" image:[UIImage imageNamed:@"tabBar_essence_icon"] selectImage:[UIImage imageNamed:@"tabBar_essence_click_icon"]];
    [self addChildVIewController:[[NewViewController alloc]init] title:@"新帖" image:[UIImage imageNamed:@"tabBar_new_icon"] selectImage:[UIImage imageNamed:@"tabBar_new_click_icon"]];
    [self addChildVIewController:[[FriendTrendsViewController alloc]init] title:@"关注" image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"]];
    [self addChildVIewController:[[MeViewController alloc]init] title:@"我" image:[UIImage imageNamed:@"tabBar_me_icon"] selectImage:[UIImage imageNamed:@"tabBar_me_click_icon"]];
    
    [self setValue:[[RYFTabBar alloc]init] forKey:@"tabBar"];
    
}

- (void)addChildVIewController:(UIViewController *)controller title:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage
{
    RYFNavigationController *nav = [[RYFNavigationController alloc]initWithRootViewController:controller];
    controller.view.backgroundColor = RGBCOLOR(223, 223, 223);
    controller.tabBarItem.image = image;
    controller.tabBarItem.selectedImage = selectImage;
    controller.tabBarItem.title = title;
    [self addChildViewController:nav];
}

@end
