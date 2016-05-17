//
//  CategoryModel.h
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/28.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *count;

@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, copy) NSString *total;
@property (nonatomic, assign) NSUInteger currentPage;
@end
