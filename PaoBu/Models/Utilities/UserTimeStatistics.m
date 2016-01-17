//
//  UserTimeStatistics.m
//  BaLaBaLa
//
//  Created by xy on 15/4/15.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "UserTimeStatistics.h"
#import "NSDate+Helpers.h"
@implementation UserTimeStatistics
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

//
+ (NSString *)AllUserTimeStatistics{
    NSMutableString *tempStr=[NSMutableString string];
    //StatisticsBase *obj=
    NSArray *tempArr=[[self class] allOBJs];
   
    [tempArr enumerateObjectsUsingBlock:^(UserTimeStatistics *obj, NSUInteger idx, BOOL *stop) {
      
        [tempStr appendFormat:@"%@,%@,%ld", obj.userID, obj.time, obj.usetime];
        
        if (idx != tempArr.count-1) {
           [tempStr appendString:@"|"];
        }
    }];
    
    if (tempStr.length>0) {
        
        return tempStr;
    }
    tempStr=nil;
    return tempStr;
}

//当前时间的字符串
+ (UserTimeStatistics*)getNowOBJ{

    UserTimeStatistics *obj=[[UserTimeStatistics alloc] init];
    obj.usetime=1;
    obj.time=[NSString stringWithFormat:@"%ld",[NSDate timeIntervalWithLong]];
    return obj;
}
//累加时间
- (void)addTime:(long)miao{

    self.usetime+=miao;
}

//删除除今天外所有数据
+ (void)deleteAllOBJS{
    //[[MainManager LKDBstatisticsHelper] deleteWithClass:[self class] where:nil];
}
//同步
- (void)synchronizeToday{
    //[[MainManager LKDBstatisticsHelper] insertToDB:self];
    //[[MainManager LKDBstatisticsHelper] updateToDB:self where:@{@"time":self.time,@"userID":self.userID}];
}
@end
