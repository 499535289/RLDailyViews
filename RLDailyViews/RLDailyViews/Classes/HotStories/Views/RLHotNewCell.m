//
//  RLHotNewCell.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/24.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLHotNewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RLConstants.h"
#import "RLHotNewsController.h"


@interface RLHotNewCell ()
//@property (nonatomic,strong) ExtraInfoModel *extraInfo;

@end


@implementation RLHotNewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setHotStory:(HotStoryModel *)hotStory{
    
    _hotStory = hotStory;
    
    _titleLabel.text = hotStory.title;
    
    [_contentImageView sd_setImageWithURL:[NSURL URLWithString:hotStory.thumbnail] placeholderImage:nil];
    
    
    //请求到 额外信息
    //如果内存中的模型有这个属性值则直接取出，如果没有则网络请求（确保每个模型只请求一次）
    if (hotStory.popularity && hotStory.comments) {
        _popularityLabel.text = [NSString stringWithFormat:@"%ld",hotStory.popularity];
        _commentsLabel.text = [NSString stringWithFormat:@"%ld",hotStory.comments];
    }else{
        [RLZhiHuHttpTool getExtraInfoWithStoryID:hotStory.news_id success:^(id responseObject) {
            
            ExtraInfoModel *extraInfo = [ExtraInfoModel mj_objectWithKeyValues:responseObject];
            
            _popularityLabel.text = [NSString stringWithFormat:@"%ld",extraInfo.popularity];
            _commentsLabel.text = [NSString stringWithFormat:@"%ld",extraInfo.comments];
            
            hotStory.popularity = extraInfo.popularity;
            hotStory.comments = extraInfo.comments;
            
        }failure:^(NSError *error) {
            
        }];
    }
    
    
    //请求到图片信息
//    [RLZhiHuHttpTool getDetailWithStoryID:hotStory.news_id success:^(id responseObject) {
//        
//        DetailStoryModel *detailStory = [DetailStoryModel mj_objectWithKeyValues:responseObject];
//        
//        [_contentImageView sd_setImageWithURL:[NSURL URLWithString:detailStory.image] placeholderImage:nil];
//        
//        _contentImageView.alpha = kRLImageViewAlpha;
//    }];
    
    
}





@end
