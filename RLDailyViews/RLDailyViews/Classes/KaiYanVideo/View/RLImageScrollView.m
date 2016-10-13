//
//  RLImageScrollView.m
//  RLDailyViews
//
//  Created by LiWei on 16/4/19.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLImageScrollView.h"


@implementation RLImageScrollView

- (NSMutableArray *)imageContainerArray{
    if (!_imageContainerArray) {
        _imageContainerArray = [NSMutableArray array];
    }
    return _imageContainerArray;
}

- (instancetype)initWithFrame:(CGRect)frame modelArray:(NSArray *)modelArray index:(NSInteger)index{
    
    if (self = [super initWithFrame:frame]) {
    
        self.delegate = self;
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(width * modelArray.count, 0);
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.clipsToBounds = YES;
        
        for (int i = 0; i < modelArray.count; i ++) {
            VideoModel *model = modelArray[i];
            
            RLImageContainer *view = [[RLImageContainer alloc]initWithFrame:CGRectMake(i * width, 0, width, height) withModel:model];
            
            [self.imageContainerArray addObject:view];
            
            [self addSubview:view];
            
        }
        
        self.contentOffset = CGPointMake(width * index, 0.f);
        
    }
    
    return self;
}








@end
