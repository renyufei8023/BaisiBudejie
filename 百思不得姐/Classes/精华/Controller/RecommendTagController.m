//
//  RecommendTagController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/29.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RecommendTagController.h"
#import "RecommendTagcell.h"
#import "RecommendTagModel.h"

@interface RecommendTagController ()
@property (nonatomic, strong) RYFNetworkHttpRequestsManges *requestManager;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation RecommendTagController

static NSString *const recommendtagCellID = @"tag";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    
    self.tableView.backgroundColor = DEAFAULTCOLOR;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendTagcell class]) bundle:nil] forCellReuseIdentifier:recommendtagCellID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 70;
    
    [self loadData];
}

- (void)loadData
{
    _requestManager = [RYFNetworkHttpRequestsManges new];
    [_requestManager initHttpRequestManges];
    [SVProgressHUD show];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";

    [_requestManager download:@"http://api.budejie.com/api/api_open.php" andMethod:RYFRequestMethodGet andParameter:params andPassParameters:nil success:^(id returnData, id passParameters) {
            [SVProgressHUD dismiss];
            _datas = [RecommendTagModel mj_objectArrayWithKeyValuesArray:returnData];
            [self.tableView reloadData];
            DEBUGLOG(@"子类返回数据%@",returnData);
        } failure:^(id returnData, NSError *error, id passParameters) {
            [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
    }];
    

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecommendTagcell *cell = [tableView dequeueReusableCellWithIdentifier:recommendtagCellID];
    cell.recommendTagModel = _datas[indexPath.row];
    return cell;
}


@end
