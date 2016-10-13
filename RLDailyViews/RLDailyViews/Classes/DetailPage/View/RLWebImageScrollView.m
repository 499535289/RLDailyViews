//
//  RLImageScrollView.m
//  RLDailyViews
//
//  Created by LiWei on 16/6/16.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLWebImageScrollView.h"
#import <SDWebImage/SDWebImageManager.h>
#import "MBProgressHUD+MJ.h"

static CGFloat const kRLAnimationDuration = 0.4f;

@interface RLWebImageScrollView ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIView * scaleView;
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UIButton * downloadBtn;

@property (nonatomic,strong) UIImage * imageSource;

@end

@implementation RLWebImageScrollView

+ (void)showImageScrollViewWithURLStr:(NSString *)urlStr{

}



#pragma getter
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bouncesZoom = YES;
        _scrollView.bounces = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.alpha = 0;
        
        
    }
    return _scrollView;
}

//缩放的view
- (UIView *)scaleView{
    if (!_scaleView) {
        _scaleView = [[UIView alloc]initWithFrame:self.scrollView.frame];
        _scaleView.backgroundColor = [UIColor clearColor];
        
        
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        singleTapGesture.numberOfTapsRequired = 1;
        [_scaleView addGestureRecognizer:singleTapGesture];
        
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
        doubleTapGesture.numberOfTapsRequired = 2;
        
        [_scaleView addGestureRecognizer:doubleTapGesture];
        
        
        [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
        
    }
    return _scaleView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UIButton *)downloadBtn{
    if (!_downloadBtn) {
        _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _downloadBtn.frame = CGRectMake(SCREEN_WIDTH - 20 - 10, SCREEN_HEIGHT - 20 - 10, 20, 20);
        _downloadBtn.alpha = 0;
        [_downloadBtn setBackgroundImage:[UIImage imageNamed:@"News_Picture_Save"] forState:UIControlStateNormal];
        [_downloadBtn addTarget:self action:@selector(saveImageToLocal) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _downloadBtn;
}




- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self initSubviews];
        
    }
    return self;
}


- (void)initSubviews{
    
    [self.scaleView addSubview:self.imageView];
    [self.scrollView addSubview:self.scaleView];
    [self addSubview:self.scrollView];
    [self addSubview:self.downloadBtn];
    
    [UIView animateWithDuration:kRLAnimationDuration animations:^{
        self.scrollView.alpha = 1;
        self.downloadBtn.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}


- (void)calculateImageFrame:(UIImage *)image{
    
    self.imageView.image = image;
    
    float scaleX = self.scrollView.width/image.size.width;
    float scaleY = self.scrollView.height/image.size.height;
    
    if (scaleX > scaleY)//图片宽度很小
    {
        NSLog(@"scaleX > scaleY");
        float imgViewWidth = image.size.width * scaleY;
        
        self.imageView.frame = CGRectMake( (self.scrollView.width - imgViewWidth)/2 , 0 ,imgViewWidth, self.scrollView.height);
        
    }else{
        NSLog(@"scaleX < scaleY");
        float imgViewHeight = image.size.height * scaleX;
        
        self.imageView.frame = CGRectMake(0, (self.scrollView.height - imgViewHeight)/2 ,self.scrollView.width, imgViewHeight);
    }
    
    self.imageView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    [UIView animateWithDuration:kRLAnimationDuration animations:^{
        self.imageView.transform = CGAffineTransformIdentity;
    }];
    
}

#pragma mark - UIScrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.scaleView;
}


- (void)setImageURLStr:(NSString *)imageURLStr{
    
    _imageURLStr = imageURLStr;
    
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
    progressHUD.mode = MBProgressHUDModeAnnularDeterminate;
    if (!self.imageSource) {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:imageURLStr] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //下载图片进度（MBHUD）
            progressHUD.progress = (receivedSize * 1.0) /(expectedSize * 1.0);
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            self.imageSource = image;
            
            [self calculateImageFrame:image];
            
            [progressHUD hide:YES];

        }];
    }
    

    
    
}


- (void)singleTap:(UIGestureRecognizer *)gest{
    
    NSLog(@"singleTap");
    
    [UIView animateWithDuration:kRLAnimationDuration animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            [self.imageView removeFromSuperview];
            [self.scaleView removeFromSuperview];
            [self.downloadBtn removeFromSuperview];
            [self.scrollView removeFromSuperview];
            [self removeFromSuperview];
        }
        
    }];
    
}

- (void)doubleTap{
    
    NSLog(@"doubleTap");
    
    [UIView animateWithDuration:kRLAnimationDuration animations:^{
        if (self.scrollView.zoomScale < 2.0) {
//            self.imageView.transform = CGAffineTransformMakeScale(2.0, 2.0);
            self.scrollView.zoomScale = 2.0;
        }else{
//            self.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.scrollView.zoomScale = 1.0;
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)saveImageToLocal{
    
    DLog(@"saveImageToLocal");
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [MBProgressHUD showError:@"无法读取相册"];
    }
    
    UIImageWriteToSavedPhotosAlbum(self.imageSource, self, @selector(image:didFinishedSaveWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)img didFinishedSaveWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    [MBProgressHUD showSuccess:@"已保存至相册"];
}




- (void)dealloc{
    DLog(@"self销毁了");
}


@end
