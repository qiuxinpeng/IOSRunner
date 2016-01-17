//
//  UserTimeStatistics.h
//  BaLaBaLa
//
//  Created by xy on 15/4/15.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "StatisticsBase.h"

@interface UserTimeStatistics : StatisticsBase
@property(nonatomic,strong)NSString *userID;//用户ID
@property(nonatomic,assign)BOOL isSendServerToday;//记录今天是否发送到服务器
@property(nonatomic,assign)long usetime;//使用时间
//当前时间
//@property(nonatomic, strong)NSString *time;

//当前时间的字符串
+ (UserTimeStatistics*)getNowOBJ;

//累加时间
- (void)addTime:(long)miao;
//删除除今天外所有数据
+ (void)deleteAllOBJS;
+ (NSString *)AllUserTimeStatistics;

@end
