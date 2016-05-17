//
//  NewViewController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/19.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController ()

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"MainTagSubIcon" heighlitImage:@"MainTagSubIconClick" target:self ation:@selector(tagClick)];
    
    // Do any additional setup after loading the view.
}

- (void)tagClick
{
    DEBUGLOG(@"%s",__func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
