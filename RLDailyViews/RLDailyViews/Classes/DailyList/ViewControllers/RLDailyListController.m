//
//  RLDailyListController.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/23.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLDailyListController.h"
#import "RLZhiHuHttpTool.h"
#import "RLListCell.h"

#import "RLDetailPageController.h"


@interface RLDailyListController ()
@property (nonatomic,strong) NSArray * topStories;

@end

@implementation RLDailyListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showLoadingAtView:self.view];
    
    [RLZhiHuHttpTool getLatestNewsSuccess:^(id responseObject) {
        
        [MBProgressHUD hideLoadingAtView:self.view];
        
        self.topStories = [TopStoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"top_stories"]];
        
        DLog(@"=====%@",self.topStories);
        
        [self.tableView reloadData];
    }failure:^(NSError *error) {
        [MBProgressHUD hideLoadingAtView:self.view];
    }];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.topStories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    RLListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RLListCellID"];
//    if (!cell) {
//        
//        cell = [[RLListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RLListCellID"];
//        
//    }
//    
//    TopStoryModel *topStory = self.topStories[indexPath.row];
//    
//    cell.topStory = topStory;

    
    return 0;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"DailyListTVC_to_DetailPageVC" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return SCREEN_WIDTH * 0.75;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"DailyListTVC_to_DetailPageVC"]) {
        RLDetailPageController *detailPage = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

        TopStoryModel *selectedStory = self.topStories[indexPath.row];
        
        detailPage.storyID = selectedStory.id;
    }
    
}


@end
