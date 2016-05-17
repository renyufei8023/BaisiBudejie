//
//  RecommendViewController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/28.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendCategoryCell.h"
#import "CategoryModel.h"
#import "SubCategoryTableViewCell.h"
#import "SubCategoryModel.h"
#define subCategoryModel _categoryArray[self.leftTabbleView.indexPathForSelectedRow.row]

@interface RecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) RYFNetworkHttpRequestsManges *requestManager;
@property (weak, nonatomic) IBOutlet UITableView *leftTabbleView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (nonatomic, strong) NSArray *categoryArray;
@property (nonatomic, strong) NSArray *subCategoryArray;
@property (nonatomic, strong) NSMutableDictionary *params;//保存请求参数，如果请求参数不一样那么就不加载当前这个请求的数据
@end

@implementation RecommendViewController

static NSString *const categoryID = @"category";
static NSString *const subCategoryID = @"subcategory";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self loadData];
    
    [self setupFooterView];
}

- (void)initView
{
    self.title = @"推荐关注";
    
    self.view.backgroundColor = RGBCOLOR(223, 223, 223);
    [self.leftTabbleView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryID];
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SubCategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:subCategoryID];
    self.leftTabbleView.backgroundColor = [UIColor clearColor];
    self.rightTableView.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.leftTabbleView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.rowHeight = 70;
    [self tableView:_rightTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
}

- (void)loadData
{
    [SVProgressHUD show];
    _requestManager = [RYFNetworkHttpRequestsManges new];
    [_requestManager initHttpRequestManges];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    NSString *requestURL = @"http://api.budejie.com/api/api_open.php";
    [_requestManager download:requestURL andMethod:RYFRequestMethodGet andParameter:params andPassParameters:nil success:^(id returnData, id passParameters) {
        DEBUGLOG(@"返回数据%@",returnData);
        _categoryArray = [CategoryModel mj_objectArrayWithKeyValuesArray:returnData[@"list"]];
        
        [SVProgressHUD dismiss];
        [_leftTabbleView reloadData];
        [_leftTabbleView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(id returnData, NSError *error, id passParameters) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

/**
 *  下拉加载更多数据
 */
- (void)setupFooterView
{
    _rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    _rightTableView.mj_footer.hidden = YES;
}

- (void)loadMoreUsers
{
    CategoryModel *model = subCategoryModel;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"category_id"] = [subCategoryModel id];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"page"] = @(++model.currentPage);
    self.params = params;
    [_requestManager download:@"http://api.budejie.com/api/api_open.php" andMethod:RYFRequestMethodGet andParameter:params andPassParameters:nil success:^(id returnData, id passParameters) {
        if (self.params != params) {
            return ;
        }
        DEBUGLOG(@"子类返回数据%@",returnData);
        NSArray *array = [SubCategoryModel mj_objectArrayWithKeyValuesArray:returnData[@"list"]];
        [[subCategoryModel users] addObjectsFromArray:array];
        [_rightTableView reloadData];
        model.total = returnData[@"total"];
        if (model.users.count == [model.total integerValue]) {
            [_rightTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [_rightTableView.mj_footer endRefreshing];
        }
    } failure:^(id returnData, NSError *error, id passParameters) {
        
    }];

}

#pragma mark -- UITableView delegate && dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftTabbleView) {
        return _categoryArray.count;
    }else{
        CategoryModel *model =  _categoryArray[self.leftTabbleView.indexPathForSelectedRow.row];
        _rightTableView.mj_footer.hidden = (model.users.count <= 9);
        return model.users.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTabbleView) {
        RecommendCategoryCell *recommendCell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        recommendCell.categoryModel = _categoryArray[indexPath.row];
        return recommendCell;
    }else{
        
        SubCategoryTableViewCell *subcategoryCell = [tableView dequeueReusableCellWithIdentifier:subCategoryID];
        CategoryModel *model =  _categoryArray[self.leftTabbleView.indexPathForSelectedRow.row];
        subcategoryCell.subcategoryModel = model.users[indexPath.row];
        
        return subcategoryCell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTabbleView) {
        [_rightTableView.mj_footer endRefreshing];
        CategoryModel *categoryModel = _categoryArray[indexPath.row];
        if (categoryModel.users.count) {
            [_rightTableView reloadData];
        }else{
            
            categoryModel.currentPage = 1;
            //网络请求慢的时候可能还是现实之前的数据，刷新之后就不会再有这个问题
            [_rightTableView reloadData];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"category_id"] = categoryModel.id;
            params[@"a"] = @"list";
            params[@"c"] = @"subscribe";
            params[@"page"] = @(categoryModel.currentPage);
            self.params = params;
            [_requestManager download:@"http://api.budejie.com/api/api_open.php" andMethod:RYFRequestMethodGet andParameter:params andPassParameters:nil success:^(id returnData, id passParameters) {
                
                NSArray *array = [SubCategoryModel mj_objectArrayWithKeyValuesArray:returnData[@"list"]];
                [categoryModel.users addObjectsFromArray:array];
                //放到刷新之前为了节省流量着想
                if (self.params != params) {
                    return ;
                }
                
                [_rightTableView reloadData];
                
                categoryModel.total = returnData[@"total"];
                if (categoryModel.users.count == [categoryModel.total integerValue]) {
                    [_rightTableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [_rightTableView.mj_footer endRefreshing];
                }
            } failure:^(id returnData, NSError *error, id passParameters) {
                
            }];

            [_rightTableView.mj_header beginRefreshing];
        }
  
    }
}

- (void)dealloc
{
    //取消所有的请求，避免在没有请求到数据之前返回上一个控制器之后有请求到数据了造成的崩溃
    [_requestManager.manager.operationQueue cancelAllOperations];
}
@end
