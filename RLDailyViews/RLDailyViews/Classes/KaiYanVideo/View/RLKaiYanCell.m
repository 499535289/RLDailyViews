//
//  RLKaiYanCell.m
//  RLDailyViews
//
//  Created by LiWei on 16/4/18.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLKaiYanCell.h"


@implementation RLKaiYanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        _coverImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PICTURE_HEIGHT)];
        [self.contentView addSubview:_coverImageView];
        
        _coverView = [[UIView alloc]initWithFrame:_coverImageView.frame];
        _coverView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:_coverView];
        
        _titleLabel = ({
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, PICTURE_HEIGHT/2 - 44, SCREEN_WIDTH, 44.0)];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont boldSystemFontOfSize:16.0];
            label;
        });
        [self.contentView addSubview:_titleLabel];
        
        
        {
            _categoryAndDurationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, PICTURE_HEIGHT/2 , SCREEN_WIDTH, 30)];
            _categoryAndDurationLabel.textAlignment = NSTextAlignmentCenter;
            _categoryAndDurationLabel.textColor = [UIColor whiteColor];
            _categoryAndDurationLabel.font = [UIFont italicSystemFontOfSize:12.0];
            [self.contentView addSubview:_categoryAndDurationLabel];
        }
        
        {
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToDo:)];
            longPress.minimumPressDuration = 0.25;
            [self addGestureRecognizer:longPress];
        }
        
    }
    
    return self;
    
}

- (void)longPressToDo:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        self.titleLabel.alpha = 0;
        self.categoryAndDurationLabel.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            
            self.coverView.alpha = 0;
            
        }];
        
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {

        [UIView animateWithDuration:0.5 animations:^{
            
            self.titleLabel.alpha = 1;
            self.categoryAndDurationLabel.alpha = 1;
            self.coverView.alpha = 0.3;
            
        }];
    }
    
}

- (void)setVideoModel:(VideoModel *)videoModel{
    
    _videoModel = videoModel;
    
    
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:videoModel.coverForDetail] placeholderImage:nil];
    if (!_coverImageView.image) {
        
        _coverImageView.alpha = 0;
        _coverView.alpha = 0.3;
        [UIView animateWithDuration:1 animations:^{
//            _coverView.alpha = 0.3;
            _coverImageView.alpha = 1;
        } completion:^(BOOL finished) {

        }];
    }


    
    
    _titleLabel.text = videoModel.title;
    
    NSString *timeStr = [NSString stringWithFormat:@"%02ld'%02ld''",videoModel.duration / 60, videoModel.duration % 60];
    
    _categoryAndDurationLabel.text = [NSString stringWithFormat:@"#%@#  /  %@",videoModel.category,timeStr];
    
    
    
}











- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
