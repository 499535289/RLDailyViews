//
//  RLCommentViewController.m
//  RLDailyViews
//
//  Created by LiWei on 16/6/7.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLCommentViewController.h"
#import "RLZhiHuHttpTool.h"
#import "RLCommentViewCell.h"

@interface RLCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * commentsArray;
@property (nonatomic,strong) NSMutableArray * layoutModelSource;

@end

@implementation RLCommentViewController
- (void)loadView{
    [super loadView];
//    [self setup];
}

- (void)setup{
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self.view addSubview:self.tableView];
    
    if (self.totalComments > 20) {
        
        weakSelf(weakSelf);
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            DLog(@"上拉刷新");
            [weakSelf loadMoreData];
        }];
        self.tableView.mj_footer.automaticallyHidden = YES;
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //tableview上移64的适配
    if (IOS_VERSION > 7.0) {
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    
    
    [self setup];
}

- (void)loadMoreData{
    
    StoryComment *lastComment = self.commentsArray[self.commentsArray.count - 1];
    if (self.isShortComment) {
        
        [RLZhiHuHttpTool getShortCommentFromStoryID:self.storyID beforeAuthorId:lastComment.id success:^(id responseObject) {
            NSLog(@"resp = %@",responseObject);
            
            if (responseObject) {
                
                NSArray *comments = [StoryComment mj_objectArrayWithKeyValuesArray:responseObject[@"comments"]];
                
                if (comments.count > 0) {
                    
                    [self.commentsArray addObjectsFromArray:comments];
                    
                    for (NSInteger i = 0; i < comments.count; i ++) {
                        StoryComment *comment = comments[i];
                        
                        //生成Layout
                        RLCellLayout* layout = [[RLCellLayout alloc] initWithCommentModel:comment index:i dateFormatter:self.dateFormatter];
                        
                        [self.layoutModelSource addObject:layout];
                    }
                    
                    [self.tableView reloadData];
                    
                }
            }
            
            [self.tableView.mj_footer endRefreshing];
        } failure:^(NSError *error) {
            [MBProgressHUD showMsg:@"网络错误~" atView:self.view];
            [self.tableView.mj_footer endRefreshing];
        }];
        
    }else{
        
        [RLZhiHuHttpTool getLongCommentFromStoryID:self.storyID beforeAuthorId:lastComment.id success:^(id responseObject) {
            NSLog(@"resp = %@",responseObject);
            
            if (responseObject) {
                
                NSArray *comments = [StoryComment mj_objectArrayWithKeyValuesArray:responseObject[@"comments"]];
                if (comments.count > 0) {
                 
                    [self.commentsArray addObjectsFromArray:comments];
                    
                    for (NSInteger i = 0; i < comments.count; i ++) {
                        StoryComment *comment = comments[i];
                        
                        //生成Layout
                        RLCellLayout* layout = [[RLCellLayout alloc] initWithCommentModel:comment index:i dateFormatter:self.dateFormatter];
                        
                        [self.layoutModelSource addObject:layout];
                    }
                    
                    [self.tableView reloadData];
                }
            }
            
            [self.tableView.mj_footer endRefreshing];
        } failure:^(NSError *error) {
            [MBProgressHUD showMsg:@"网络错误~" atView:self.view];
            [self.tableView.mj_footer endRefreshing];
        }];
        
        
    }
    
    
}


- (void)loadData{
    [MBProgressHUD showLoadingAtView:self.view];
    
    if (self.isShortComment) {
        
        [RLZhiHuHttpTool getShortCommentFromStoryID:self.storyID success:^(id responseObject) {
            
            [MBProgressHUD hideLoadingAtView:self.view];
            
            
            self.commentsArray = [StoryComment mj_objectArrayWithKeyValuesArray:responseObject[@"comments"]];
            [self.layoutModelSource removeAllObjects];
            
            
//            NSMutableArray* fakes = [[NSMutableArray alloc] init];
//            [fakes addObjectsFromArray:self.commentsArray];
            
            for (NSInteger i = 0; i < self.commentsArray.count; i ++) {
                StoryComment *comment = self.commentsArray[i];
                
                //生成Layout
                RLCellLayout* layout = [[RLCellLayout alloc] initWithCommentModel:comment index:i dateFormatter:self.dateFormatter];
                [self.layoutModelSource addObject:layout];
            }
            
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            
            if (self.commentsArray.count > 0) {
                [self.tableView reloadData];
            }else{
                self.tableView.hidden = YES;
            }
            
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideLoadingAtView:self.view];
        }];
        
        
    }else {
        [RLZhiHuHttpTool getLongCommentFromStoryID:self.storyID success:^(id responseObject) {
//            NSLog(@"resp = %@",responseObject);
            [MBProgressHUD hideLoadingAtView:self.view];
            
            
            self.commentsArray = [StoryComment mj_objectArrayWithKeyValuesArray:responseObject[@"comments"]];
            [self.layoutModelSource removeAllObjects];
            
//            NSMutableArray* fakes = [[NSMutableArray alloc] init];
//            [fakes addObjectsFromArray:self.commentsArray];

            for (NSInteger i = 0; i < self.commentsArray.count; i ++) {
                StoryComment *comment = self.commentsArray[i];
                
                //生成Layout
                RLCellLayout* layout = [[RLCellLayout alloc] initWithCommentModel:comment index:i dateFormatter:self.dateFormatter];
                [self.layoutModelSource addObject:layout];
            }
            
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            if (self.commentsArray.count > 0) {
                [self.tableView reloadData];
            }else{
                self.tableView.hidden = YES;
            }
            
            
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideLoadingAtView:self.view];
        }];
    }
}

- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter* dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM月dd日 hh:mm"];
    });
    return dateFormatter;
}


#pragma mark - getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64.0) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

- (NSMutableArray *)layoutModelSource{
    if (!_layoutModelSource) {
        _layoutModelSource = [NSMutableArray array];

    }
    return _layoutModelSource;
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.layoutModelSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RLCommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RLCommentViewCellID"];
    
    if (!cell) {
        cell = [[RLCommentViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RLCommentViewCellID"];
        
    }
    
//    StoryComment *comment = self.dataSource[indexPath.row];
    
//    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    if (self.layoutModelSource.count >= indexPath.row) {
        RLCellLayout* cellLayout = self.layoutModelSource[indexPath.row];
        cell.cellLayout = cellLayout;
    }
    
    return cell;
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.layoutModelSource.count >= indexPath.row) {
        RLCellLayout* layout = self.layoutModelSource[indexPath.row];
        return layout.cellHeight;
    }
    return 0;
}







@end
