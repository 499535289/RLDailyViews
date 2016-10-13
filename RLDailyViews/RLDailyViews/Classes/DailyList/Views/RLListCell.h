//
//  RLListCell.h
//  RLDailyViews
//
//  Created by LiWei on 16/3/23.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryModel.h"
#import <SDWebImage/UIImageView+WebCache.h>



@interface RLListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *listImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *coverView;

@property (nonatomic,strong) TopStoryModel *topStory;

@end
