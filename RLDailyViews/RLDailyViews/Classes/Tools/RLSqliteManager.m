//
//  RLSqliteManager.m
//  RLDailyViews
//
//  Created by LiWei on 16/6/27.
//  Copyright © 2016年 LiWei. All rights reserved.
//
/**
 1、创建数据库
 2、打开数据库
 3、创建表
 
 
 */



#import "RLSqliteManager.h"


@interface RLSqliteManager ()
@property (nonatomic,strong) FMDatabaseQueue * dbQueue;//线程安全的数据库队列对象

@end



@implementation RLSqliteManager

/**
 static作用：1、生命周期加长（类初始化到程序结束）；2、将静态变量隐藏只供本文件使用；3、可以更新变量，而被访问时是最新的值；4、在类方法里面可以替代实例变量的作用。
 */
static id _instance = nil;
+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}



- (void)openDatebaseIfNeeded{
    
    //1、获取数据库路径
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dbPath = [documentPath stringByAppendingString:@"/rl_database.sqlite"];
    DLog(@"dbpath = %@",dbPath);
    //2、创建数据库
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    //3、创建表
    [self createKaiYanTable];
//    [self createDailyListTable];
}

- (void)createKaiYanTable{
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_kaiyan ('id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'jsonData' BLOB ,'date' TEXT UNIQUE);"];
        DLog(@"创建开眼表%@",flag?@"成功":@"失败");
    }];
    
}

- (void)insertKaiyanDataWithJSON:(NSData *)jsonData date:(NSString *)date{
    [_dbQueue inDatabase:^(FMDatabase *db) {
//insert or ignore into table
        BOOL flag = [db executeUpdate:@"INSERT OR IGNORE INTO t_kaiyan ('jsonData','date') VALUES (?,?)",jsonData,date];
        DLog(@"数据库表操作%@",flag?@"成功":@"失败");

    }];
}


- (NSDictionary *)queryKaiyanVideosFromDbWithDate:(NSString *)date allData:(BOOL)all{
    NSMutableDictionary *dateVideosDic = [NSMutableDictionary dictionary];
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        NSString *querySQL = all ? @"SELECT * FROM t_kaiyan ORDER BY date DESC LIMIT 5;" : [NSString stringWithFormat:@"SELECT * FROM t_kaiyan WHERE date = %@;",date];
//        DLog(@"querySQL = %@",querySQL);
        FMResultSet * result = [db executeQuery:querySQL];
        while ([result next]) {
            NSData * jsonData = [result dataForColumn:@"jsonData"];
            NSString * dateStr = [result stringForColumn:@"date"];
            NSArray * jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];//json格式转换为数组对象
            
            //转模型
            NSArray *dateVideoListArray = [VideoModel mj_objectArrayWithKeyValuesArray:jsonArray];
            
            [dateVideosDic setObject:dateVideoListArray forKey:dateStr];//以日期为key，以modelArray为value
            
        }
    }];
    DLog(@"dateVideosDic == %@",dateVideosDic);
    return (NSDictionary *)dateVideosDic;
}






- (void)createDailyListTable{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:@"" withArgumentsInArray:nil];
        DLog(@"创建知乎首页表%@",flag?@"成功":@"失败");
    }];
}

- (void)createHotStoryTable{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:@""];
        DLog(@"创建hot表%@",flag?@"成功":@"失败");
    }];
}



/**
 *  表的插入(增)、删、改操作。没有返回值的数据库操作
 *
 */
- (void)executeNonReturnSQL:(NSString *)sql{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:sql];
        DLog(@"数据库表操作%@",flag?@"成功":@"失败");
    }];
}






@end
