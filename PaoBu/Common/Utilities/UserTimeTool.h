//
//  UserTimeTool.h
//  SiFaKaoShi
//
//  Created by XiaoBai on 14-4-14.
//  Copyright (c) 2014年 QXP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTimeTool : NSObject

//获取用户的时长 单位为秒
+ (long)getLoginTime;
//添加用户时长 单位为秒 注意 time为增加的时长不是总时长
+ (void)addLoginTime:(int)time;
@end
