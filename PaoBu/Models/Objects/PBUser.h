//
//  PBUser.h
//  PaoBu
//
//  Created by Apple on 16/1/17.
//  Copyright © 2016年 LunSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
//#import "ObjectBuilder.h"

#define ZCUserLoginNotificationName @"ZCUserExit_Notification_Login"
#define ZCUserExitNotificationName @"ZCUserExit_Notification_exit"

@interface PBUser : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSString *LastLoginTime;
@property (nonatomic,strong) NSString *MapRunNum;//地图数量
@property (nonatomic,strong) NSString *LikeNum;
@property (nonatomic,strong) NSString *FriendsNum;//朋友数量
@property (nonatomic,strong) NSString *Grade;
@property (nonatomic,strong) NSString *LatestRunTraceID;
@property (nonatomic,strong) NSString *FavoriteNum;
@property (nonatomic,strong) NSString *Password;
@property (nonatomic,strong) NSString *EMail;
@property (nonatomic,strong) NSString *AgeGroupDescription;//年龄组
@property (nonatomic,strong) NSString *TraceName;//最近运动的名称
@property (nonatomic,strong) NSString *NotDisturbTimeS;
@property (nonatomic,strong) NSString *LatestRunTime;//最后跑的时间
@property (nonatomic,strong) NSString *ParCategoryName;//第一大类
@property (nonatomic,strong) NSString *Integral;
@property (nonatomic,strong) NSString *PhotoUrl;
@property (nonatomic,strong) NSString *AuthonToken;
@property (nonatomic,strong) NSString *DisplayName;
@property (nonatomic,strong) NSString *HobbiesDetail;//兴趣爱好
@property (nonatomic,strong) NSString *CommentNum;
@property (nonatomic,strong) NSString *Height;
@property (nonatomic,strong) NSString *CategoryName;//运动名称
@property (nonatomic,strong) NSString *Hobbies;
@property (nonatomic,strong) NSString *FriendNotityMsg;
@property (nonatomic,strong) NSString *ReceiveNotifyMsg;
@property (nonatomic,strong) NSString *UserID;
@property (nonatomic,strong) NSString *IsValid;
@property (nonatomic,strong) NSString *IsLocked;
@property (nonatomic,strong) NSString *TotalMileage;
@property (nonatomic,strong) NSString *JoinActivityNum;
@property (nonatomic,strong) NSString *Signature;
@property (nonatomic,strong) NSString *Gender;
@property (nonatomic,strong) NSString *PhoneNo;
@property (nonatomic,strong) NSString *CreateTime;
@property (nonatomic,strong) NSString *SoundNotity;
@property (nonatomic,strong) NSString *NotDisturb;
@property (nonatomic,strong) NSString *ShareNum;
@property (nonatomic,strong) NSString *AdviceNum;
@property (nonatomic,strong) NSString *Weight;
@property (nonatomic,strong) NSString *NotDisturbTimeE;
@property (nonatomic,strong) NSString *OpenVoiceNavigation;
@property (nonatomic,strong) NSString *ScreenAlwaysLight;
@property (nonatomic,strong) NSString *TotalRunNum;
@property (nonatomic,strong) NSString *AgeID;

//是否是完善资料
- (BOOL)isPerfect;

- (NSString *)userID;
+ (NSString *)userID;
//获取单例user
+ (instancetype)sharedUser;
//判断是否登陆
+ (BOOL)isLogin;
//设置登陆成功
+ (void)lginOK;
//同步
- (void)synchronize;
//退出登陆
- (void)exit;
+(instancetype)changeWithUser:(PBUser *)user;


@end
