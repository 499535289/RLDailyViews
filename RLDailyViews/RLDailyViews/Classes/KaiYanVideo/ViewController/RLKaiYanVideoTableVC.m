//
//  RLKaiYanVideoTableVC.m
//  RLDailyViews
//
//  Created by LiWei on 16/4/17.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLKaiYanVideoTableVC.h"
#import "RLZhiHuHttpTool.h"
#import "RLKaiYanCell.h"
#import "RLTransitionContainerView.h"
#import "KRVideoPlayerController.h"
#import <AVKit/AVKit.h>
#import "RLSqliteManager.h"
#import "RLGetDataTool.h"

#import "UMSocial.h"
#import <UMMobClick/MobClick.h>


@interface SDWebImageManager  (cache)

- (BOOL)memoryCachedImageExistsForURL:(NSURL *)url;

@end

@implementation SDWebImageManager (cache)

- (BOOL)memoryCachedImageExistsForURL:(NSURL *)url {
    NSString *key = [self cacheKeyForURL:url];
    return ([self.imageCache imageFromMemoryCacheForKey:key] != nil) ?  YES : NO;
}

@end




@interface RLKaiYanVideoTableVC ()<UIScrollViewDelegate,UIAlertViewDelegate,RLKaiYanContentViewDelegate>
@property (nonatomic,strong) NSMutableArray * dateArray;//日期数组
@property (nonatomic,strong) NSMutableDictionary * dateVideoDic;//日期为key，modelArray为value的字典

@property (nonatomic,strong) RLTransitionContainerView *containerView;

@property (nonatomic,strong) NSArray * selectedVideoArray;
@property (nonatomic,strong) NSIndexPath * currentIndexPath;

@property (nonatomic,strong) KRVideoPlayerController * videoPlayerController;

@property (nonatomic,assign) CGFloat currentOffsetX;

@property (nonatomic,copy) NSString * firstDate;
@property (nonatomic,copy) NSString * lastDate;

@property (nonatomic,strong) UILabel * rightTopLabel;

@property (nonatomic,weak) VideoModel * selectedModel;
//@property (nonatomic,strong) RLKaiYanCell * selectedCell;

@end

@implementation RLKaiYanVideoTableVC
- (NSMutableDictionary *)dateVideoDic{
    
    if (!_dateVideoDic) {
        _dateVideoDic = [NSMutableDictionary dictionary];
    }
    return _dateVideoDic;
    
}
- (NSMutableArray *)dateArray{
    if (!_dateArray) {
        _dateArray = [NSMutableArray array];
    }
    return _dateArray;
}

- (UILabel *)rightTopLabel{
    if (!_rightTopLabel) {
        _rightTopLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30 - 50, 7, 60, 30)];
        _rightTopLabel.textAlignment = NSTextAlignmentCenter;
        _rightTopLabel.textColor = [UIColor blackColor];
        _rightTopLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:14];
//        _rightTopLabel.backgroundColor = [UIColor grayColor];
    }
    return _rightTopLabel;
}



//排序算法函数
//NSInteger dateSort(id num1, id num2, void *context)
//{
//    int v1 = [num1 intValue];
//    int v2 = [num2 intValue];
//    if (v1 > v2)
//        return NSOrderedAscending;
//    else if (v1 < v2)
//        return NSOrderedDescending;
//    else
//        return NSOrderedSame;
//}

//按日期先后排序
NSComparisonResult (^dateComparatorBlock)(NSString *,NSString *) = ^(NSString *str1,NSString *str2){
    NSInteger number1 = [str1 integerValue];
    NSInteger number2 = [str2 integerValue];
    if (number1 > number2) {
        return NSOrderedAscending;//升序
    }else if (number1 < number2){
        return NSOrderedDescending;//降序
    }else{
        return NSOrderedSame;
    }
};


- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.navigationController.navigationBar addSubview:self.rightTopLabel];
    
    [self getVediosDataFromDbOrWithDate:[NSDate date]];
    
    [self.tableView registerClass:[RLKaiYanCell class] forCellReuseIdentifier:@"RLKaiYanCellID"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self initRefresh];
    
}


- (void)getVediosDataFromDbOrWithDate:(NSDate *)date{
    
    NSString *dateStr = [NSDate configureDateFormatter:date];
    
    [MBProgressHUD showLoadingAtView:self.view];
    [RLGetDataTool getVideosWithDate:dateStr success:^(id dateVideoDic) {
        
        self.dateVideoDic = (NSMutableDictionary *)dateVideoDic;
        self.dateArray = [[self.dateVideoDic.allKeys sortedArrayUsingComparator:dateComparatorBlock] mutableCopy];//日期数组降序排序
        if (self.dateArray.count) {
            self.firstDate = [self.dateArray firstObject];
            self.lastDate = [self.dateArray lastObject];
        }
        [self.tableView reloadData];
        
        [MBProgressHUD hideLoadingAtView:self.view];
    } failure:^(NSError *error) {

        [MBProgressHUD hideLoadingAtView:self.view];
    }];
}



