//
//  RLBottomView.h
//  RLDailyViews
//
//  Created by LiWei on 16/4/6.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExtraInfoModel.h"

@protocol RLBottomViewDelegate <NSObject>

- (void)clickShortCommentsBtnIsShort:(BOOL)shortBtn;
- (void)clickLongCommentsBtnIsShort:(BOOL)shortBtn;
- (void)clickShareBtn;

@end


@interface RLBottomView : UIView

@property (weak, nonatomic) IBOutlet UIButton *popularityBtn;
@property (weak, nonatomic) IBOutlet UIButton *shortCommentsBtn;
@property (weak, nonatomic) IBOutlet UIButton *longCommentsBtn;

@property (nonatomic,assign) NSInteger storyID;


@property (nonatomic,strong) ExtraInfoModel * extraInfo;


@property (nonatomic,weak) id <RLBottomViewDelegate> delegate;
@end
