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
    
    NSDictionary *normalTextDic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [[UITabBarItem appearance] setTitleTextAttributes:normalTextDic forState:UIControlStateNormal];
    
    //title
    [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"ChalkboardSE-Bold" size:Scale_float(15)]};
    [UINavigationBar appearance].tintColor = [UIColor blackColor];
    //naviBar的uibarbutton
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"ChalkboardSE-Bold" size:Scale_float(13)]} forState:UIControlStateNormal];
}


@end