- (void)getOnedayVideosWithDate:(NSDate *)date isUp:(BOOL)isUp{
    
    NSString *dateStr = [NSDate configureDateFormatter:date];
    
    [RLGetDataTool getOneDayVideosWithDate:dateStr success:^(id dateVideoDic) {
        
        NSDictionary * newDateVideoDic = (NSDictionary *)dateVideoDic;
        [self.dateVideoDic addEntriesFromDictionary:newDateVideoDic];
        
        self.dateArray = [[[self.dateVideoDic allKeys] sortedArrayUsingComparator:dateComparatorBlock] mutableCopy];//日期数组降序排序
        if (self.dateArray.count) {
            self.firstDate = [self.dateArray firstObject];
            self.lastDate = [self.dateArray lastObject];
        }
        
        [self.tableView reloadData];
        
        isUp ? [self.tableView.mj_footer endRefreshing]: [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD showDetailMsg:@"网络错误" atView:self.view];
        isUp ? [self.tableView.mj_footer endRefreshing]: [self.tableView.mj_header endRefreshing];
    }];
    
}



- (void)initRefresh{
    weakSelf(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        DLog(@"下拉刷新");
        [weakSelf loadNewData];

    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        DLog(@"上拉刷新");
        [weakSelf loadMoreData];
    }];
    self.tableView.mj_footer.automaticallyHidden = YES;
}

- (void)loadNewData{
    
    [self.tableView.mj_header beginRefreshing];
    if (self.firstDate) {
        NSString * todayStr = [NSDate configureDateFormatter:[NSDate date]];
        if ([self.firstDate isEqualToString:todayStr]) {
            DLog(@"加载后一天数据(已经是最新数据)");
            [self.tableView.mj_header endRefreshing];
        }else{
            DLog(@"加载后一天数据");
            NSDate *tomorrow = [NSDate tomorrowOfDateStr:self.firstDate];
            [self getOnedayVideosWithDate:tomorrow isUp:NO];
        }
    }else{
        DLog(@"无任何缓存数据，也无网络请求，下拉刷新从网络中请求最新数据");
        [self getOnedayVideosWithDate:[NSDate date] isUp:NO];
    }
    
    
}


- (void)loadMoreData{
    DLog(@"加载前一天数据");
    
    [self.tableView.mj_footer beginRefreshing];
    
    NSDate *yesterday = [NSDate yesterdayOfDateStr:self.lastDate];
    
    [self getOnedayVideosWithDate:yesterday isUp:YES];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dateArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dateVideoDic[self.dateArray[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RLKaiYanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RLKaiYanCellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    VideoModel *video = self.dateVideoDic[self.dateArray[indexPath.section]][indexPath.row];
    cell.videoModel = video;
    
    return cell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return PICTURE_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return 0.01f;
    }else{
        return 64.0;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (0 != section) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64.0)];
        UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64.0/2-15, SCREEN_WIDTH, 30)];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.textColor = [UIColor blackColor];
        dateLabel.font = [UIFont fontWithName:@"Baskerville-BoldItalic" size:15];
        NSString *date = self.dateArray[section];//20160629
        
        NSString *month = [date substringWithRange:NSMakeRange(4, 2)];
        NSString *day = [date substringFromIndex:6];
        
        dateLabel.text = [NSString stringWithFormat:@"- %@.%@  Nice Day -",month,day];
        [headerView addSubview:dateLabel];
        
        return headerView;
    }else{
        return nil;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"selected");
    
    self.currentIndexPath = indexPath;
    
    self.selectedVideoArray = self.dateVideoDic[self.dateArray[indexPath.section]];
    
    [self showImageAnimationWithIndexPath:indexPath];
    
}


