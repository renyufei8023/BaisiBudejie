//
//  MeTableViewFooterView.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/19.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "MeTableViewFooterView.h"
#import "Memodel.h"
#import "UIButton+WebCache.h"
#import "SqaureButton.h"
#import "MEWebController.h"

@interface MeTableViewFooterView ()
@property (nonatomic, strong) RYFNetworkHttpRequestsManges *requestManager;
@property (nonatomic, strong) NSArray *models;

@end

@implementation MeTableViewFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _requestManager = [RYFNetworkHttpRequestsManges new];
        [_requestManager initHttpRequestManges];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        [_requestManager download:@"http://api.budejie.com/api/api_open.php" andMethod:0 andParameter:params andPassParameters:nil success:^(id returnData, id passParameters) {
            _models = [Memodel mj_objectArrayWithKeyValuesArray:returnData[@"square_list"]];
            [self createSubViews:_models];
            
        } failure:^(id returnData, NSError *error, id passParameters) {
            
        }];
    }
    return self;
}

- (void)createSubViews:(NSArray *)models
{
    NSInteger total = 4;
    
    CGFloat btnW = SCREENWIDTH / total;
    CGFloat btnH = btnW;
    
    for (int i = 0; i < models.count; i++) {
        SqaureButton *btn = [SqaureButton buttonWithType:UIButtonTypeCustom];
        Memodel *model = models[i];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal];
        [self addSubview:btn];
        btn.tag = i;
        int row = i / total;
        int col = i % total;
        
        btn.x = col * btnW;
        btn.y = row * btnH;
        btn.width = btnW;
        btn.height = btnH;
    }
    
    //是个公式，总个数加上每行有几个然后减去1然后除以每行的个数得出最多多少航
    NSInteger rows = (models.count + total - 1) /total;
    self.height = rows *btnH;
    [self setNeedsDisplay];
}

- (void)btnClick:(SqaureButton *)btn
{
    Memodel *model = _models[btn.tag];
    if (![model.url hasPrefix:@"http"]) return;
    
    MEWebController *meVC = [[MEWebController alloc]init];
    meVC.url = model.url;
    meVC.title = model.name;
    
    //先取出UITabBarController，然后从UITabBarController取出当前选中的控制器UINavigationController
//    UITabBarController *tabbarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    
//    UINavigationController *nav = (UINavigationController *)tabbarVC.selectedViewController;
//    [nav pushViewController:meVC animated:YES];
    
    //通过响应者链条来获得
    [[self parentController].navigationController pushViewController:meVC animated:YES];
    
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
}
@end
