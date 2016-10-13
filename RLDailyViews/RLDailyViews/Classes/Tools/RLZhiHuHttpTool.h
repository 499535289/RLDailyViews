//
//  RLZhiHuHttpTool.h
//  RLDailyViews
//
//  Created by LiWei on 16/3/22.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLBaseHttpTool.h"
#import <MJExtension/MJExtension.h>

@interface RLZhiHuHttpTool : NSObject
/**
 *  获取最新消息
 *
 *  @param success
 */
+ (void)getLatestNewsSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

/**
 *  获取主题日报列表
 *
 *  @param success
 */
+ (void)getThemesListSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

/**
 *  获取热门消息
 *
 *  @param success
 */
+ (void)getHotStoriesSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

/**
 *  获取具体信息详细内容
 *
 *  @param ID      日报id
 *  @param success
 */
+ (void)getDetailWithStoryID:(NSInteger)ID success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;


/**
 *  获取story的额外信息，例如：评论数、获赞数等
 *
 *  @param ID
 *  @param success
 */
+ (void)getExtraInfoWithStoryID:(NSInteger)ID success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;


/**
 *  获取开眼视频首页精选视频
 *
 *  @param success
 */
//+ (void)getKaiyanTodayVideoSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

/**
 *  根据一次请求的视频列表，请求指定日期的开眼视频
 *
 *  @param partNum 页数
 *  @param success
 */
//+ (void)getKaiyanMoreVideoWithPreDatePart:(NSInteger)partNum Success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

+ (void)getKaiyanVideoWithDate:(NSString *)date Success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure;




/**
 *  获取storyID 的短评
 *
 *  @param ID      storyID
 */
+ (void)getShortCommentFromStoryID:(NSInteger)ID success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;
/**
 *  获取指定author之前的20条短评
 *
 *  @param ID
 *  @param authorId authorId
 */
+ (void)getShortCommentFromStoryID:(NSInteger)ID beforeAuthorId:(NSInteger)authorId success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

/**
 *  获取storyID 的长评
 *
 *  @param ID      storyID
 */
+ (void)getLongCommentFromStoryID:(NSInteger)ID success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

/**
 *  获取指定author之前的20条长评
 *
 *  @param ID
 *  @param authorId authorId
 */
+ (void)getLongCommentFromStoryID:(NSInteger)ID beforeAuthorId:(NSInteger)authorId success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;


@end
