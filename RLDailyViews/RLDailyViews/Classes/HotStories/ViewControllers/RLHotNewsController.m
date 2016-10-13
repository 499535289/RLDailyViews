//
//  RLHotNewsController.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/24.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLHotNewsController.h"
#import "RLZhiHuHttpTool.h"
#import "RLHotNewCell.h"
#import "HotStoryModel.h"
#import "ExtraInfoModel.h"

#import "RLDetailPageController.h"

@interface RLHotNewsController ()<UITableViewDelegate,RLPlaceholderViewDelegate>
@property (nonatomic,strong) NSArray * hotStories;
@property (nonatomic,strong) ExtraInfoModel *extraInfo;

@property (nonatomic,strong) RLPlaceholderView * placeholderView;


@end

@implementation RLHotNewsController
- (RLPlaceholderView *)placeholderView{
    if (!_placeholderView) {
        _placeholderView = [[[NSBundle mainBundle] loadNibNamed:@"RLPlaceholderView" owner:nil options:nil]lastObject];;
        _placeholderView.frame = self.view.frame;
        _placeholderView.delegate = self;
    }
    return _placeholderView;
}

- (void)clickReloadBtn{
    DLog(@"click");
    [self viewDidLoad];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    AFNetworkReachabilityStatus currentNetStatus = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).currentNetStatus;
    DLog(@"net === %ld",currentNetStatus);
    if (currentNetStatus < 1) {
        
        if (self.placeholderView) {
            [self.placeholderView removeFromSuperview];
        }
        [self.view addSubview:self.placeholderView];
        
    }else{
        
        if (self.placeholderView) {
            [self.placeholderView removeFromSuperview];
        }
    
    [MBProgressHUD showLoadingAtView:self.view];
    
    [RLZhiHuHttpTool getHotStoriesSuccess:^(id responseObject) {
        
        [MBProgressHUD hideLoadingAtView:self.view];
        
        self.hotStories = [HotStoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"recent"]];
        
        [self.tableView reloadData];
        
    }failure:^(NSError *error) {
        [MBProgressHUD hideLoadingAtView:self.view];
    }];
    
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.hotStories.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RLHotNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RLHotNewCellID" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[RLHotNewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RLHotNewCellID"];

    }
    
    HotStoryModel *hotStory = self.hotStories[indexPath.row];
    
    cell.hotStory = hotStory;
    
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"HotNewsTVC_to_DetailPageVC" sender:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"HotNewsTVC_to_DetailPageVC"]) {
        RLDetailPageController *detailPage = segue.destinationViewController;
        RLHotNewCell *cell = (RLHotNewCell *)[self.tableView cellForRowAtIndexPath:(NSIndexPath *)sender];
        
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        HotStoryModel *selectedStory = self.hotStories[indexPath.row];
        HotStoryModel *selectedStory = cell.hotStory;
        detailPage.storyID = selectedStory.news_id;
        detailPage.title = selectedStory.title;
        detailPage.shareImage = cell.contentImageView.image;
        
        detailPage.hidesBottomBarWhenPushed = YES;
    }
    
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
