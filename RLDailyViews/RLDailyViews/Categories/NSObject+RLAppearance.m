//
//  NSObject+RLAppearance.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/18.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "NSObject+RLAppearance.h"

@implementation NSObject (RLAppearance)

+ (void)setAllAppearance{
    
    // NSAttributedString
    NSDictionary *selectedTextDic = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    [[UITabBarItem appearance] setTitleTextAttributes:selectedTextDic forState:UIControlStateSelected];
    
    NSDictionary *normalTextDic = @{NSFontAttributeName:[UIFont systemFontOfSize:14.f]};
    [[UITabBarItem appearance] setTitleTextAttributes:normalTextDic forState:UIControlStateNormal];
    
    
    
}


@end
