//
//  NSDate+Extension.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/1.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSDateComponents *)deltaFrom:(NSDate *)from
{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //这个是可选的 年月日时分秒
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //设置时间格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDateComponents *cms = [calendar components:unit fromDate:from toDate:now options:0];
    
    return cms;
    
}

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
    
}

- (BOOL)isToday
{
    //1.
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *now = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [now isEqualToString:selfString];
    
    /*
    //2.
    NSCalendar *calendat = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *nowCmps = [calendat components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendat components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year && nowCmps.month == nowCmps.month && nowCmps.day == selfCmps.day;
     */
    
}

- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    
    NSDate *selfDate =  [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}


@end
