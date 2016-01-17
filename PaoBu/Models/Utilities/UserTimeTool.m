//
//  UserTimeTool.m
//  SiFaKaoShi
//
//  Created by XiaoBai on 14-4-14.
//  Copyright (c) 2014年 QXP. All rights reserved.
//

#import "UserTimeTool.h"
#import "LKDBHelper.h"

//判断用户登陆时长
#define UserTimeDBInfoKey @"888666"

@interface UserTimeDBInfo : NSObject
@property(nonatomic, strong)NSString *ID;
@property(nonatomic,assign)long time;
@end
@implementation UserTimeDBInfo
+(void)initialize{
    [super initialize];
    [[self getUsingLKDBHelper] createTableWithModelClass:self];
}
//主键
+(NSString *)getPrimaryKey{
    return @"ID";
}
@end

@implementation UserTimeTool
//获取用户的时长 单位为秒

+ (UserTimeDBInfo *)getInfo{

    NSArray *tempArr=[UserTimeDBInfo searchWithWhere:@{@"ID": UserTimeDBInfoKey} orderBy:nil offset:0 count:0];
    if (tempArr.count>0) {
        UserTimeDBInfo *info=tempArr[0];
        return info;
    }else{
       __autoreleasing UserTimeDBInfo *info=[[UserTimeDBInfo alloc] init];
        info.ID=UserTimeDBInfoKey;
        info.time=0;
        //[[MainManager LKDBglobalHelper] insertToDB:info];
        return info;
    }
    return nil;
}
+ (long)getLoginTime{
    NSArray *tempArr=[UserTimeDBInfo searchWithWhere:@{@"ID": UserTimeDBInfoKey} orderBy:nil offset:0 count:0];
    if (tempArr.count>0) {
        UserTimeDBInfo *info=tempArr[0];
        return info.time;
    }
    return 0;
}
//添加用户时长 单位为秒 注意 time为增加的时长不是总时长
+ (void)addLoginTime:(int)time{
    UserTimeDBInfo *info=[self getInfo];
    info.ID=UserTimeDBInfoKey;
    info.time+=time;
   // [[MainManager LKDBglobalHelper] updateToDB:info where:@{@"ID": UserTimeDBInfoKey}];
    info=nil;
}
@end
