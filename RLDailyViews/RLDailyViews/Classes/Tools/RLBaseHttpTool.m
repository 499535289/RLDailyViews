//
//  RLHttpTool.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/21.
//  Copyright © 2016年 LiWei. All rights reserved.
// (void (^)(NSProgress * _Nonnull))downloadProgress)

#import "RLBaseHttpTool.h"
#import "RLTabBarController.h"
#import "RLCommonNavigation.h"

@implementation RLBaseHttpTool
+ (void)startLoading{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
 
}

+ (void)finishedLoading{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}



+ (void)GET:(NSString *)URLString paremeters:(id)paremeters success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure{

    [self startLoading];
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer.timeoutInterval = 8.0;

    
    [mgr GET:URLString parameters:paremeters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        nil;
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            [self finishedLoading];
            
            success(responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            
            failure(error);
            
            [self finishedLoading];
            
            [MBProgressHUD showMsg:@"网络请求失败，请稍后重试!" atView:[UIApplication sharedApplication].keyWindow];
            
            DLog(@"failureError = %@",error);
            
        }
        
        
        
    }];
    
}




@end
