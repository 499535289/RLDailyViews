//
//  RLListCell.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/23.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLListCell.h"
#import "RLConstants.h"


@implementation RLListCell

- (void)setTopStory:(TopStoryModel *)topStory{
    
    _topStory = topStory;
    
    [_listImageView sd_setImageWithURL:[NSURL URLWithString:topStory.image] placeholderImage:nil];
    
    _titleLabel.text = topStory.title;
    
    
    {
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToDo:)];
        longPress.minimumPressDuration = 0.25;
        [self addGestureRecognizer:longPress];
    }
    
    
}


- (void)longPressToDo:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        self.titleLabel.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            
            self.coverView.alpha = 0;
            
        }];
        
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.titleLabel.alpha = 1;
            self.coverView.alpha = 0.3;
            
        }];
    }
    
}



@end
