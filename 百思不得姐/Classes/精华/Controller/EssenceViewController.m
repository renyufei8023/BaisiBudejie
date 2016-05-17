//
//  EssenceViewController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/22.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "EssenceViewController.h"
#import "RecommendTagController.h"
#import "AllTableViewController.h"

@interface EssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIScrollView *contentView;

@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self setupControllers];
    [self setupTitlesView];
    [self setupContentView];
    
}

- (void)initView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:@"MainTagSubIcon" heighlitImage:@"MainTagSubIconClick" target:self ation:@selector(tagbtnClick)];
}

- (void)setupTitlesView
{
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 35)];
    _titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    [self.view addSubview:_titleView];
    
    _indicatorView = [[UIView alloc]init];
    _indicatorView.backgroundColor = [UIColor redColor];
    _indicatorView.height = 2;
    _indicatorView.y = _titleView.height - _indicatorView.height;
    [_titleView addSubview:_indicatorView];
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    CGFloat btnW = _titleView.width / titles.count;
    CGFloat btnH = _titleView.height;
    CGFloat btnY = 0;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        titleBtn.tag = i;
        titleBtn.x = i * btnW;
        titleBtn.width = btnW;
        titleBtn.height = btnH;
        titleBtn.y = btnY;
        [_titleView addSubview:titleBtn];
        [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            titleBtn.enabled = NO;
            _selectBtn = titleBtn;
            [titleBtn.titleLabel sizeToFit];
            _indicatorView.width = titleBtn.titleLabel.width;
            _indicatorView.centerX = titleBtn.centerX;
        }
    }

}

- (void)setupControllers
{
    AllTableViewController *all = [[AllTableViewController alloc]init];
    all.type = ControllerTypeAll;
    [self addChildViewController:all];
    
    AllTableViewController *video = [[AllTableViewController alloc]init];
    video.type = ControllerTypeVideo;
    [self addChildViewController:video];
    
    AllTableViewController *voice = [[AllTableViewController alloc]init];
    voice.type = ControllerTypeVoice;
    [self addChildViewController:voice];
    
    AllTableViewController *picture = [[AllTableViewController alloc]init];
    picture.type = ControllerTypePicture;
    [self addChildViewController:picture];
    
    AllTableViewController *jokes = [[AllTableViewController alloc]init];
    jokes.type = ControllerTypeWord;
    [self addChildViewController:jokes];
    
}

- (void)setupContentView
{
    _contentView = [[UIScrollView alloc]init];
    _contentView.frame = self.view.bounds;
    _contentView.delegate = self;
    _contentView.pagingEnabled = YES;
    _contentView.contentSize = CGSizeMake(_contentView.width * self.childViewControllers.count, 0);
    [_contentView addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    [self.view insertSubview:_contentView atIndex:0];
    [self scrollViewDidEndScrollingAnimation:_contentView];
}

- (void)titleClick:(UIButton *)btn
{
    _selectBtn.enabled = YES;
    btn.enabled = NO;
    _selectBtn = btn;
    
    [UIView animateWithDuration:0.2 animations:^{
        _indicatorView.centerX = btn.centerX;
        _indicatorView.width = btn.titleLabel.width;
    }];
    
    CGPoint offset = _contentView.contentOffset;
    offset.x = btn.tag * _contentView.width;
    [_contentView setContentOffset:offset animated:YES];
    
}

- (void)tagbtnClick
{
    [self.navigationController pushViewController:[RecommendTagController new] animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(_titleView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距，不设置会影响tableview的滑动
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:_titleView.subviews[index + 1
                                         ]];
}

@end
