//
//  CategoryModel.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/28.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
