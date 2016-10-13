//
//  RLBottomView.m
//  RLDailyViews
//
//  Created by LiWei on 16/4/6.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLBottomView.h"
//#import "RLZhiHuHttpTool.h"


@implementation RLBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    
    NSLog(@"awake");
    
}


- (void)setExtraInfo:(ExtraInfoModel *)extraInfo{
    
    NSLog(@"setStoryID && setExtraInfo");
    
    _extraInfo = extraInfo;
    
    [self setBtn:self.popularityBtn Title:[@(extraInfo.popularity) stringValue]];
    [self setBtn:self.shortCommentsBtn Title:[@(extraInfo.short_comments) stringValue]];
    [self setBtn:self.longCommentsBtn Title:[@(extraInfo.long_comments) stringValue]];
    
}
/**
 *  设置btn在正常/选中状态下的title
 */
- (void)setBtn:(UIButton *)btn Title:(NSString *)str{
    
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitle:str forState:UIControlStateSelected];
    
}


#pragma mark - action
- (IBAction)clickPopularityBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    DLog(@"点赞");
}

- (IBAction)clickShortCommentsBtn:(UIButton *)sender {
    DLog(@"短评");

    if ([self.delegate respondsToSelector:@selector(clickShortCommentsBtnIsShort:)]) {
        [self.delegate clickShortCommentsBtnIsShort:YES];
    }
    
    
}

- (IBAction)clickLongCommentsBtn:(UIButton *)sender {
    DLog(@"长评");
    if ([self.delegate respondsToSelector:@selector(clickLongCommentsBtnIsShort:)]) {
        [self.delegate clickLongCommentsBtnIsShort:NO];
    }
    
}

- (IBAction)clickCollectBtn:(UIButton *)sender {
    DLog(@"收藏");
    sender.selected = !sender.selected;
    
}

- (IBAction)clickShareBtn:(UIButton *)sender {
    DLog(@"分享");
    if ([self.delegate respondsToSelector:@selector(clickShareBtn)]) {
        [self.delegate clickShareBtn];
    }
    
}




@end
