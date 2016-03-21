//
//  RLTabBarController.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/17.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLTabBarController.h"
#import "RLCommonNavigation.h"
#import "RLCustomTabBar.h"

@interface RLTabBarController ()<UITabBarControllerDelegate>

@end

@implementation RLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setChildViewControllers];
    
    [self setUpCustomTabBar];
    
    self.delegate = self;
    
}

- (void)setChildViewControllers{
    
    RLCommonNavigation * dailyListNav = VC_STORYBOARDID(@"DailyListNav");
    RLCommonNavigation * hotListNav = VC_STORYBOARDID(@"HotListNav");
    RLCommonNavigation * themesNav = VC_STORYBOARDID(@"ThemesNav");
    
    self.viewControllers = @[dailyListNav,hotListNav,themesNav];
    
}


- (void)setUpCustomTabBar{
    
    RLCustomTabBar *customTabBar = [[RLCustomTabBar alloc]initWithFrame:CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y+10, self.tabBar.frame.size.width, self.tabBar.frame.size.height-10)];
    
    customTabBar.items = self.tabBar.items;
    
    [customTabBar configureItems];
    
    [self.view addSubview:customTabBar];
    
    [self.tabBar removeFromSuperview];
    
    
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
