//
//  RLCellLayout.m
//  RLDailyViews
//
//  Created by LiWei on 16/6/7.
//  Copyright © 2016年 LiWei. All rights reserved.
//

#import "RLCellLayout.h"
#import "LWTextParser.h"

@implementation RLCellLayout

- (instancetype)initWithCommentModel:(StoryComment *)commentModel index:(NSInteger)index dateFormatter:(NSDateFormatter *)dateFormatter{
    if (self = [super init]) {
        self.commentModel = commentModel;
        
        //创建头像模型
        LWImageStorage * avatarStorage = [[LWImageStorage alloc]initWithIdentifier:@"avatar"];
        avatarStorage.contents = [NSURL  URLWithString:commentModel.avatar];//url
        avatarStorage.cornerRadius = 17.0f;
//        avatarStorage.cornerBackgroundColor = [UIColor whiteColor];
//        avatarStorage.fadeShow = YES;
//        avatarStorage.clipsToBounds = NO;
        avatarStorage.backgroundColor = RGB(240, 240, 240, 1);
        avatarStorage.frame = CGRectMake(10, 20, 34, 34);
        avatarStorage.tag = 9;
        
        //创建名字模型
        LWTextStorage * nameTextStorage = [[LWTextStorage alloc]init];
        nameTextStorage.text = commentModel.author;
        nameTextStorage.font = [UIFont fontWithName:@"Heiti SC" size:Scale_float(15.0f)];
        nameTextStorage.frame = CGRectMake(60.0f, 20.0f, SCREEN_WIDTH - 80.0f, CGFLOAT_MAX);
        [nameTextStorage lw_addLinkWithData:[NSString stringWithFormat:@"%@",commentModel.author]
                                      range:NSMakeRange(0,commentModel.author.length)
                                  linkColor:RGB(113, 129, 195, 1)
                             highLightColor:RGB(0, 0, 0, 0.15)];
        
        
        //正文内容模型 contentTextStorage
        LWTextStorage* contentTextStorage = [[LWTextStorage alloc] init];
        contentTextStorage.text = commentModel.content;
        contentTextStorage.font = [UIFont fontWithName:@"Heiti SC" size:15.0f];
        contentTextStorage.textColor = RGB(40, 40, 40, 1);
        contentTextStorage.frame = CGRectMake(nameTextStorage.left, nameTextStorage.bottom + 10.0f, SCREEN_WIDTH - 80.0f, CGFLOAT_MAX);
        //解析文本表情和#...#之类的主题链接
        [LWTextParser parseEmojiWithTextStorage:contentTextStorage];
        [LWTextParser parseTopicWithLWTextStorage:contentTextStorage
                                        linkColor:RGB(113, 129, 161, 1)
                                   highlightColor:RGB(0, 0, 0, 0.15)];
        
        
        
        //生成时间的模型 dateTextStorage
        LWTextStorage* dateTextStorage = [[LWTextStorage alloc] init];
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[commentModel.time integerValue]];
        dateTextStorage.text = [dateFormatter stringFromDate:date];
        dateTextStorage.font = [UIFont fontWithName:@"Heiti SC" size:13.0f];
        dateTextStorage.textColor = [UIColor grayColor];
        dateTextStorage.frame = CGRectMake(nameTextStorage.left, contentTextStorage.bottom + 10.0f, SCREEN_WIDTH - 80.0f, CGFLOAT_MAX);
        
        
        //点赞区域(1个imageview和1个label)
        LWTextStorage * likeNumStorage = [[LWTextStorage alloc]init];
        likeNumStorage.font = [UIFont fontWithName:@"Heiti SC" size:Scale_float(13.0f)];
        likeNumStorage.frame = CGRectMake(SCREEN_WIDTH - 40, contentTextStorage.bottom + 10, 20, CGFLOAT_MAX);
        likeNumStorage.text = [@(commentModel.likes) stringValue];
        likeNumStorage.textColor = [UIColor grayColor];
        
        
        
        CGRect likeImagePosition;
        likeImagePosition = CGRectMake(SCREEN_WIDTH - 45.0f - 18.0f,10.0f + contentTextStorage.bottom,18,18);
        LWImageStorage *likeImageStorage = [[LWImageStorage alloc]init];
        likeImageStorage.frame = likeImagePosition;
        likeImageStorage.contents = [UIImage imageNamed:@"global_btn_love_select"];
        
        //评论文本
        if (commentModel.reply_to) {
            
            LWTextStorage * commentTextStorage = [[LWTextStorage alloc]init];
//            commentTextStorage.textColor = RGB(40, 40, 80, 1);
            if (commentModel.reply_to.content) {
                NSString *toAuthorNameStr = [NSString stringWithFormat:@"//%@：",commentModel.reply_to.author];
                commentTextStorage.text = [NSString stringWithFormat:@"%@%@",toAuthorNameStr,commentModel.reply_to.content];
                [commentTextStorage lw_addLinkWithData:commentTextStorage.text range:NSMakeRange(0, toAuthorNameStr.length) linkColor:RGB(113, 129, 195, 1) highLightColor:RGB(0, 0, 0, 0.15)];
            }
            if (commentModel.reply_to.error_msg) {
                commentTextStorage.text = commentModel.reply_to.error_msg;
            }
            commentTextStorage.font = [UIFont fontWithName:@"Heiti SC" size:14.0f];
            commentTextStorage.textAlignment = NSTextAlignmentLeft;
            commentTextStorage.linespacing = 2.0f;
            
            CGRect rect = CGRectMake(60.0f,dateTextStorage.bottom + 5.0f, SCREEN_WIDTH - 80, 20);
            CGFloat offsetY = 0.0f;
            commentTextStorage.frame = CGRectMake(rect.origin.x + 10.0f, rect.origin.y + 10.0f + offsetY,SCREEN_WIDTH - 95.0f, CGFLOAT_MAX);
            
            
            //生成评论背景Storage
            LWImageStorage* commentBgStorage = [[LWImageStorage alloc] init];
    //        NSArray* commentTextStorages = @[];
            CGRect commentBgPosition = CGRectZero;
            //如果有评论，设置评论背景Storage
            commentBgPosition = CGRectMake(60.0f,dateTextStorage.bottom + 5.0f, SCREEN_WIDTH - 80, commentTextStorage.height + 15.0f);
            commentBgStorage.frame = commentBgPosition;
            commentBgStorage.contents = [UIImage imageNamed:@"comment"];
            [commentBgStorage stretchableImageWithLeftCapWidth:40 topCapHeight:15];
            
            [self addStorage:commentBgStorage];
            [self addStorage:commentTextStorage];
        }
        
        
        [self addStorage:nameTextStorage];
        [self addStorage:contentTextStorage];
        [self addStorage:dateTextStorage];
        
        [self addStorage:avatarStorage];
        
        [self addStorage:likeNumStorage];

        [self addStorage:likeImageStorage];
//        [self addStorages:imageStorageArray];
//        if (likeTextStorage) {
//            [self addStorage:likeTextStorage];
//        }
        //一些其他属性
//        self.likeViewPosition = likeViewPosition;
//        self.commentBgPosition = commentBgPosition;
//        self.imagePostionArray = imagePositionArray;
        self.commentModel = commentModel;
        //如果是使用在UITableViewCell上面，可以通过以下方法快速的得到Cell的高度
        self.cellHeight = [self suggestHeightWithBottomMargin:15.0f];
        
        
    }
    
    
    return self;
}



@end
