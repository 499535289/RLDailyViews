//
//  ThemeModel.h
//  RLDailyViews
//
//  Created by LiWei on 16/3/23.
//  Copyright © 2016年 LiWei. All rights reserved.
//


/*
 
 {
 "limit": 1000,
 "subscribed": [ ],
 "others": [
 {
 "color": 8307764,
 "thumbnail": "http://pic4.zhimg.com/2c38a96e84b5cc8331a901920a87ea71.jpg",
 "description": "内容由知乎用户推荐，海纳主题百万，趣味上天入地",
 "id": 12,
 "name": "用户推荐日报"
 },
 ...
 ]
 }
 
 
 limit : 返回数目之限制（仅为猜测）
 subscribed : 已订阅条目
 others : 其他条目
 color : 颜色，作用未知
 thumbnail : 供显示的图片地址
 description : 主题日报的介绍
 id : 该主题日报的编号
 name : 供显示的主题日报名称
 
 
 */

#import <Foundation/Foundation.h>

@interface ThemeModel : NSObject

@property (nonatomic,assign) NSInteger id;
@property (nonatomic,assign) NSInteger color;
@property (nonatomic,copy) NSString * thumbnail;
@property (nonatomic,copy) NSString * desc;
@property (nonatomic,copy) NSString * name;

@end
