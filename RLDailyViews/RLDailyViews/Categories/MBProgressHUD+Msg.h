//
//  MBProgressHUD+Msg.h
//  RLDailyViews
//
//  Created by LiWei on 16/5/24.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

static CGFloat const kRLDlayTime = 1.5f;

@interface MBProgressHUD (Msg)

+(void)showMsg:(NSString *)msg atView:(UIView *)view;
+(void)showLoadingAtView:(UIView *)view;
+(void)hideLoadingAtView:(UIView *)view;
+(void)hideLoadingAndDspMsg:(NSString *)msg atView:(UIView *)theView;
+(void)showDetailMsg:(NSString *)msg atView:(UIView *)view;
+(void)hideLoadingAndDspDetailMsg:(NSString *)msg atView:(UIView *)theView;

@end
