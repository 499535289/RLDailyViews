//
//  RLTabBarController.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/17.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLTabBarController.h"
#import "RLCustomTabBar.h"

@interface RLTabBarController ()<UITabBarControllerDelegate>

@end

@implementation RLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    RLCustomTabBar *customTabBar = [[RLCustomTabBar alloc]initWithFrame:CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y+10, self.tabBar.frame.size.width, self.tabBar.frame.size.height-10)];
    

    [self.view addSubview:customTabBar];
    
    [self.tabBar removeFromSuperview];
    
//    self.tabBar.frame = CGRectMake(0, 0, 200, 20);
    
//    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
//    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
//    
//    label1.text = @"标签1";
//    label2.text = @"22";
//    
//    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:label1];
//    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:label2];
//    
//    [self.tabBar setItems:@[item1,item2]];
    
    
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
    [animation setDuration:0.75f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//    [animation setType:kCATransitionMoveIn];
//    [animation setSubtype:kCATransitionFromRight];
    [tabBarController.view.layer addAnimation:animation forKey:@"reveal"];
    
    NSLog(@"shouldSelect");
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
