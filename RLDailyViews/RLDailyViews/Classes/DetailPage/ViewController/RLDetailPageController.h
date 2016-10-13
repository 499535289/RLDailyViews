//
//  RLDetailPageController.h
//  RLDailyViews
//
//  Created by LiWei on 16/3/17.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLBottomView.h"

#import <JavaScriptCore/JavaScriptCore.h>

@protocol RLDetailPageJS2OCDelegate <JSExport>

- (void)clickImageWithURLStr:(NSString *)imageURLStr;

@end

@interface RLDetailPageController : UIViewController
@property (nonatomic,assign) NSInteger storyID;
@property (nonatomic,strong) UIImage * shareImage;//用来接收上一个页面cell的网络背景图片
@property (nonatomic,weak) RLBottomView *bottomView;

@property (nonatomic,strong) JSContext * jsContext;

@end
