//
//  BaLaDouStatistics.m
//  BaLaBaLa
//
//  Created by Mr.Qiu on 15/3/20.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "BaLaDouStatistics.h"

@implementation BaLaDouStatistics
+(BOOL)isContainParent
{
    return YES;
}
- (instancetype)init{

    if ((self=[super init])) {
        self.isSendServerToday=NO;
        self.userID=[PBUser userID];
    }
    return self;
}
+(NSArray*) getPrimaryKeyUnionArray{

    return @[@"time",@"userID"];
}
//获取所有非当天数据
+ (NSMutableArray *)allOBJsWithoutToady{
    
    NSString *whereStr=[NSString stringWithFormat:@"time <> %@ ",[self.class getToday]];
    return [[MainManager LKDBstatisticsHelper] search:[self class] where:whereStr orderBy:nil offset:0 count:0];
}
//获取除今天外所有字符串数据
+ (NSString *)allTimsWithoutToady{
    NSMutableString *tempStr=nil;
    //StatisticsBase *obj=
    NSArray *tempArr=[[self class] allOBJsWithoutToady];
    NSMutableDictionary *tempDict=[NSMutableDictionary dictionary];
    for (BaLaDouStatistics *obj in tempArr) {
        if ([tempDict.allKeys containsObject:obj.userID]) {
            [tempDict[obj.userID] addObject:obj.time];
        }else{
            tempDict[obj.userID]=[NSMutableArray arrayWithObject:obj.time];
        }
    }
    for (NSString *key in tempDict.allKeys) {
        NSArray *keyArr=tempDict[key];
        if (!tempStr) {
            tempStr=[NSMutableString stringWithFormat:@"%@|",key];
        }else{
            [tempStr appendFormat:@"$%@|",key];
        }
        
        [keyArr enumerateObjectsUsingBlock:^(NSString *time, NSUInteger idx, BOOL *stop) {
            
            if (idx==keyArr.count-1) {
                [tempStr appendFormat:@"%@",time];
            }else{
                [tempStr appendFormat:@"%@,",time];
            }
        }];
        
    }
    return tempStr;
}
//同步
- (void)synchronizeToday{
    [[MainManager LKDBstatisticsHelper] updateToDB:self where:@{@"time":self.time,@"userID":self.userID}];
}

@end
