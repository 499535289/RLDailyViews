//
//  StoryModel.h
//  RLDailyViews
//
//  Created by LiWei on 16/3/22.
//  Copyright © 2016年 LiWei. All rights reserved.
//

/*
 
 "top_stories": [
 {
 "image": "http://pic1.zhimg.com/6253f49adffd754cd8adc2ed6f7d5d9c.jpg",
 "type": 0,
 "id": 8036346,
 "ga_prefix": "032213",
 "title": "理清「山东疫苗案」中的重要信息，回答三个问题"
 }
 
 
 
 "stories": [
 {
 "images": [
 "http://pic2.zhimg.com/27f3d8f4c1e0000d04ee446a2f020cf1_t.jpg"
 ],
 "type": 2,
 "id": 7119477,
 "title": "9 张本周最热节操图，诺一就是人生赢家本人"
 }, ...
 ]
 
 
 
 
 分析：
 
 date : 日期
 stories : 当日新闻
 title : 新闻标题
 images : 图像地址（官方 API 使用数组形式。目前暂未有使用多张图片的情形出现，曾见无 images 属性的情况，请在使用中注意 ）
 ga_prefix : 供 Google Analytics 使用
 type : 作用未知
 id : url 与 share_url 中最后的数字（应为内容的 id）
 multipic : 消息是否包含多张图片（仅出现在包含多图的新闻中）
 top_stories : 界面顶部 ViewPager 滚动显示的显示内容（子项格式同上）
 
 
 
 */
#import <Foundation/Foundation.h>

@interface StoryModel : NSObject
@property (nonatomic,copy) NSArray * images;
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,copy) NSString * title;

@end

@interface TopStoryModel : NSObject
@property (nonatomic,copy) NSString * image;
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,copy) NSString * title;

@end


@interface SectionModel : NSObject
@property (nonatomic,copy) NSString * date;
@property (nonatomic,strong) NSArray * stories;
@property (nonatomic,strong) NSArray * top_stories;


@end




