#import <Foundation/Foundation.h>

@interface QXPCacheForUser : NSObject
@property(nonatomic, strong)NSString *userID;


//系统消息条数
@property(nonatomic, strong)NSString *newsnum;
//反馈消息条数
@property(nonatomic, strong)NSString *feedbacknum;

//最后请求时间-意见反馈
@property(nonatomic, strong)NSString *lasttime_UsergetFeedback;
//最后请求时间-公告信息
@property(nonatomic, strong)NSString *lasttime_SysNews;


//是否更新数据UserInfo最后请求时间戳
@property(nonatomic, strong)NSString *lasttime_UserInfo;
//是否更新数据SystemInfo最后请求时间戳
@property(nonatomic, strong)NSString *lasttime_SystemInfo;



//获取user
+ (instancetype)sharedCacheUtilit;
//同步
- (void)synchronize;

@end
