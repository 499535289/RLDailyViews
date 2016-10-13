//
//  ExtraInfoModel.h
//  RLDailyViews
//
//  Created by LiWei on 16/3/24.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExtraInfoModel : NSObject
@property (nonatomic,assign) NSInteger post_reasons;
@property (nonatomic,assign) NSInteger popularity;//获赞数
@property (nonatomic,assign) NSInteger long_comments;//长评论数
@property (nonatomic,assign) NSInteger normal_comments;//正常评论数,与comments数据一致
@property (nonatomic,assign) NSInteger short_comments;//短评论数
@property (nonatomic,assign) NSInteger comments;//评论总数

@end
