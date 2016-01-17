//
//  StatisticsBase.m
//  BaLaBaLa
//
//  Created by Mr.Qiu on 15/3/18.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "StatisticsBase.h"
#import "NSDate+Helpers.h"

@interface StatisticsBase ()
@property(nonatomic, strong)NSString *statisticsName;
@property(nonatomic, strong)NSString *setTime;
@end
@implementation StatisticsBase
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
+(void)initialize{
    [super initialize];
    [[MainManager LKDBstatisticsHelper] createTableWithModelClass:self];
}
//主键
+(NSString *)getPrimaryKey{
    return @"time";
}
+(BOOL)isContainParent
{
    return YES;
}
//获取今天是否上传过记录
+ (BOOL)isUpDateToday{
    
    NSString *whereStr=[NSString stringWithFormat:@"setTime <> %@",[StatisticsBase getToday]];
    [[MainManager LKDBstatisticsHelper] deleteWithClass:[self class] where:whereStr];
    
    id searchDict=@{@"statisticsName" : NSStringFromClass([self class]),@"setTime":[StatisticsBase getToday]};
                                                        
    StatisticsBase *OBJ=[[MainManager LKDBstatisticsHelper] searchSingle:[StatisticsBase class] where:searchDict orderBy:nil ];
    if (OBJ) {
        OBJ=nil;
        return YES;
    }
    return NO;
}
//设置今天已经上传
+ (void)setToDayUpdateOK{
    
    StatisticsBase *OBJ=[[StatisticsBase alloc] init];
    OBJ.time=[NSString stringWithFormat:@"%@%d",[StatisticsBase getToday],rand()];
    OBJ.statisticsName=NSStringFromClass([self class]);
    OBJ.setTime=[StatisticsBase getToday];
    [[MainManager LKDBstatisticsHelper] insertToDB:OBJ];
}
//获取是否有记录
+ (BOOL)haveOBJS{
    id obj=[[MainManager LKDBstatisticsHelper] searchSingle:[self class] where:nil orderBy:nil ];

    if (obj) {
        obj=nil;
        return YES;
    }
    return NO;
}
+ (instancetype)todayOBJ{
    StatisticsBase *obj=[[MainManager LKDBstatisticsHelper] searchSingle:[self class] where:@{@"time":[self getToday]} orderBy:nil ];
    
    if (!obj) {
        obj=[[self alloc] init];
        obj.time=[self getToday];
        [[MainManager LKDBstatisticsHelper] insertToDB:obj];
    }
    return obj;
}
//获取今天字符串
+ (NSString *)getToday{
    NSDate *date=[NSDate date];
    return [NSDate stringFromDate:date withFormat:[NSDate dateFormatString]];;
}
////获取所有数据
+ (NSMutableArray *)allOBJs{

      return [[MainManager LKDBstatisticsHelper] search:[self class] where:nil orderBy:nil offset:0 count:0];
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
    
    for (StatisticsBase *obj in tempArr) {
        if (!tempStr) {
            tempStr=[NSMutableString stringWithString:obj.time];
        }else{
            [tempStr appendFormat:@",%@",obj.time];
        }
    }
    return tempStr;
}
//删除除今天外所有数据
+ (void)deleteAllOBJSWithoutToady{
    NSString *whereStr=[NSString stringWithFormat:@"time <> %@",[self.class getToday]];
    [[MainManager LKDBstatisticsHelper] deleteWithClass:[self class] where:whereStr];
}
//同步
- (void)synchronizeToday{
    [[MainManager LKDBstatisticsHelper] updateToDB:self where:@{@"time":self.time}];
}
@end
