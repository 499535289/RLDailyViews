//
//  RLTransitionView.m
//  RLDailyViews
//
//  Created by LiWei on 16/4/19.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLTransitionContainerView.h"

@implementation RLTransitionContainerView

- (instancetype)initWithFrame:(CGRect)frame modelArray:(NSArray *)modelArray index:(NSInteger)index offSetY:(CGFloat)offSetY{
    self.index = index;
    if (self = [super initWithFrame:frame]) {
        
        VideoModel *model = modelArray[index];
        
        _contentView = [[[NSBundle mainBundle] loadNibNamed:@"RLKaiYanContentView" owner:self options:nil] lastObject];
        _contentView.layer.masksToBounds = YES;
        _contentView.frame = CGRectMake(0, offSetY, SCREEN_WIDTH, self.height - SCREEN_WIDTH);
        _contentView.videoModel = model;
        [self addSubview:_contentView];
        
        
        _imageScrollView = [[RLImageScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) modelArray:modelArray index:index];
        _imageScrollView.backgroundColor = [UIColor redColor];
        [self addSubview:_imageScrollView];
        _imageScrollView.alpha = 0;//先隐藏
        
        
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.bounds = CGRectMake(0, 0, 71.f, 71.f);
        _playButton.center = _imageScrollView.center;
        [_playButton setBackgroundImage:[UIImage imageNamed:@"video-play@3x"] forState:UIControlStateNormal];
        [self addSubview:_playButton];
        _playButton.alpha = 0;
        
        
        
    }
    
    return self;
}



- (void)animationShow{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.offSetY, self.rect.size.width, self.rect.size.height)];
    view.layer.masksToBounds = YES;
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:self.image];
    imageView.center = view.center;
    imageView.width = SCREEN_WIDTH;
    imageView.height = SCREEN_WIDTH;
    imageView.x = 0;
    imageView.y = 0;
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;

    [view addSubview:imageView];
    [self addSubview:view];
    
    
    
    [UIView animateWithDuration:0.5 animations:^{

        
        
        view.transform = CGAffineTransformMakeTranslation(0, SCREEN_WIDTH/2 - self.offSetY - PICTURE_HEIGHT/2);
        view.height = SCREEN_WIDTH;
        view.y = 0;
        
        _contentView.layer.frame = CGRectMake(0, SCREEN_WIDTH, SCREEN_WIDTH, self.height - SCREEN_WIDTH);
        
        
        
    } completion:^(BOOL finished) {
        
        [view removeFromSuperview];
        
        _imageScrollView.alpha = 1;
        _playButton.alpha = 1;
        
        
        
    }];

}






@end
