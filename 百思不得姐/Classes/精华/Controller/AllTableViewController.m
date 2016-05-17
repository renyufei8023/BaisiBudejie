//
//  AllTableViewController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/5.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "AllTableViewController.h"
#import "RYFNetworkHttpRequestsManges.h"
#import "JokesModel.h"
#import "MJRefresh.h"
#import "JokesTableViewCell.h"
#import "CommentViewController.h"
#import "ToTopWindow.h"

@interface AllTableViewController ()
@property (nonatomic, strong) RYFNetworkHttpRequestsManges *requestManager;
@property (nonatomic, strong) NSMutableArray *jokesData;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic,   copy) NSString *maxtime;
@property (nonatomic,   copy) NSString *maxid;
@property (nonatomic, assign) NSInteger tabSelectIndex;

@end

@implementation AllTableViewController

static NSString *const jokesCellID = @"jokes";
- (NSArray *)jokesData
{
    if (!_jokesData) {
        _jokesData = [NSMutableArray array];
    }
    return _jokesData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [ToTopWindow show];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JokesTableViewCell class]) bundle:nil] forCellReuseIdentifier:jokesCellID];
    _requestManager = [RYFNetworkHttpRequestsManges new];
    [_requestManager initHttpRequestManges];
    [self setupRefresh];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabbarClick) name:UITabbarControllerDidSelectNotification object:nil];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [ToTopWindow show];
}
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadNewData
{
    
    [self.tableView.mj_footer endRefreshing];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(_type);
    self.params = params;
    
    
    [_requestManager download:@"http://api.budejie.com/api/api_open.php" andMethod:RYFRequestMethodGet andParameter:params andPassParameters:nil success:^(id returnData, id passParameters) {
        
        if (self.params != params) return ;
        _maxtime = returnData[@"info"][@"maxtime"];
        if ([_maxid isEqualToString:returnData[@"info"][@"maxid"]]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }else{
            _maxid = returnData[@"info"][@"maxid"];
        }
        
        _jokesData = [JokesModel mj_objectArrayWithKeyValuesArray:returnData[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.page = 0;
    } failure:^(id returnData, NSError *error, id passParameters) {
        if (self.params != params) return ;
        [self.tableView.mj_header endRefreshing];
        self.page = 0;
    }];
}

- (void)tabbarClick
{
    /**
     *  先判断是否显示在窗口上了，如果没有显示在窗口就不刷新，然后判断当前选中的和上次是否一致，如果不一致的话才会刷新
     */
    if ([self.view isShowOnWindow] && self.tabSelectIndex != self.tabBarController.selectedIndex) {
        [self.tableView.mj_header beginRefreshing];
    }
    self.tabSelectIndex =  self.tabBarController.selectedIndex;
    
}

- (NSString *)a
{
    return [self.parentViewController isKindOfClass:NSClassFromString(@"NewViewController")] ? @"newlist" : @"list";
}

- (void)loadMoreData
{
    [self.tableView.mj_header endRefreshing];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(_type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [_requestManager download:@"http://api.budejie.com/api/api_open.php" andMethod:RYFRequestMethodGet andParameter:params andPassParameters:nil success:^(id returnData, id passParameters) {
        
        if (self.params != params) return ;
        _maxtime = returnData[@"info"][@"maxtime"];
        NSArray *newDatas = [JokesModel mj_objectArrayWithKeyValuesArray:returnData[@"list"]];
        [_jokesData addObjectsFromArray:newDatas];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        self.page = page;
    } failure:^(id returnData, NSError *error, id passParameters) {
        if (self.params != params) return ;
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.mj_footer.hidden = (self.jokesData.count == 0);
    return _jokesData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JokesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:jokesCellID];
    cell.jokeModel = _jokesData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JokesModel *model = _jokesData[indexPath.row];
//    model.controllerType = _type;
    return model.cellHeight;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommentViewController *VC = [CommentViewController new];
    VC.jokeModel = (JokesModel *)_jokesData[indexPath.row];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.y > 0) {
        [UIView animateWithDuration:0.1 animations:^{
            self.tabBarController.tabBar.alpha = 0.0;
        }];
        
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            self.tabBarController.tabBar.alpha = 1.0;
        }];
        
    }
}
@end
