//
//  RLCommonNavigation.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/17.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLCommonNavigation.h"
#import "RLProfileViewController.h"
#import "RLProfileNavi.h"
#import "UIView+Extension.h"
#import "RLKaiYanVideoTableVC.h"
#import "RLDailyNewsController.h"
#import "RLHotNewsController.h"

//@class RLKaiYanVideoTableVC,RLDailyNewsController,RLHotNewsController;
@interface RLCommonNavigation ()<UINavigationControllerDelegate>
@property (strong,nonatomic) UIImageView * profileImage;
@property (nonatomic,getter=isUnfolded) BOOL unfolded;//展开

@end

@implementation RLCommonNavigation
- (UIImageView *)profileImage{
    if (!_profileImage) {
        _profileImage = [[UIImageView alloc]initWithImage:IMAGE(@"Action_Menu@3x.png")];
        _profileImage.userInteractionEnabled = YES;
        
        [_profileImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickProfile:)]];
        
    }
    return _profileImage;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *topTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, Scale_float(35))];
    topTitleLabel.text = @"view world";
    topTitleLabel.textAlignment = NSTextAlignmentCenter;
    topTitleLabel.font = [UIFont fontWithName:@"ChalkboardSE-Bold" size:Scale_float(16)];
    self.navigationBar.topItem.titleView = topTitleLabel;//顶部固定不变的title
    self.navigationBar.barTintColor = [UIColor whiteColor];
    self.delegate = self;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (void)clickProfile:(id)sender{
    
    RLProfileViewController *profileVC = [[RLProfileViewController alloc]init];
    RLProfileNavi *profileNavi = [[RLProfileNavi alloc]initWithRootViewController:profileVC];
    profileVC.title = @"个人中心";
    [self presentViewController:profileNavi animated:YES completion:nil];
    
    [self rotationAnimation];
}

- (void)rotationAnimation{
    DLog(@"animate");
    //navigationBar 左侧图片按钮动画
    [UIView animateWithDuration:0.25f animations:^{
        self.profileImage.transform = CGAffineTransformRotate(self.profileImage.transform, -M_PI_2);//左选转90°
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.25f animations:^{
                self.profileImage.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }
    }];
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (!_profileImage) {
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.profileImage];//左上角profileImage
    }

    if (![viewController isKindOfClass:[RLKaiYanVideoTableVC class]] && ![viewController isKindOfClass:[RLDailyNewsController class]] && ![viewController isKindOfClass:[RLHotNewsController class]]) {
        
        //自定义backBarButtonItem
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(0, 0, 44, 44);
        [_backBtn addTarget:self action:@selector(clickBackToPreVC) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setBackgroundImage:IMAGE(@"Action_Back.png") forState:UIControlStateNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:_backBtn];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    
}

- (void)clickBackToPreVC{
    [self popViewControllerAnimated:YES];
}



@end
