//
//  RLGetDataTool.m
//  RLDailyViews
//
//  Created by LiWei on 16/6/29.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLGetDataTool.h"
#import "RLSqliteManager.h"
#import "RLZhiHuHttpTool.h"


@implementation RLGetDataTool

+ (void)getVideosWithDate:(NSString *)date success:(void (^)(id dateVideoDic))success failure:(void (^)(NSError *error))failure{
    
    //1、判断本地是否有数据
    NSDictionary *dicFromDB = [[RLSqliteManager shareManager] queryKaiyanVideosFromDbWithDate:date allData:YES];
    
    if (dicFromDB.count) {

        DLog(@"本地取（显示已有缓存的视频列表）");
        if (success) {
            success(dicFromDB);
        }
 
    }else{
        DLog(@"无任何缓存从网络中取，第一次进入app");
        
        //2、本地有数据，显示本地数据
        
        //3、本地无数据，从网络中取数据并缓存起来
        [RLZhiHuHttpTool getKaiyanVideoWithDate:date Success:^(id responseObject) {
            
            if (responseObject) {
                
                NSArray *dailyListArray = ((NSDictionary *)responseObject)[@"dailyList"];//num个元素的数组
                
                NSMutableDictionary * dateVideoDic = [NSMutableDictionary dictionary];
                for (NSDictionary *dic in dailyListArray) {
    
                    //1467129600000
                    NSInteger dateInterval = [dic[@"date"] integerValue];
                    
                    NSArray *videoListArray = dic[@"videoList"];//真正的模型数组
                    
                    //将（字典数组）转换为（二进制数据）
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:videoListArray options:NSJSONWritingPrettyPrinted error:nil];
                    NSString *dateKey = [NSDate configureDateFormatterInterval:(dateInterval / 1000)];
                    
                    //插入数据（缓存）
                    [[RLSqliteManager shareManager] insertKaiyanDataWithJSON:jsonData date:dateKey];;
                    
                    //转模型
                    NSArray *dateVideoListArray = [VideoModel mj_objectArrayWithKeyValuesArray:videoListArray];
                    
                    [dateVideoDic setObject:dateVideoListArray forKey:date];//以日期为key，以modelArray为value
                }
                
                if (success) {
                    success(dateVideoDic);
                }
            }
            
        }failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}






+ (void)getOneDayVideosWithDate:(NSString *)date success:(void (^)(id dateVideoDic))success failure:(void (^)(NSError *error))failure{
    
    //1、判断本地是否有数据
    NSDictionary *dicFromDB = [[RLSqliteManager shareManager] queryKaiyanVideosFromDbWithDate:date allData:NO];
    
    if (dicFromDB.count) {
        DLog(@"本地取（data这天有缓存）");
        if (success) {
            success(dicFromDB);
        }
        
    }else{
        DLog(@"data这天无缓存从网络中取，只获取这一天的");
        
        //本地无数据，从网络中取数据并缓存起来
        [RLZhiHuHttpTool getKaiyanVideoWithDate:date Success:^(id responseObject) {
            
            if (responseObject) {
                
                NSArray *dailyListArray = ((NSDictionary *)responseObject)[@"dailyList"];//num个元素的数组
                
                NSMutableDictionary * dateVideoDic = [NSMutableDictionary dictionary];
                for (NSDictionary *dic in dailyListArray) {
                    
                    //1467129600000
                    NSInteger dateInterval = [dic[@"date"] integerValue];
                    
                    NSArray *videoListArray = dic[@"videoList"];//真正的模型数组
                    
                    //将（字典数组）转换为（二进制数据）
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:videoListArray options:NSJSONWritingPrettyPrinted error:nil];
                    NSString *dateKey = [NSDate configureDateFormatterInterval:(dateInterval / 1000)];
                    
                    //插入数据（缓存）
                    [[RLSqliteManager shareManager] insertKaiyanDataWithJSON:jsonData date:dateKey];;
                    
                    //转模型
                    NSArray *dateVideoListArray = [VideoModel mj_objectArrayWithKeyValuesArray:videoListArray];
                    
                    [dateVideoDic setObject:dateVideoListArray forKey:date];//以日期为key，以modelArray为value
                }
                
                if (success) {
                    success(dateVideoDic);
                }
            }
            
        }failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}



@end
