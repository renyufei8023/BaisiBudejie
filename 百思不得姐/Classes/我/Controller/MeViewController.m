//
//  MeViewController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/22.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"
#import "MeTableViewFooterView.h"
#import "SettingController.h"

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MeViewController

static NSString *const cellID = @"ME";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)setupNav
{
    self.navigationItem.title = @"我的";
    UIBarButtonItem *setting = [UIBarButtonItem itemWithimage:@"mine-setting-icon" heighlitImage:@"mine-setting-icon-click" target:self ation:@selector(settingClick)];
    UIBarButtonItem *moon = [UIBarButtonItem itemWithimage:@"mine-moon-icon" heighlitImage:@"mine-moon-icon-click" target:self ation:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[setting,moon];
}

- (void)initView
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[MeTableViewCell class] forCellReuseIdentifier:cellID];
    
    //设置tableview上面的间距，也可以使用tableview的代理方面进行设置
    _tableView.sectionFooterHeight = 0;
    _tableView.sectionHeaderHeight = TopicCellMargin;
    _tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    _tableView.tableFooterView = [[MeTableViewFooterView alloc]init];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

- (void)settingClick
{
    SettingController *VC = [[SettingController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)moonClick
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
