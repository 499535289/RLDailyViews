//
//  VideoModel.h
//  RLDailyViews
//
//  Created by LiWei on 16/4/17.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface VideoModel : NSObject


@property (nonatomic, assign) NSInteger id;//id

@property (nonatomic, copy) NSString *category;//分类，如：广告

@property (nonatomic, copy) NSString *coverBlurred;//description的毛玻璃图片

@property (nonatomic, copy) NSString *coverForDetail;//视频主背景图片

@property (nonatomic, copy) NSString *descrip;//简述

@property (nonatomic, assign) NSInteger duration;//视频时长

@property (nonatomic, copy) NSString *title;//视频title

@property (nonatomic, copy) NSString *playUrl;//播放的url地址（高清地址）


@property (nonatomic, assign) NSInteger collectionCount;//收藏数

@property (nonatomic, assign) NSInteger replyCount;//

@property (nonatomic, assign) NSInteger shareCount;//分享数

@end
