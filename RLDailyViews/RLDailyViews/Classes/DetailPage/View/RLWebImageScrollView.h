//
//  RLImageScrollView.h
//  RLDailyViews
//
//  Created by LiWei on 16/6/16.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RLWebImageScrollView : UIView
@property (nonatomic,copy) NSString * imageURLStr;


+ (void)showImageScrollViewWithURLStr:(NSString *)urlStr;


@end
