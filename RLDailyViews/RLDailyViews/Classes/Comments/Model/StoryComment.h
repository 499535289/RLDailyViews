//
//  StoryComment.h
//  RLDailyViews
//
//  Created by LiWei on 16/5/25.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryCommentReply : NSObject
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * author;
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,copy) NSString * error_msg;

@end



@interface StoryComment : NSObject

@property (nonatomic,copy) NSString * author;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * avatar;
@property (nonatomic,assign) NSString * time;
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,assign) NSInteger likes;

@property (nonatomic,strong) StoryCommentReply * reply_to;

@end



