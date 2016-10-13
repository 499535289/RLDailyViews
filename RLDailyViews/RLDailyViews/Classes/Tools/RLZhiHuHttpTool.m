//
//  RLZhiHuHttpTool.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/22.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLZhiHuHttpTool.h"

#define BASEURL             @"http://news-at.zhihu.com/api/"//基础url
#define LATESTNEWS_URL      @"http://news-at.zhihu.com/api/4/news/latest"//最新消息
#define THEMES_URL          @"http://news-at.zhihu.com/api/4/themes"//主题日报列表
#define DETAIL_URL          @"http://news-at.zhihu.com/api/4/news/"//消息内容获取与离线下载，后接 id
#define HOTNEWS_URL         @"http://news-at.zhihu.com/api/4/news/hot"//热门消息
#define EXTRAINFO_URL       @"http://news-at.zhihu.com/api/4/story-extra/"//获取额外信息，后接 id
#define COMMENT_SHORT       @"http://news-at.zhihu.com/api/4/story/%ld/short-comments"//获取id的story的短评数据（一次最多显示20条）
#define COMMENT_LONG        @"http://news-at.zhihu.com/api/4/story/%ld/long-comments"//获取id的story的长评数据（一次最多显示20条）
#define COMMENT_SHORT_MORE  @"http://news-at.zhihu.com/api/4/story/%ld/short-comments/before/%ld"//更多短评
#define COMMENT_LONG_MORE  @"http://news-at.zhihu.com/api/4/story/%ld/long-comments/before/%ld"//更多长评

/*
 * 开眼每日精选视频的api接口
 * num：返回的最近num天内的视频列表；date：yyyyMMdd格式的日期；
 * 5日为一次请求
 */
#define KAIYAN_URL          @"http://baobab.wandoujia.com/api/v1/feed?num=1&date=%@&vc=67&u=011f2924aa2cf27aa5dc8066c041fe08116a9a0c&v=1.8.0&f=iphone"


@implementation RLZhiHuHttpTool

+ (void)getLatestNewsSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure{
    
    [RLBaseHttpTool GET:LATESTNEWS_URL paremeters:nil success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    }failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}


+ (void)getThemesListSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure{
    
    [RLBaseHttpTool GET:THEMES_URL paremeters:nil success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    }failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)getHotStoriesSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    [RLBaseHttpTool GET:HOTNEWS_URL paremeters:nil success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    }failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)getDetailWithStoryID:(NSInteger)ID success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure{
    
    [RLBaseHttpTool GET:[DETAIL_URL stringByAppendingString:[NSString stringWithFormat:@"%zd",ID]] paremeters:nil success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    }failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)getExtraInfoWithStoryID:(NSInteger)ID success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure{
    
    [RLBaseHttpTool GET:[EXTRAINFO_URL stringByAppendingString:[NSString stringWithFormat:@"%ld",ID]] paremeters:nil success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    }failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)getKaiyanTodayVideoSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure{
    //当天的精选视频
    NSDate * today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSString *dateStr = [dateFormatter stringFromDate:today];
    NSString *urlStr = [NSString stringWithFormat:KAIYAN_URL,dateStr];
    
    [RLBaseHttpTool GET:urlStr paremeters:nil success:^(id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    }failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)getKaiyanMoreVideoWithPreDatePart:(NSInteger)partNum Success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure{

    NSDate *preDate = [NSDate dateWithTimeIntervalSinceNow:-24*3600*1*partNum];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSString *dateStr = [dateFormatter stringFromDate:preDate];
    NSString *urlStr = [NSString stringWithFormat:KAIYAN_URL,dateStr];
    
    [RLBaseHttpTool GET:urlStr paremeters:nil success:^(id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    }failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)getKaiyanVideoWithDate:(NSString *)date Success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure{
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    dateFormatter.dateFormat = @"yyyyMMdd";
//    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    NSString *urlStr = [NSString stringWithFormat:KAIYAN_URL,date];
    
    [RLBaseHttpTool GET:urlStr paremeters:nil success:^(id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    }failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}







+ (void)getShortCommentFromStoryID:(NSInteger)ID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlStr = [NSString stringWithFormat:COMMENT_SHORT,ID];
    
    [RLBaseHttpTool GET:urlStr paremeters:nil success:^(id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
}
+ (void)getShortCommentFromStoryID:(NSInteger)ID beforeAuthorId:(NSInteger)authorId success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure{
    
    NSString *urlStr = [NSString stringWithFormat:COMMENT_SHORT_MORE,ID,authorId];
    
    [RLBaseHttpTool GET:urlStr paremeters:nil success:^(id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
}





+ (void)getLongCommentFromStoryID:(NSInteger)ID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    NSString *urlStr = [NSString stringWithFormat:COMMENT_LONG,ID];
    
    [RLBaseHttpTool GET:urlStr paremeters:nil success:^(id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
}
+ (void)getLongCommentFromStoryID:(NSInteger)ID beforeAuthorId:(NSInteger)authorId success:(void (^)(id responseObject))success failure:(void (^)(NSError *))failure{
    
    NSString *urlStr = [NSString stringWithFormat:COMMENT_LONG_MORE,ID,authorId];
    
    [RLBaseHttpTool GET:urlStr paremeters:nil success:^(id responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
}





@end
