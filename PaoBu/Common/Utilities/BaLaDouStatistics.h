//
//  BaLaDouStatistics.h
//  BaLaBaLa
//
//  Created by Mr.Qiu on 15/3/20.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "StatisticsBase.h"
/**
 *  @author 白旭涛
 *
 *  记录每天登陆次数
 */
@interface BaLaDouStatistics : StatisticsBase
@property(nonatomic,strong)NSString *userID;//用户ID
@property(nonatomic,assign)BOOL isSendServerToday;//记录今天是否发送到服务器

@end
