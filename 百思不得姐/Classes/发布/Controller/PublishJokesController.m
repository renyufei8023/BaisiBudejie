//
//  PublishJokesController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/20.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "PublishJokesController.h"
#import "RYFPlaceHolderTextView.h"
#import "RYFTextView.h"

@interface PublishJokesController ()<UITextViewDelegate>

@end

@implementation PublishJokesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNAV];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)setupNAV
{
    self.title = @"发布帖子";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(publish)];
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)initView
{
    RYFTextView *textView = [[RYFTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.delegate = self;
    textView.placeholer = @"请遵守法律法规";
    [self.view addSubview:textView];
}
- (void)cancel
{
    DEBUGLOGFunc;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)publish
{
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationController.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}



@end
