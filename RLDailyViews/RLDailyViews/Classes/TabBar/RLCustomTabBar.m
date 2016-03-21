//
//  RLCustomTabBar.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/17.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLCustomTabBar.h"

@implementation RLCustomTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
       
        
    }
    return self;
}

- (void)configureItems{
    
    int i = 0;
    
    for (UITabBarItem *item in self.items) {
        
        if (0 == i) {
            item.title = @"每日精选";
            self.selectedItem = item;
        }else if (1 == i){
            item.title = @"热门消息";
        }else{
            item.title = @"主题日报";
        }
        
        item.titlePositionAdjustment = UIOffsetMake(0, -20);
        
        
        i ++;
        
    }
    
    
    
}


@end
