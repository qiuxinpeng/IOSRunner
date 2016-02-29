#import <Foundation/Foundation.h>
#import "MTLModel.h"
//#import "Typedefine.h"
#define CACHEUTITLIT_KEY @"CacheUtitlity_Key_cach"

@interface QXPCacheUtility : MTLModel

//获取单例user
+ (instancetype)sharedCacheUtility;
//同步
- (void)synchronize;

//首页时间戳
@property(nonatomic, strong)NSString *home_images_timestamp;
//
@property(nonatomic, strong)NSString *home_notice_timestamp;
//保存的字符串
@property(nonatomic, strong)NSString *home_notice_title;
//详情信息数据
@property(nonatomic, strong)NSString *home_detail_timestamp;

@end
