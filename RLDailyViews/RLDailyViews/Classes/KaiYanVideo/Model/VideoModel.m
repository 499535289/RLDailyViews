//
//  VideoModel.m
//  RLDailyViews
//
//  Created by LiWei on 16/4/17.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"descrip":@"description",
             
             @"collectionCount":@"consumption.collectionCount",
             @"replyCount":@"consumption.replyCount",
             @"shareCount":@"consumption.shareCount"

             };
}

@end
