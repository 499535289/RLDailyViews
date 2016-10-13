//
//  RLCommentViewCell.m
//  RLDailyViews
//
//  Created by LiWei on 16/6/7.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLCommentViewCell.h"

@interface RLCommentViewCell ()<LWAsyncDisplayViewDelegate>

@property (nonatomic,strong) LWAsyncDisplayView* asyncDisplayView;


@end

@implementation RLCommentViewCell
#pragma mark - getter
- (LWAsyncDisplayView *)asyncDisplayView{
    if (!_asyncDisplayView) {
        _asyncDisplayView = [[LWAsyncDisplayView alloc]initWithFrame:CGRectZero];
        _asyncDisplayView.delegate = self;
    }
    return _asyncDisplayView;
}




#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.asyncDisplayView];
        
    }
    return self;
}



#pragma mark - Draw and setup
- (void)setCellLayout:(RLCellLayout *)cellLayout {
    if (_cellLayout == cellLayout) {
        return;
    }
    _cellLayout = cellLayout;
    self.asyncDisplayView.layout = self.cellLayout;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.asyncDisplayView.frame = CGRectMake(0,0,SCREEN_WIDTH,self.cellLayout.cellHeight);

}







@end