- (void)showImageAnimationWithIndexPath:(NSIndexPath *)indexPath{
    
    RLKaiYanCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    self.selectedModel = cell.videoModel;
    
    CGRect rect = [cell convertRect:cell.bounds toView:nil];
    
    CGFloat offSetY = rect.origin.y - 64;
    
    if (offSetY < 0) {
        offSetY = 0;
    }
    
    
    _containerView = [[RLTransitionContainerView alloc]initWithFrame:CGRectMake(0.f, 64.f, SCREEN_WIDTH, SCREEN_HEIGHT - 64.f) modelArray:self.dateVideoDic[self.dateArray[indexPath.section]] index:indexPath.row offSetY:offSetY];
    _containerView.offSetY = offSetY;
    _containerView.rect = rect;
    _containerView.image = cell.coverImageView.image;
    
    _containerView.imageScrollView.delegate = self;
    _containerView.contentView.delegate = self;
    
    //增加往上快速滑动的手势
    UISwipeGestureRecognizer *swipGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeToDo:)];
    swipGesture.direction = UISwipeGestureRecognizerDirectionUp;
    swipGesture.numberOfTouchesRequired = 1;
    [_containerView addGestureRecognizer:swipGesture];
    
    
    [_containerView.playButton addTarget:self action:@selector(clickPlayerButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    [[UIApplication sharedApplication].keyWindow addSubview:_containerView];
    self.tabBarController.tabBar.hidden = !self.tabBarController.tabBar.hidden;
    [self.navigationController.view addSubview:_containerView];
    [_containerView animationShow];
}

- (void)swipeToDo:(UISwipeGestureRecognizer *)swipGestureRecognizer{
    
    NSLog(@"swipe");
    if (swipGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        [self.containerView removeFromSuperview];
        self.tabBarController.tabBar.hidden = !self.tabBarController.tabBar.hidden;
    }
    
}


- (void)clickPlayerButton:(UIButton *)btn{

    NSLog(@"videoplayer");

    AFNetworkReachabilityStatus currentNetStatus = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).currentNetStatus;
    DLog(@"net === %ld",currentNetStatus);

    switch (currentNetStatus) {
        case -1:
            DLog(@"未知网络网络");
            [MBProgressHUD showMsg:@"网络错误~" atView:self.containerView];
            break;
        case 0:
            DLog(@"无网络");
            [MBProgressHUD showMsg:@"网络错误~" atView:self.containerView];
            break;
        case 1:
            DLog(@"3G/4G流量")
            [self showAlertView];
            break;
        case 2:
            DLog(@"WiFi");
//            [self showAlertView]; //测试showAlterView
            [self addVideoPlayer];
            break;
    }
}


- (void)showAlertView{
    //ios8之后
    if (IOS_VERSION >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"网络提示" message:@"观看视频会消耗大量的3G/4G流量，是否确认观看？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *  action) {
            DLog(@"取消");
        }];
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *  action) {
            DLog(@"确认");
            [self addVideoPlayer];
        }];
        [alertController addAction:actionCancel];
        [alertController addAction:actionOK];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    
    //ios8 之前
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"网络提示" message:@"观看视频会消耗大量的3G/4G流量，是否确认观看？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];

    [alertView show];
    
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (1 == buttonIndex) {
        [alertView removeFromSuperview];
        [self addVideoPlayer];
        
    }
    
}
#pragma mark -

     
- (void)addVideoPlayer{
    [MobClick event:@"kaiyanVideoPlayer"];
    
    VideoModel *model = self.selectedVideoArray[self.currentIndexPath.row];
    NSURL *url = [NSURL URLWithString:model.playUrl];
    DLog(@"video URL = %@",model.playUrl);
    
    if (!self.videoPlayerController) {

        self.videoPlayerController = [[KRVideoPlayerController alloc] initWithFrame:[UIScreen mainScreen].bounds];
        __weak typeof(self)weakSelf = self;
        [self.videoPlayerController setDimissCompleteBlock:^{
            weakSelf.videoPlayerController = nil;

        }];
        
        self.videoPlayerController.contentURL = url;
        
        [self.videoPlayerController fullScreenButtonClick];
        
        [self.videoPlayerController showInWindow];
        
    }
}


     
     
#pragma mark - UIScrollDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_containerView.imageScrollView]) {
        self.currentOffsetX = scrollView.contentOffset.x;
    }
    
}


