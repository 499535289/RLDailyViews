//
//  RLImageScrollView.h
//  RLDailyViews
//
//  Created by LiWei on 16/4/19.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLImageContainer.h"


@interface RLImageScrollView : UIScrollView<UIScrollViewDelegate>


- (instancetype)initWithFrame:(CGRect)frame modelArray:(NSArray *)modelArray index:(NSInteger)index;

@property (nonatomic,strong) NSMutableArray * imageContainerArray;

@end
