//
//  RecommendTagModel.h
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/29.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RecommendTagModel : NSObject


@property (nonatomic, copy) NSString *image_list;

@property (nonatomic, copy) NSString *theme_id;

@property (nonatomic, copy) NSString *theme_name;

@property (nonatomic, assign) NSInteger is_sub;

@property (nonatomic, assign) NSInteger is_default;

@property (nonatomic, assign) NSInteger sub_number;

@end

