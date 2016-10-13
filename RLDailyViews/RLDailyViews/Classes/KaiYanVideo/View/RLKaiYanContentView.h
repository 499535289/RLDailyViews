//
//  RLKaiYanContentView.h
//  RLDailyViews
//
//  Created by LiWei on 16/4/19.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"


@protocol RLKaiYanContentViewDelegate <NSObject>
- (void)clickShareBtn;


@end

@interface RLKaiYanContentView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryAndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (weak, nonatomic) IBOutlet UIView *coverView;

@property (weak, nonatomic) IBOutlet UIImageView *blurImageView;
@property (weak, nonatomic) IBOutlet UIView *line;


@property (nonatomic,strong) VideoModel *videoModel;

@property (nonatomic,weak) id<RLKaiYanContentViewDelegate> delegate;

- (void)animationDisplay;

@end
