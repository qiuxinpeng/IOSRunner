//
//
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器  http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//
#import "SysInfoOBJ.h"

@implementation tb_TribeSaylevel_DetlOBJ
+(BOOL)isContainParent
{
    return YES;
}
+(NSString*)getPrimaryKey{
    
    return @"ID";
}
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}
@end


@implementation SysInfoOBJ

+(void)initialize
{
    [super initialize];
    [[MainManager LKDBglobalHelper] createTableWithModelClass:[self class]];
}
+(BOOL)isContainParent
{
    return YES;
}
- (instancetype)init{
    
    if ((self=[super init])) {
        
        self.ID=@"1";
    }
    return self;
}
+(NSString*)getPrimaryKey{

    return @"ID";
}
static SysInfoOBJ *_tempUser=nil;

+ (instancetype)sharedInfo{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (![SysInfoOBJ isSave]) {
            [[MainManager LKDBglobalHelper] deleteWithClass:SysInfoOBJ.class where:nil];
                        [SysInfoOBJ checkSelf];
            [_tempUser saveSelf];

        }else{
            _tempUser=[[MainManager LKDBglobalHelper] searchSingle:[self class] where:nil orderBy:nil];
        }
    });
    return _tempUser;
}
//同步
- (void)synchronize{
    
    if (![SysInfoOBJ sharedInfo].ID || [SysInfoOBJ sharedInfo].tb_Country_Info.count==0) {
        return;
    }
    if ([SysInfoOBJ isSave]) {
        
        [[MainManager LKDBglobalHelper] deleteWithClass:SysInfoOBJ.class where:nil];
       
    }
    
    SysInfoOBJ *tempOB=_tempUser;
    tempOB.ID=self.ID;
    tempOB.tb_Country_Info=self.tb_Country_Info;
    tempOB.tb_MotherTongue_Info=self.tb_MotherTongue_Info;
    tempOB.tb_UserInterest_Detl=self.tb_UserInterest_Detl;
    tempOB.tb_Constellation_Detl=self.tb_Constellation_Detl;

    tempOB.useagreement=self.useagreement;
    tempOB.forgotpwd=self.forgotpwd;
    tempOB.lasttime=self.lasttime;
    [tempOB saveSelf];
    tempOB=nil;
}
//检查是否数据完整 不完整直接删除 然后从本地拿数据
+ (void)checkSelf{

    NSError *err=nil;
    NSData *tempData=[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"systeminfo" ofType:@"txt"]];
    NSDictionary *tempObject = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingMutableLeaves error:&err];
    
    
    NSDictionary *tempOBJ=[tempObject objectForKey4JsonForKey:@"data"];
    NSString *templasttime=[tempOBJ objectForKey4JsonForKey:@"lasttime"];
  
    [QXPCacheForUser sharedCacheUtilit].lasttime_SystemInfo=templasttime;
    [[QXPCacheForUser sharedCacheUtilit] synchronize];
    
    SysInfoOBJ *obj=[MTLJSONAdapter modelOfClass:[SysInfoOBJ class] fromJSONDictionary:tempOBJ error:&err];
    _tempUser=obj;
}
//是否已经保存
+ (BOOL)isSave{
    id temp =[[MainManager LKDBglobalHelper] searchSingle:[self class] where:nil orderBy:nil ];
    return temp?YES:NO;
}
//保存自己
- (BOOL)saveSelf{
    
    [[MainManager LKDBglobalHelper] insertToDB:self callback:^(BOOL result) {
    }];
    return YES;
}
+ (void)searchCountry:(NSString *)key callback:(void (^)(NSMutableArray *))block{
    
    //NSString *sql=[NSString stringWithFormat:@"SELECT * FROM J_country_info_IDEntity WHERE CountryNameCN LIKE '%%%@%%' or CountryNameEN LIKE '%%%@%%'",key,key];
    
    NSString *sql=[NSString stringWithFormat:@"CountryNameCN LIKE '%%%@%%' or CountryNameEN LIKE '%%%@%%'",key,key];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSMutableArray *tempArr=[[MainManager LKDBglobalHelper] searchWithSQL:sql toClass:[J_country_info_IDEntity class]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            block(tempArr);
//        });
//    });
    
  
    
}
+ (void)searchShi:(NSString *)key countryID:(NSString *)countryID callback:(void (^)(NSMutableArray *))block{
    
    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM ShiEntity WHERE  FirstID = '%@' and City != '' and ( City LIKE '%%%@%%' or firstCN LIKE '%%%@%%')",countryID,key,key];
    
   
    
}
//获取国家的城市列表
+ (void)searchShiWihtcountryID:(NSString *)countryID callback:(void (^)(NSMutableArray *))block{

    NSString *sql=[NSString stringWithFormat:@"SELECT * FROM ShiEntity WHERE  FirstID = '%@' and City != ''",countryID];
    
    

}
//删除自己
- (BOOL)delSelf{
    return [[MainManager LKDBglobalHelper] deleteToDB:self];
}
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}


@end
