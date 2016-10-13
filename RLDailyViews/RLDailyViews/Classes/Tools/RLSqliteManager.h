//
//  RLSqliteManager.h
//  RLDailyViews
//
//  Created by LiWei on 16/6/27.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import <MJExtension/MJExtension.h>
#import "VideoModel.h"


@interface RLSqliteManager : NSObject



+ (instancetype)shareManager;

- (void)openDatebaseIfNeeded;

//开眼
- (void)insertKaiyanDataWithJSON:(NSData *)jsonData date:(NSString *)date;
- (NSDictionary *)queryKaiyanVideosFromDbWithDate:(NSString *)date allData:(BOOL)all;
//
//- (void)executeNonReturnSQL:(NSString *)sql;
//
//- (NSArray *)executeHasReturnSQL:(NSString *)sql;



@end
