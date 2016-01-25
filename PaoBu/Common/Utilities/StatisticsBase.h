//
//  StatisticsBase.h
//  BaLaBaLa
//
//  Created by Mr.Qiu on 15/3/18.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface StatisticsBase : MTLModel<MTLJSONSerializing>
@property(nonatomic, strong)NSString *time;


//获取今天是否上传过记录
+ (BOOL)isUpDateToday;
//设置今天已经上传
+ (void)setToDayUpdateOK;

//获取是否有记录
+ (BOOL)haveOBJS;
//获取今天数据OBJ
+ (instancetype)todayOBJ;
//获取今天字符串
+ (NSString *)getToday;
////获取所有数据
+ (NSMutableArray *)allOBJs;
//获取所有非当天数据
+ (NSMutableArray *)allOBJsWithoutToady;
//获取除今天外所有字符串数据
+ (NSString *)allTimsWithoutToady;
//删除除今天外所有数据
+ (void)deleteAllOBJSWithoutToady;
//同步
- (void)synchronizeToday;

@end
