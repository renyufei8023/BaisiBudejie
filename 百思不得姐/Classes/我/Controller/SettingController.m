//
//  SettingController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/21.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "SettingController.h"
#import "SDImageCache.h"

@interface SettingController ()

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setting"];
    [self test];
}

- (void)test
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachePath = [cache stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    NSArray *subpaths = [manager subpathsAtPath:cachePath];
    DEBUGLOG(@"hahahah%@",subpaths);
}
- (void)getCacheSize
{
    NSFileManager *manage = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *cachePath = [path stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    NSInteger imageSize = 0;
    //遍历器
    NSDirectoryEnumerator *enumrator= [manage enumeratorAtPath:cachePath];
    for (NSString *fileName in enumrator) {
        NSString *filepath = [cachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [manage attributesOfItemAtPath:filepath error:nil];
//        DEBUGLOG(@"都有什么%@",attrs);
        imageSize += [attrs[NSFileSize] integerValue];
        
//        //        BOOL dir = NO;
//        // 判断文件的类型：文件\文件夹
//        //        [manager fileExistsAtPath:filepath isDirectory:&dir];
//        //        if (dir) continue;
//        NSDictionary *attrs = [manager attributesOfItemAtPath:filepath error:nil];
//        if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
//        
//        totalSize += [attrs[NSFileSize] integerValue];
    }
    DEBUGLOG(@"多大%zd",imageSize);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting" forIndexPath:indexPath];
    CGFloat imageSize = [[SDImageCache sharedImageCache]getSize]/1000.0/1000;
    cell.textLabel.text = [NSString stringWithFormat:@"缓存%.2f",imageSize];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SDImageCache sharedImageCache]cleanDisk];
}

@end
