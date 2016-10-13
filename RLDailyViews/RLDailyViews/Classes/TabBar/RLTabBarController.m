//
//  RLTabBarController.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/17.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLTabBarController.h"
#import "RLCommonNavigation.h"

@interface RLTabBarController ()<UITabBarControllerDelegate>

@end

@implementation RLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setChildViewControllers];
    
    self.delegate = self;
    
}

- (void)setChildViewControllers{
    
//    RLCommonNavigation * dailyListNav = VC_STORYBOARDID(@"DailyListNav");
    RLCommonNavigation * hotListNav = VC_STORYBOARDID(@"HotListNav");
    RLCommonNavigation * dailyNewsNav = VC_STORYBOARDID(@"DailyNewsNav");
    RLCommonNavigation * kaiyanNav = VC_STORYBOARDID(@"KaiyanNav");
    
    self.viewControllers = @[kaiyanNav,dailyNewsNav,hotListNav];
    
    [self configureItems];

}



- (void)configureItems{
    
    int i = 0;
    
    for (UITabBarItem *item in self.tabBar.items) {
        
        if (0 == i) {
            item.title = @"精选视频";
        }else if (1 == i){
            item.title = @"精选日报";
        }else if (2 == i){
            item.title = @"热门话题";
        }
        
        item.titlePositionAdjustment = UIOffsetMake(0, -15);
        
        
        i ++;
        
    }

}



- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController*)viewController
{
    //[UIView beginAnimations:nil context:nil];
    //[UIView setAnimationDuration:1];
    //[UIView setAnimationBeginsFromCurrentState:NO];
    //[UIView setAnimationCurve:UIViewAnimationTransitionFlipFromLeft];
    //[UIView setAnimationTransition:kCATransitionMoveIn forView:tabBarController.view cache:YES];
    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:viewController.view cache:NO];
    //[viewController.view removeFromSuperview];
    //[UIView commitAnimations];
    CATransition *animation =[CATransition animation];
    [animation setDuration:0.5f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//    [animation setType:kCATransitionMoveIn];
//    [animation setSubtype:kCATransitionFromRight];
    [tabBarController.view.layer addAnimation:animation forKey:@"reveal"];
    
    
    
    
    return YES;
}




@end
