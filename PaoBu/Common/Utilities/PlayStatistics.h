//
//  PlayStatistics.h
//  BaLaBaLa
//
//  Created by xy on 15/4/16.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//  播放次数统计

#import "StatisticsBase.h"

@interface PlayStatistics : StatisticsBase

@property(nonatomic,strong)NSString *userID;//用户ID
@property(nonatomic,strong)NSString *playID;//节目ID
@property(nonatomic,assign)BOOL isSendServerToday;//记录今天是否发送到服务器
@property(nonatomic,assign)int playCount;//记录点击次数
//当前时间
//@property(nonatomic, strong)NSString *time;


//增加一次
- (void)addCount;

//获取ID
+ (PlayStatistics *)getOBJ:(NSString *)userID playID:(NSString *)playID;



@end
