//
//  CommentViewController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/14.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "CommentViewController.h"
#import "JokesTableViewCell.h"
#import "JokesModel.h"
#import "CommentModel.h"
#import "CommentHeaderView.h"
#import "CommentTableViewCell.h"

@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) RYFNetworkHttpRequestsManges *requestManager;
@property (nonatomic, strong) NSArray *hotComments;
@property (nonatomic, strong) NSMutableArray *datas;
/** 保存帖子的top_cmt */
@property (nonatomic, strong) NSArray *saved_top_cmt;
@property (nonatomic, assign) NSInteger page;

@end

static NSString *const cellID = @"comment";
@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self setupRefresh];
    // Do any additional setup after loading the view from its nib.
}

- (void)initView
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    if (self.jokeModel.top_cmt.count) {
        self.saved_top_cmt = self.jokeModel.top_cmt;
        self.jokeModel.top_cmt = nil;//这个是让model的top_cmt变为空的，空的就不会再显示热评那里
        [self.jokeModel setValue:@0 forKeyPath:@"cellHeight"];//这个方法为了使重新计算高度
    }

    //当设置某一个控件为tableview的tableHeaderView时候，当滑动tableview的时候会一直调用找个控件的setframe方法
    UIView *bgView = [UIView new];
    JokesTableViewCell *jokeCell = [JokesTableViewCell jokesTableViewCell];
    jokeCell.jokeModel = _jokeModel;
    jokeCell.size = CGSizeMake(SCREENWIDTH, _jokeModel.cellHeight);
    
    [bgView addSubview:jokeCell];
    bgView.height = _jokeModel.cellHeight + TopicCellMargin;
    _tableView.tableHeaderView = bgView;
    
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:@"comment_nav_item_share_icon_click" heighlitImage:@"comment_nav_item_share_icon_click" target:nil ation:nil];
    _tableView.backgroundColor = RGBCOLOR(223, 223, 223);
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDatas)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)loadMoreDatas
{
    NSInteger page = self.page ++;
    
    _requestManager = [RYFNetworkHttpRequestsManges new];
    [_requestManager initHttpRequestManges];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"dataList";
    param[@"c"] = @"comment";
    param[@"hot"] = @"1";
    param[@"data_id"] = _jokeModel.ID;
    param[@"page"] = @(page);
    
    [_requestManager download:@"http://api.budejie.com/api/api_open.php" andMethod:RYFRequestMethodGet andParameter:param andPassParameters:nil success:^(id returnData, id passParameters) {
        
        self.hotComments = [CommentModel mj_objectArrayWithKeyValuesArray:returnData[@"hot"]];
        
        NSArray *newDatas = [CommentModel mj_objectArrayWithKeyValuesArray:returnData[@"data"]];
        [self.datas addObjectsFromArray:newDatas];
        [self.tableView reloadData];
        
        self.page = page;
        
        NSInteger total = [returnData[@"total"] integerValue];
        if (self.datas.count >= total) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(id returnData, NSError *error, id passParameters) {
        
        [self.tableView.mj_footer endRefreshing];
        self.page --;
    }];
}

- (void)loadNewDatas
{
//    [self.tableView.mj_footer endRefreshing];
    _requestManager = [RYFNetworkHttpRequestsManges new];
    [_requestManager initHttpRequestManges];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"dataList";
    param[@"c"] = @"comment";
    param[@"hot"] = @"1";
    param[@"data_id"] = _jokeModel.ID;
    
    [_requestManager download:@"http://api.budejie.com/api/api_open.php" andMethod:RYFRequestMethodGet andParameter:param andPassParameters:nil success:^(id returnData, id passParameters) {
        [self.tableView.mj_header endRefreshing];
        self.hotComments = [CommentModel mj_objectArrayWithKeyValuesArray:returnData[@"hot"]];
        self.datas = [CommentModel mj_objectArrayWithKeyValuesArray:returnData[@"data"]];
        [self.tableView reloadData];
        self.page = 1;
        
        
    } failure:^(id returnData, NSError *error, id passParameters) {
        
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.datas;
    }
    return self.datas;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComments.count) {
        return 2;
    }else if (self.datas.count) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger dataCount = self.datas.count;
    if (section == 0) {
        return hotCount ? hotCount : dataCount;
    }
    self.tableView.mj_footer.hidden = (dataCount == 0);
    return dataCount;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        return  hotCount ? @"热门评论" : @"最新评论";
//    }
//    return @"最新评论";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *const headerViewID = @"header";
    CommentHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewID];
    if (!headerView) {
        headerView = [[CommentHeaderView alloc]initWithReuseIdentifier:headerViewID];
    }
    
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        NSString *title = hotCount ? @"最热评论" : @"最新评论";
        
        headerView.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        headerView.title = @"最新评论";
    }
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    CommentModel *model = [self commentsInSection:indexPath.section][indexPath.row];
    cell.commentModel = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell becomeFirstResponder];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else{
        UIMenuItem *ding = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *huifu = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(huifu:)];
        UIMenuItem *jubao = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(jubao:)];
        
        menu.menuItems = @[ding,huifu,jubao];
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardH = SCREENHEIGHT - frame.origin.y;
    
    self.bottomConstraint.constant = keyboardH;
    
    CGFloat time = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:time animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark -- UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    if (self.saved_top_cmt.count) {
        self.jokeModel.top_cmt = self.saved_top_cmt;
        [self.jokeModel setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    [_requestManager.manager.operationQueue cancelAllOperations];
}

#pragma mark --UIMenuController
- (void)ding:(UIMenuController *)menu
{
    DEBUGLOG(@"%s",__func__);
}

- (void)huifu:(UIMenuController *)menu
{
    
}

- (void)jubao:(UIMenuController *)menu
{
    
}
@end
