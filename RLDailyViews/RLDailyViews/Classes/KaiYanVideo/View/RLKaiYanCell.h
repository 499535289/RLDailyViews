//
//  RLKaiYanCell.h
//  RLDailyViews
//
//  Created by LiWei on 16/4/18.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"



#define PICTURE_HEIGHT   (777.0/2208.0)*SCREEN_HEIGHT   //picture高度占屏幕高度的比例

@interface RLKaiYanCell : UITableViewCell

@property (nonatomic,strong) UIImageView * coverImageView;//背景图片
@property (nonatomic,strong) UIView * coverView;//半透明蒙版
@property (nonatomic,strong) UILabel * titleLabel;//主标题
@property (nonatomic,strong) UILabel * categoryAndDurationLabel;//分类，时长

@property (nonatomic,strong) VideoModel * videoModel;

@end
