//
//  FriendTrendsViewController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/22.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "FriendTrendsViewController.h"
#import "RecommendViewController.h"
#import "LoginRegistController.h"

@interface FriendTrendsViewController ()

@end

@implementation FriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)initView
{
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"friendsRecommentIcon" heighlitImage:@"friendsRecommentIcon-click" target:self ation:@selector(friendClick)];
}
- (IBAction)loginRegist {
    LoginRegistController *VC = [LoginRegistController new];
    [self.navigationController presentViewController:VC animated:YES completion:nil];
}

- (void)friendClick
{
    RecommendViewController *VC = [[RecommendViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
