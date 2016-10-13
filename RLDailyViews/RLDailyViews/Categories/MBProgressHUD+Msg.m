//
//  MBProgressHUD+Msg.m
//  RLDailyViews
//
//  Created by LiWei on 16/5/24.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "MBProgressHUD+Msg.h"

@implementation MBProgressHUD (Msg)

/**
 *  显示信息，并自动隐藏
 */
+(void)showMsg:(NSString *)msg atView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    //     hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = msg;
    hud.labelFont = [UIFont systemFontOfSize:14];
    [hud hide:YES afterDelay:kRLDlayTime];
}

/**
 *  显示详细信息，用于显示内容比较多的提示信息，自动隐藏
 *
 */
+(void)showDetailMsg:(NSString *)msg atView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    //hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.detailsLabelText = msg;
//    hud.dimBackground = YES;
    [hud hide:YES afterDelay:kRLDlayTime];
}

/**
 *  显示Loading，背景暗黑，但不自定隐藏
 *
 */
+(void)showLoadingAtView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.dimBackground = YES;
    //    hud.margin = 10.f;
    hud.labelText = NSLocalizedString(@"Loading", @"");
    hud.removeFromSuperViewOnHide = YES;
}

/**
 *  隐藏Loading 请配合showLoadingAtView使用
 *
 */
+(void)hideLoadingAtView:(UIView *)view{
    MBProgressHUD *HUD=[MBProgressHUD HUDForView:view];
    if(HUD!=nil){
        [HUD hide:YES];
    }
    
    //    [MBProgressHUD hideHUDForView:view animated:YES];
}


/**
 *  隐藏Loading再显示信息，请配合showLoadingAtView使用
 *
 */
+(void)hideLoadingAndDspMsg:(NSString *)msg atView:(UIView *)theView{
    MBProgressHUD *HUD=[MBProgressHUD HUDForView:theView];
    if(HUD!=nil){
        [HUD showAnimated:YES whileExecutingBlock:^{
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = msg;
            sleep(kRLDlayTime);
        } completionBlock:^{
        }];
    }
}


/**
 *  隐藏Loading再显示信息(内容比较多的信息)，请配合showLoadingAtView使用
 *
 */
+(void)hideLoadingAndDspDetailMsg:(NSString *)msg atView:(UIView *)theView{
    MBProgressHUD *HUD=[MBProgressHUD HUDForView:theView];
    if(HUD!=nil){
        [HUD showAnimated:YES whileExecutingBlock:^{
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = @"";
            HUD.detailsLabelText = msg;
            sleep(kRLDlayTime);
        } completionBlock:^{
        }];
    }
}



@end
