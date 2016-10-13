//
//  RLProfileViewController.m
//  RLDailyViews
//
//  Created by LiWei on 16/6/19.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLProfileViewController.h"

@interface RLProfileViewController ()
@property (nonatomic,strong) UIScrollView * scrollView;

@end

@implementation RLProfileViewController

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 1.1);
        
        NSArray *profileViews = [[NSBundle mainBundle]loadNibNamed:@"ProfileView" owner:self options:nil];
        
        UIView *topView = profileViews[0];
        topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200.0);
        [_scrollView addSubview:topView];
        
        
        UIView *bottomView = profileViews[1];
        bottomView.frame = CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT * 1.1 - 200.0);
        [_scrollView addSubview:bottomView];
        
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(clickLeftItem)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self initBackgroudView];
    
    [self.view addSubview:self.scrollView];
    
}

- (void)initBackgroudView{
    UIImageView *bgImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_profile"]];
    bgImg.frame = self.view.frame;
    [self.view addSubview:bgImg];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *bgBlurView = [[UIVisualEffectView alloc]initWithEffect:blur];
    bgBlurView.frame = self.view.frame;
    [self.view addSubview:bgBlurView];
}


- (void)clickLeftItem{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - xib action
- (IBAction)loginBtn:(id)sender {
    DLog(@"login");
    
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor blueColor];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}




@end
