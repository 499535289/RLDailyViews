//
//  AppDelegate.h
//  RLDailyViews
//
//  Created by LiWei on 16/3/15.
//  Copyright (c) 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic,strong) AFNetworkReachabilityManager * networkReachabilityManager;
@property (nonatomic,readonly,assign) AFNetworkReachabilityStatus currentNetStatus;


@end

