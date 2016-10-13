//
//  RLKaiYanContentView.m
//  RLDailyViews
//
//  Created by LiWei on 16/4/19.
//  Copyright © 2016年 LiWei. All rights reserved.
//


#import "RLKaiYanContentView.h"

@implementation RLKaiYanContentView

- (void)setVideoModel:(VideoModel *)videoModel{
    
    _videoModel = videoModel;
    
    _titleLabel.text = videoModel.title;
    
    NSString *timeStr = [NSString stringWithFormat:@"%02ld'%02ld''",videoModel.duration / 60, videoModel.duration % 60];
    _categoryAndTimeLabel.text = [NSString stringWithFormat:@"#%@  /  %@",videoModel.category,timeStr];
    
    _descriptionLabel.text = videoModel.descrip;
    
    _collectionCountLabel.text = [@(videoModel.collectionCount) stringValue];
    
    _shareCountLabel.text = [@(videoModel.shareCount) stringValue];
    
    _replyCountLabel.text = [@(videoModel.replyCount) stringValue];
    
    [_blurImageView sd_setImageWithURL:[NSURL URLWithString:videoModel.coverBlurred] placeholderImage:nil];


    
}



- (void)animationDisplay{
    
//    _blurImageView.alpha = 0.5;
//    _coverView.alpha = 0.8;
    
    [UIView animateWithDuration:1 animations:^{
        
        _blurImageView.alpha = 1;
//        _coverView.alpha = 0.3;
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - IBAction
- (IBAction)share:(UIButton *)sender {
    DLog(@"开眼分享");
    if ([self.delegate respondsToSelector:@selector(clickShareBtn)]) {
        [self.delegate clickShareBtn];
    }
}

- (IBAction)collection:(UIButton *)sender {
    DLog(@"开眼收藏");
    sender.selected = !sender.selected;
}

- (IBAction)comment:(UIButton *)sender {
    DLog(@"开眼评论");
}

- (IBAction)download:(UIButton *)sender {
    DLog(@"开眼下载为缓存");
}

@end
