//
//  MainConfig.h
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-7-8.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "iConsole.h"

@interface MainConfig : NSObject

+ (instancetype)config;
//添加高德地图
+ (void)addGDMap;
//测试数据
+ (void)setinfo;
//准备数据库
+ (void)setingDB;
//添加键盘中心
+ (void)addIQKeyBoardManager;
//添加友盟统计
+ (void)addYouMeng;
//添加友盟分享
+ (void)addYouMengShere;
//改变分享路径
+ (void)changeShereURL:(NSString *)url;
//提交筹建康数据
+ (void)postHealthInfo;

//检查是否需要更新
+ (void)cheakUpdate;
//首次统计需求
+ (void)firstInstall;
//强制通知信息
+ (void)sysforce;

@end
