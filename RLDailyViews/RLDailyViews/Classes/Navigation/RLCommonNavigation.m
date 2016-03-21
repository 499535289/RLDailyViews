//
//  RLCommonNavigation.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/17.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLCommonNavigation.h"
#import "RLProfileView.h"
#import "UIView+Extension.h"

@interface RLCommonNavigation ()<UINavigationControllerDelegate>
@property (strong,nonatomic) UIImageView * profileImage;
@property (nonatomic,getter=isUnfolded) BOOL unfolded;//展开

@property (strong,nonatomic) RLProfileView * profileView;

@end

@implementation RLCommonNavigation
- (UIImageView *)profileImage{
    if (!_profileImage) {
        _profileImage = [[UIImageView alloc]initWithImage:IMAGE(@"icon_profile_normal@2x.png")];
        _profileImage.userInteractionEnabled = YES;
        
        [_profileImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBack:)]];
        
    }
    
    return _profileImage;
}

- (RLProfileView *)profileView{
    
    
    if (!_profileView) {
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _profileView = [[RLProfileView alloc]initWithEffect:blur];
        
        _profileView.frame = CGRectMake(0, (self.navigationBar.height + StatusBar_HEIGHT), SCREEN_WIDTH, 0);

    }
    
    return _profileView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.topItem.title = @"每日观点";//顶部固定不变的title
    
    self.delegate = self;
    
    
    
}

- (void)clickBack:(id)sender{
    DLog(@"click");
    
    [self rotationAnimation];

}

- (void)rotationAnimation{

    //navigationBar 左侧图片按钮动画
    [UIView animateWithDuration:0.5f animations:^{
        if (_unfolded) {
            
            self.profileImage.transform = CGAffineTransformIdentity;//还原
            
            self.profileView.height = 0;
            
        }else{
            
            self.profileImage.transform = CGAffineTransformRotate(self.profileImage.transform, M_PI_2);//右选择90°
            
            self.profileView.height = SCREEN_HEIGHT - self.navigationBar.height - StatusBar_HEIGHT;;
            
        }
        
    } completion:^(BOOL finished) {
        if (finished) {
            _unfolded = !_unfolded;
        }
        
    }];
    
    
    
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (!_profileImage) {
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.profileImage];//左上角profileImage
    }
    
    if (!_profileView) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.profileView];//毛玻璃试图
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
