//
//  RLThemeCell.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/23.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLThemeCell.h"
#import "RLConstants.h"

@implementation RLThemeCell

- (void)setTheme:(ThemeModel *)theme{
    
    _theme = theme;
    
    
    
    [_contentImageView sd_setImageWithURL:[NSURL URLWithString:theme.thumbnail] placeholderImage:nil];
//    _contentImageView.alpha = kRLImageViewAlpha;
    
    _titleLabel.text = [NSString stringWithFormat:@"#%@#",theme.name];

    
    
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    
//    if (self = [super initWithFrame:frame]) {
//        
//        [self.contentView addSubview:_contentImageView];
//        [self.contentView addSubview:_titleLabel];
//        
//        
//    }
//    return self;
//    
//    
//}

@end
