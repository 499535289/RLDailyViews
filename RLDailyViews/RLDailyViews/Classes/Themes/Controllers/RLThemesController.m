//
//  RLThemesController.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/23.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLThemesController.h"
#import "RLZhiHuHttpTool.h"
#import "ThemeModel.h"
#import "RLThemeCell.h"

@interface RLThemesController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) NSArray * themes;

@end

@implementation RLThemesController

//static NSString * const reuseIdentifier = @"RLThemeCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showLoadingAtView:self.view];
    
    [RLZhiHuHttpTool getThemesListSuccess:^(id responseObject) {
        [MBProgressHUD hideLoadingAtView:self.view];
        
        self.themes = [ThemeModel mj_objectArrayWithKeyValuesArray:responseObject[@"others"]];
        
        [self.collectionView reloadData];
    }failure:^(NSError *error) {
        [MBProgressHUD hideLoadingAtView:self.view];
    }];
    
    [self configureFlowLayout];
    
    
   
}

- (void)configureFlowLayout{
    
    self.flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/2 - 0.5, SCREEN_WIDTH/2 - 1);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.themes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RLThemeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RLThemeCellID" forIndexPath:indexPath];
    
    ThemeModel *theme = self.themes[indexPath.row];
    
    cell.theme = theme;
    
    NSLog(@"cell dizhi = %@",cell);
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
