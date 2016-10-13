//
//  RLHttpTool.h
//  RLDailyViews
//
//  Created by LiWei on 16/3/21.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <MJRefresh.h>
#import "MBProgressHUD+Msg.h"
#import "AppDelegate.h"
#import "RLPlaceholderView.h"

@interface RLBaseHttpTool : NSObject


/**
 *  HTTP请求封装第一层
 *
 *  @param URLString  url地址
 *  @param paremeters url参数
 *  @param success    成功回传
 */
+ (void)GET:(NSString *)URLString paremeters:(id)paremeters success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

@end
