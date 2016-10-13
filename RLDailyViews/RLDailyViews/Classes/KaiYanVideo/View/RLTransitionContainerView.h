//
//  RLTransitionView.h
//  RLDailyViews
//
//  Created by LiWei on 16/4/19.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLImageScrollView.h"
#import "RLKaiYanContentView.h"
#import "RLKaiYanCell.h"

@protocol RLTransitionContainerViewDelegate <NSObject>

- (void)imageScrollToIndex:(NSInteger)index;

@end



@interface RLTransitionContainerView : UIView

@property (nonatomic,strong) RLImageScrollView * imageScrollView;
@property (nonatomic,strong) RLKaiYanContentView * contentView;
@property (nonatomic,strong) RLKaiYanCell * selectedCell;

@property (nonatomic,strong) UIButton * playButton;//播放按钮图片

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,assign) CGFloat offSetY;
@property (nonatomic,assign) CGRect rect;
@property (nonatomic,strong) UIImage * image;

@property (nonatomic,weak) id<RLTransitionContainerViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame modelArray:(NSArray *)modelArray index:(NSInteger)index offSetY:(CGFloat)offSetY;


- (void)animationShow;

@end
