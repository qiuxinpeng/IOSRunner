//
//  QXPCacheUtilit.h
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-8-6.
//  Copyright (c) 2014年 9tong.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
//#import "Typedefine.h"
#define CACHEUTITLIT_KEY @"CacheUtitlit_Key_cach"

@interface QXPCacheUtilit : MTLModel

//获取单例user
+ (instancetype)sharedCacheUtilit;
//同步
- (void)synchronize;

//首页时间戳
@property(nonatomic, strong)NSString *home_images_timestamp;
//
@property(nonatomic, strong)NSString *home_notice_timestamp;
//保存的字符串
@property(nonatomic, strong)NSString *home_notice_title;

//详情信息数据
@property(nonatomic, strong)NSString *home_detel_timestamp;



@end
