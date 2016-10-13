//
//  HotStoryModel.h
//  RLDailyViews
//
//  Created by LiWei on 16/3/24.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExtraInfoModel.h"

@interface HotStoryModel : NSObject

@property (nonatomic,assign) NSInteger news_id;//日报id
@property (nonatomic,copy) NSString * title;//日报简短标题
@property (nonatomic,copy) NSString * thumbnail;//小图片url
@property (nonatomic,copy) NSString * url;//文章详情url

@property (nonatomic,assign) NSInteger popularity;//获赞数
@property (nonatomic,assign) NSInteger comments;//评论总数

@end
