//
//  RLThemeCell.h
//  RLDailyViews
//
//  Created by LiWei on 16/3/23.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RLThemeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong) ThemeModel * theme;

@end
