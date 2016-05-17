//
//  NSDate+Extension.h
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/1.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

+ (NSDateComponents *)deltaFrom:(NSDate *)from;

- (BOOL)isThisYear;

- (BOOL)isToday;

- (BOOL)isYesterday;
@end
