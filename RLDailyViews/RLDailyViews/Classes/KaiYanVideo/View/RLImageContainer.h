//
//  RLImageContainer.h
//  RLDailyViews
//
//  Created by LiWei on 16/4/22.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

@interface RLImageContainer : UIView

@property (nonatomic,strong) UIImageView *imageView;

- (instancetype)initWithFrame:(CGRect)frame withModel:(VideoModel *)model;

- (void)imageOffset;

//- (void)animationScaleOfImageView:(UIImageView *)imageView;

@end
