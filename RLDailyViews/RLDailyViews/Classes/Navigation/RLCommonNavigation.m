//
//  RLCommonNavigation.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/17.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLCommonNavigation.h"

@interface RLCommonNavigation ()<UINavigationControllerDelegate>

@end

@implementation RLCommonNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
}

- (void)clickBack:(id)sender{
    
    NSLog(@"clickBack");
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickBack:)];

    viewController.navigationItem.leftBarButtonItem = backItem;
    
    viewController.title = @"今日精选";
    
    
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
