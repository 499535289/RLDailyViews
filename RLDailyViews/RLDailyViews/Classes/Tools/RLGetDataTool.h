//
//  RLGetDataTool.h
//  RLDailyViews
//
//  Created by LiWei on 16/6/29.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+RLDateFormatter.h"


@interface RLGetDataTool : NSObject

+ (void)getVideosWithDate:(NSString *)date success:(void (^)(id dateVideoDic))success failure:(void (^)(NSError *error))failure;

+ (void)getOneDayVideosWithDate:(NSString *)date success:(void (^)(id dateVideoDic))success failure:(void (^)(NSError *error))failure;

@end
