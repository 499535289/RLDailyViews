//
//  RLHotNewCell.h
//  RLDailyViews
//
//  Created by LiWei on 16/3/24.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotStoryModel.h"
#import "ExtraInfoModel.h"
#import "DetailStoryModel.h"
#import "RLZhiHuHttpTool.h"


@interface RLHotNewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *popularityLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;

@property (nonatomic,strong) HotStoryModel * hotStory;


@end
