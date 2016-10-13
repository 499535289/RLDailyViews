//
//  RLPlaceholderView.m
//  RLDailyViews
//
//  Created by LiWei on 16/5/24.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLPlaceholderView.h"

@implementation RLPlaceholderView
- (IBAction)reloadData:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickReloadBtn)]) {
        [self.delegate clickReloadBtn];
    }
    
}



@end