static NSString *dateStatic = nil;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_containerView.imageScrollView]) {

        for (RLImageContainer *subView in scrollView.subviews) {
            
            if ([subView respondsToSelector:@selector(imageOffset)] ) {
                [subView imageOffset];
            }
            
        }
        
        CGFloat x = scrollView.contentOffset.x;
        
        CGFloat off = ABS( ((int)x % (int)SCREEN_WIDTH) - SCREEN_WIDTH/2 ) /(SCREEN_WIDTH/2) ;//取绝对值
        
        //判断是左滑还是右滑
        // (int)x % ((int)SCREEN_WIDTH) 所得数为小于SCREEN_WIDTH的整数。
        CGFloat off2;
        if (x > self.currentOffsetX) {//左滑
            off2 = ( SCREEN_WIDTH - ((int)x % ((int)SCREEN_WIDTH))) /(SCREEN_WIDTH);
        }else if(x < self.currentOffsetX && ((int)x % ((int)SCREEN_WIDTH)) > 1){//右滑
            off2 = ((int)x % ((int)SCREEN_WIDTH)) /(SCREEN_WIDTH);
        }else{//pageend
            off2 = 1.0;
        }
        
        
        
        
        [UIView animateWithDuration:1.0 animations:^{
            _containerView.playButton.alpha = off;
            
            RLKaiYanContentView *contentView = _containerView.contentView;
            contentView.titleLabel.alpha = off2 ;
            contentView.categoryAndTimeLabel.alpha = off2;
            contentView.descriptionLabel.alpha = off2 ;
            contentView.blurImageView.alpha = off2 ;
            contentView.line.alpha = off2;
        }];
        
    }
    if ([scrollView isEqual:self.tableView]) {
//        NSInteger integer = [self.tableView sectionIndexMinimumDisplayRowCount];
//        NSLog(@"interg ==== %ld",integer);
//        CGFloat x = scrollView.contentOffset.y;
//        NSArray<RLKaiYanCell *> *array = [self.tableView visibleCells];
//        
//        [array enumerateObjectsUsingBlock:^(RLKaiYanCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
//            [obj cellOffset];
//        }];
        
        //监听tableview滑动到哪个section
        NSArray * indexPaths = [self.tableView indexPathsForVisibleRows];
        
        if (indexPaths.count) {
            NSIndexPath * topIndexPath = [indexPaths firstObject];
            NSString * date = self.dateArray[topIndexPath.section];//20160629

            if (![date isEqualToString:dateStatic]) {
                [self animationOfDate:date];
            }
        }
        
    }
    
}

/**
 *  右上角datelabel动画
 */
- (void)animationOfDate:(NSString *)date{
    NSString * month = [date substringWithRange:NSMakeRange(4, 2)];
    NSString * day = [date substringFromIndex:6];
    
    //执行动画
    [UIView animateWithDuration:0.3 animations:^{
        self.rightTopLabel.alpha = 0;//先隐藏
    } completion:^(BOOL finished) {
        if (finished) {
            BOOL isToday = [[NSDate configureDateFormatter:[NSDate date]] isEqualToString:date];//判断dateStr是否等于今天的date
            self.rightTopLabel.text = isToday ? @"Today" : [NSString stringWithFormat:@"%@.%@",month,day];
            dateStatic = date;
            [UIView animateWithDuration:0.8 animations:^{
                self.rightTopLabel.alpha = 1;//再显示
            }];
        }
    }];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_containerView.imageScrollView]) {
        
        self.currentOffsetX = scrollView.contentOffset.x;
        
        NSInteger index = floor((_containerView.imageScrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width) + 1;
        
        if (index != self.currentIndexPath.row) {
            
            
            self.currentIndexPath = [NSIndexPath indexPathForRow:index inSection:self.currentIndexPath.section];
            
            //        [self.tableView scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:(UITableViewScrollPositionMiddle) animated:NO];
            
            //        [self.tableView setNeedsDisplay];
            //        RLKaiYanCell *cell = [self.tableView cellForRowAtIndexPath:self.currentIndexPath];
            
            //        [cell cellOffset];
            
            //        CGRect rect = [cell convertRect:cell.bounds toView:nil];
            //        _rilegoule.animationTrans = cell.picture.transform;
            //        _rilegoule.offsetY = rect.origin.y;
            //        [self.dateVideoDic[self.dateArray[section]]
            
            self.selectedVideoArray = self.dateVideoDic[self.dateArray[self.currentIndexPath.section]];
            VideoModel *model = self.selectedVideoArray[index];
            self.selectedModel = model;
            
            self.containerView.contentView.videoModel = model;
            [self.containerView.contentView animationDisplay];
            
            
        }
        

        
    }
    
}

#pragma mark - RLKaiYanContentViewDelegate
- (void)clickShareBtn{
    DLog(@"设置代理成功");
    
    RLImageContainer *imageContainer = self.containerView.imageScrollView.imageContainerArray[self.currentIndexPath.row];//获取需要分享的图片
    
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    [UMSocialData defaultData].extConfig.title = self.selectedModel.title;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.selectedModel.playUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.selectedModel.playUrl;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMAppKey
                                      shareText:@"来自 @我们的视界"
                                     shareImage:imageContainer.imageView.image
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQzone]
                                       delegate:nil];
}




@end
