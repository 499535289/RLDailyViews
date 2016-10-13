//
//  AppDelegate.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/15.
//  Copyright (c) 2016年 LiWei. All rights reserved.
//

#import "AppDelegate.h"
#import "RLTabBarController.h"
#import "NSObject+RLAppearance.h"
#import "MBProgressHUD+Msg.h"
#import "RLSqliteManager.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import <UMMobClick/MobClick.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
- (AFNetworkReachabilityManager *)networkReachabilityManager{
    if (!_networkReachabilityManager) {
        _networkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    }
    return _networkReachabilityManager;
}

//网络监测
- (void)checkNetworkStatus{
    
    __block typeof(self) weakSelf = self;
    [self.networkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:// -1
                DLog(@"未知网络");
                [MBProgressHUD showMsg:@"网络异常!" atView:weakSelf.window];
                break;
            case AFNetworkReachabilityStatusNotReachable:// 0
                DLog(@"无网络");
                [MBProgressHUD showMsg:@"网络错误,请检查网络后重试" atView:weakSelf.window];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:// 1
                DLog(@"流量网络");
                [MBProgressHUD showMsg:@"目前是3G/4G流量,上网请节制噢~" atView:weakSelf.window];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:// 2
                DLog(@"wifi网络");
                [MBProgressHUD showMsg:@"目前已连接WiFi,请放肆使用~" atView:weakSelf.window];
                break;
        }
        _currentNetStatus = status;
        
    }];
    
    [self.networkReachabilityManager startMonitoring];
}

void UncaughtExceptionHandler(NSException *exception){
    // 异常日志获取
    NSArray  *excpArr = [exception callStackSymbols];//调用栈
    NSString *reason = [exception reason];//原因
    NSString *name = [exception name];//类型
    
    NSString *excpCnt = [NSString stringWithFormat:@"exceptionType: %@ \n reason: %@ \n stackSymbols: %@",name,reason,excpArr];
    
    // 日常日志保存（可以将此功能单独提炼到一个方法中）
    NSArray  *dirArr  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dirPath = dirArr[0];
    NSString *logDir = [dirPath stringByAppendingString:@"/CrashLog"];
    
    BOOL isExistLogDir = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logDir]) {
        isExistLogDir = [fileManager createDirectoryAtPath:logDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if (isExistLogDir) {
        // 此处可扩展
        NSString *logPath = [logDir stringByAppendingString:@"/crashLog.txt"];
        [excpCnt writeToFile:logPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);//捕获崩溃日志
    

    [NSObject setAllAppearance];//全局设置
    
    [[RLSqliteManager shareManager] openDatebaseIfNeeded];
    
    [self checkNetworkStatus];
    
    //设置友盟统计
    /*
     UMConfigInstance为SDK参数配置的实例类，只需要将其成员中标注为required的参数赋值，optional的为可选项。
     appKey为开发者在友盟后台申请的应用Appkey（Appkey可在统计后台的 “统计分析->设置->应用信息” 页面查看）；
     ChannelId的值为应用的渠道标识。默认为 @"App Store"。
     */
    UMConfigInstance.appKey = UMAppKey;
    UMConfigInstance.channelId = @"RLViewWorld_channelId";
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick setLogEnabled:YES];
    
    
    //boundleID = LiWei.$(PRODUCT_NAME:rfc1034identifier)
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMAppKey];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:Wechat_AppId appSecret:Wechat_AppSecret url:@"http://www.baidu.com/"];
    
    
//    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
//    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                          secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    

    return YES;
}


//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        //调用其他SDK，例如支付宝SDK等
//    }
//    return result;
//}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
