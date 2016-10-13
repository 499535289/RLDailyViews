//
//  RLCellLayout.h
//  RLDailyViews
//
//  Created by LiWei on 16/6/7.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "LWLayout.h"
#import "StoryComment.h"
#import "Gallop.h"


@interface RLCellLayout : LWLayout
@property (nonatomic,strong) StoryComment * commentModel;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,assign) CGRect likeViewPosition;


- (instancetype)initWithCommentModel:(StoryComment *)commentModel index:(NSInteger)index dateFormatter:(NSDateFormatter *)dateFormatter;

@end
