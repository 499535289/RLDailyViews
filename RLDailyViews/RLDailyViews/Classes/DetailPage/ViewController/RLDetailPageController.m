//
//  RLDetailPageController.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/17.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLDetailPageController.h"
#import "DetailStoryModel.h"
#import "RLZhiHuHttpTool.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import "UIView+Extension.h"
#import "RLCommentViewController.h"
#import "RLWebImageScrollView.h"
#import "RLCommonNavigation.h"

#import "UMSocial.h"


@interface RLDetailPageController ()<UIWebViewDelegate,RLBottomViewDelegate,RLDetailPageJS2OCDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;

@property (nonatomic,strong) DetailStoryModel *detailStory;
@property (nonatomic,strong) UIButton *backButton;

@end

@implementation RLDetailPageController
- (RLBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[[NSBundle mainBundle] loadNibNamed:@"RLBottomView" owner:nil options:nil]lastObject];
        _bottomView.x = 0;
        _bottomView.y = SCREEN_HEIGHT - 44;
        _bottomView.width = SCREEN_WIDTH;
        _bottomView.height = 44;
        _bottomView.delegate = self;
    }
    return _bottomView;
}

#pragma mark - RLBottomViewDelegate
-(void)clickShortCommentsBtnIsShort:(BOOL)shortBtn{
    
    RLCommentViewController * commentViewController = [[RLCommentViewController alloc]init];
    commentViewController.storyID = self.storyID;
    commentViewController.isShortComment = shortBtn;
    commentViewController.navigationItem.title = [NSString stringWithFormat:@"短评（%ld条）",self.bottomView.extraInfo.short_comments];
    commentViewController.totalComments = self.bottomView.extraInfo.short_comments;
    [self.navigationController pushViewController:commentViewController animated:YES];
    
}
- (void)clickLongCommentsBtnIsShort:(BOOL)shortBtn{
    RLCommentViewController * commentViewController = [[RLCommentViewController alloc]init];
    commentViewController.storyID = self.storyID;
    commentViewController.isShortComment = shortBtn;
    commentViewController.navigationItem.title = [NSString stringWithFormat:@"长评（%ld条）",self.bottomView.extraInfo.long_comments];
    commentViewController.totalComments = self.bottomView.extraInfo.long_comments;
    [self.navigationController pushViewController:commentViewController animated:YES];
}
- (void)clickShareBtn{
    DLog(@"share代理方法");
    
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialData defaultData].extConfig.title = self.detailStory.title;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.detailStory.share_url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.detailStory.share_url;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMAppKey
                                      shareText:(self.detailStory.recommenders ? [NSString stringWithFormat:@"来自推荐者%@的文章",self.detailStory.recommenders] : @"来自 @知乎日报")
                                     shareImage:self.shareImage
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQzone]
                                       delegate:nil];
}


#pragma mark - setter
- (void)setStoryID:(NSInteger)storyID{
    NSLog(@"setStoryID");
    _storyID = storyID;
    
    [MBProgressHUD showLoadingAtView:self.view];
    
    [RLZhiHuHttpTool getExtraInfoWithStoryID:storyID success:^(id responseObject) {
        
        ExtraInfoModel *extraInfo = [ExtraInfoModel mj_objectWithKeyValues:responseObject];
        
        self.bottomView.extraInfo = extraInfo;
        self.bottomView.storyID = storyID;
        
        [RLZhiHuHttpTool getDetailWithStoryID:storyID success:^(id responseObject) {
            
            
            DetailStoryModel *detailStory = [DetailStoryModel mj_objectWithKeyValues:responseObject];
            DLog(@"html = %@",responseObject);
            //<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>
//            NSString *cssStr = @"<style type=\"text/css\">  .headline .img-place-holder {height: 0px;} </style>";//此处隐藏详情页的顶部图片区域。
            NSString *cssStr = @"<style type=\"text/css\">  .headline {display: none;} </style>";//此处隐藏详情页的顶部图片区域。
            detailStory.htmlUrl = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@>%@</head><body>%@</body></html>",detailStory.css[0],cssStr,detailStory.body];
            
            self.detailStory = detailStory;
        }failure:^(NSError *error) {
            [MBProgressHUD hideLoadingAtView:self.view];
        }];
        
    }failure:^(NSError *error) {
        [MBProgressHUD hideLoadingAtView:self.view];
    }];
    
}

- (void)setDetailStory:(DetailStoryModel *)detailStory{
    _detailStory = detailStory;
    
    [self.mainWebView loadHTMLString:detailStory.htmlUrl baseURL:nil];
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    NSLog(@"viewdidload contentSize = %@",NSStringFromCGSize(self.mainWebView.scrollView.contentSize));
//    self.mainWebView.scrollView.bounces = NO;
    
    
    [self.view addSubview:self.bottomView];
}

#pragma mark - UIWebView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    DLog(@"--------webViewDidFinishLoad-------");

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //调整字号
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'";
    [webView stringByEvaluatingJavaScriptFromString:str];
    
    
    //js方法遍历图片添加点击事件 返回图片个数
    //js调用OC方法
    static  NSString * const jsGetImages =
    @"function getImages(){\
        var objs = document.getElementsByTagName(\"img\");\
        for(var i=0;i<objs.length;i++){\
            objs[i].onclick=function(){\
                viewController.clickImageWithURLStr(this.src);\
            };\
        };\
        return objs.length;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    
    //js调用OC方法设置
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"viewController"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception){
        context.exception = exception;
        DLog(@"异常信息：%@",exception);
        
    };
    
}


- (void)clickImageWithURLStr:(NSString *)imageURLStr{
    
    DLog(@"clickImg = %@",[NSThread currentThread]);
    
    //注入html的js方法是在子线程运行的
    dispatch_async(dispatch_get_main_queue(), ^{
        DLog(@"js回调oc方法，参数为= %@",imageURLStr);
        DLog(@"clickImg = %@",[NSThread currentThread]);
        RLWebImageScrollView *webImageScrollView = [[RLWebImageScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        
        [self.navigationController.view addSubview:webImageScrollView];
        
        webImageScrollView.imageURLStr = imageURLStr;
    });
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
 
    NSString *str = request.URL.absoluteString;
    DLog(@"shoudStartLoad===str = %@",str);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD hideLoadingAtView:self.view];
    
}

@end
