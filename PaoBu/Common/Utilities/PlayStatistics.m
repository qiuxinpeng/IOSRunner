//
//  PlayStatistics.m
//  BaLaBaLa
//
//  Created by xy on 15/4/16.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "PlayStatistics.h"

@implementation PlayStatistics
+(BOOL)isContainParent
{
    return YES;
}
+(NSArray*) getPrimaryKeyUnionArray{
    
    return @[@"userID",@"playID"];
}

- (instancetype)init{
    
    if ((self=[super init])) {
        self.isSendServerToday=NO;
        self.userID=[PBUser userID];
        self.playCount = 0;
        
    }
    return self;
}
//获取除今天外所有字符串数据
+ (NSString *)allTimsWithoutToady{
    NSMutableString *tempStr=[NSMutableString string];
    //StatisticsBase *obj=
    NSArray *tempArr=[[self class] allOBJsWithoutToady];
    [tempArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PlayStatistics *_obj = obj;
        [tempStr appendFormat:@"%@,%@,%@,%d", _obj.userID, _obj.playID, _obj.time, _obj.playCount];
        if (idx != tempArr.count-1) {
            [tempStr appendString:@"|"];
        }
    }];
    return tempStr;
}
//增加一次
- (void)addCount {
    
    self.time = [[self class] getToday];
    self.playCount += 1;
    
    [self synchronizeToday];
}

//获取ID
+ (PlayStatistics *)getOBJ:(NSString *)userID playID:(NSString *)playID {
     PlayStatistics *obj = [[MainManager LKDBstatisticsHelper] searchSingle:[self class] where:@{@"userID":userID, @"playID":playID} orderBy:nil];
    if (!obj) {
        obj = [[PlayStatistics alloc] init];
        obj.playID = playID;
        obj.userID = userID;
        [[MainManager LKDBstatisticsHelper] insertToDB:obj];

    }
    return obj;
}

/*
//获取今天字符串
+ (NSString *)getToday{
    NSDate *date=[NSDate date];
    return [NSDate stringFromDate:date withFormat:[NSDate dateFormatString]];;
}
*/
//同步
- (void)synchronizeToday{
    [[MainManager LKDBstatisticsHelper] updateToDB:self where:@{@"userID":self.userID, @"playID":self.playID}];
    
    //[[MainManager LKDBstatisticsHelper] insertToDB:self];
    
}

@end
