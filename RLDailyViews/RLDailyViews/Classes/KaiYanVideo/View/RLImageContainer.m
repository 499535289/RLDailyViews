//
//  RLImageContainer.m
//  RLDailyViews
//
//  Created by LiWei on 16/4/22.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLImageContainer.h"

@implementation RLImageContainer

- (instancetype)initWithFrame:(CGRect)frame withModel:(VideoModel *)model{
    
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        
        _imageView = [[UIImageView alloc]init];
        _imageView.center = self.center;
        _imageView.width = self.width;
        _imageView.height = self.height;
        _imageView.x = 0;
        _imageView.y = 0;
        [_imageView sd_setImageWithURL:[NSURL URLWithString:model.coverForDetail] placeholderImage:nil options:SDWebImageTransformAnimatedImage];
        
//        [self animationScaleOfImageView:_imageView];
        
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_imageView];
        
    }
    return self;
}


//图片偏移
- (void)imageOffset {
    
    CGRect centerToWindow = [self convertRect:self.bounds toView:nil];
    
    CGFloat centerX = CGRectGetMidX(centerToWindow);
    CGPoint windowCenter = self.window.center;

    CGFloat cellOffsetX = centerX - windowCenter.x;
    
    CGFloat offsetDig =  cellOffsetX / self.window.frame.size.height *2;
    
    CGAffineTransform transX = CGAffineTransformMakeTranslation(- offsetDig * SCREEN_WIDTH , 0);
    
    self.imageView.transform = transX;
}




//- (void)animationScaleOfImageView:(UIImageView *)imageView{
//    
//    [UIView animateWithDuration:3.0 delay:1.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//        [self scaleImage:imageView withScale:1.2f];
//    } completion:^(BOOL finished) {
//        if (finished) {
//            [UIView animateWithDuration:3.0 animations:^{
//                imageView.transform = CGAffineTransformIdentity;
//            } completion:^(BOOL finished) {
//                
//            }];
//        }
//    }];
//    
//}
//
//- (void)scaleImage:(UIImageView *)imageView withScale:(CGFloat)scale{
//    
//    imageView.transform = CGAffineTransformScale(imageView.transform,scale, scale);
//    
//}


@end
