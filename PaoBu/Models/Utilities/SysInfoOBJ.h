//
//  
//  AutomaticCoder
//
//  Created by 张玺自动代码生成器   http://zhangxi.me
//  Copyright (c) 2012年 me.zhangxi. All rights reserved.
//

//#import "Tb_MotherTongue_InfoEntity.h"
//#import "Tb_Country_InfoEntity.h"
#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "ObjectBuilder.h"

@interface tb_TribeSaylevel_DetlOBJ: MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *ID;//
@property (nonatomic,strong) NSString *SaylevelName;//
@property (nonatomic,strong) NSString *SaylevelMemo;//
@property (nonatomic,strong) NSString *isSelected;//是否被选中
@end



@interface SysInfoOBJ : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSMutableArray *tb_Country_Info;//国家信息
@property (nonatomic,strong) NSMutableArray *tb_MotherTongue_Info;//母语信息
@property (nonatomic,strong) NSMutableArray *tb_UserInterest_Detl;//兴趣信息
@property (nonatomic,strong) NSMutableArray *tb_Constellation_Detl;//星座信息
@property (nonatomic,strong) NSMutableArray *tb_TribeSaylevel_Detl;//语言水平信息





@property (nonatomic,strong) NSString *useagreement;//用户使用协议
@property (nonatomic,strong) NSString *forgotpwd;//忘记密码链接
@property (nonatomic,strong) NSString *lasttime;//最后请求时间,时间戳

+ (instancetype)sharedInfo;
//同步
- (void)synchronize;
//检查是否数据完整 不完整直接删除 然后从本地拿数据
+ (void)checkSelf;

//是否已经保存
+ (BOOL)isSave;
//搜索国家
+ (void)searchCountry:(NSString *)key callback:(void (^)(NSMutableArray *))block;
//根据国家搜索城市
+ (void)searchShi:(NSString *)key countryID:(NSString *)countryID callback:(void (^)(NSMutableArray *))block;
//获取国家的城市列表
+ (void)searchShiWihtcountryID:(NSString *)countryID callback:(void (^)(NSMutableArray *))block;

@end
