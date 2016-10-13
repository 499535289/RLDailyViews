//
//  StoryModel.m
//  RLDailyViews
//
//  Created by LiWei on 16/3/22.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "StoryModel.h"
@implementation StoryModel

@end

@implementation TopStoryModel


@end



@implementation SectionModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"stories":[StoryModel class],
             @"top_stories":[TopStoryModel class]
             };
}

@end
