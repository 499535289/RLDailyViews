//
//  RLPlaceholderView.h
//  RLDailyViews
//
//  Created by LiWei on 16/5/24.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RLPlaceholderViewDelegate <NSObject>

- (void)clickReloadBtn;

@end

@interface RLPlaceholderView : UIView

@property (nonatomic,weak) id <RLPlaceholderViewDelegate> delegate;

@end
