//
//  NSDate+RLDateFormatter.h
//  RLDailyViews
//
//  Created by LiWei on 16/6/29.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (RLDateFormatter)
+ (NSString *)configureDateFormatterInterval:(NSInteger)interval;


+ (NSString *)configureDateFormatter:(NSDate *)date;


+ (NSDate *)yesterdayOfDateStr:(NSString *)dateStr;


+ (NSDate *)tomorrowOfDateStr:(NSString *)dateStr;

@end
