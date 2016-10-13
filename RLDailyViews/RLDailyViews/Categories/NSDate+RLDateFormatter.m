//
//  NSDate+RLDateFormatter.m
//  RLDailyViews
//
//  Created by LiWei on 16/6/29.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "NSDate+RLDateFormatter.h"

@implementation NSDate (RLDateFormatter)

//将间隔时间格式转换为 “20160629”
+ (NSString *)configureDateFormatterInterval:(NSInteger)interval{
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}


+ (NSString *)configureDateFormatter:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}


+ (NSDate *)yesterdayOfDateStr:(NSString *)dateStr{//yyyyMMdd
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMdd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *date = [formatter dateFromString:dateStr];
    
    NSDate *preDate = [NSDate dateWithTimeInterval:(-60 * 60 * 24) sinceDate:date];
    
    return preDate;
}

+ (NSDate *)tomorrowOfDateStr:(NSString *)dateStr{//yyyyMMdd
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMdd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *date = [formatter dateFromString:dateStr];
    
    NSDate *preDate = [NSDate dateWithTimeInterval:(60 * 60 * 24) sinceDate:date];
    
    return preDate;
}

@end
