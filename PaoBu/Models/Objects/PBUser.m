//
//  PBUser.m
//  PaoBu
//
//  Created by Apple on 16/1/17.
//  Copyright © 2016年 LunSheng. All rights reserved.
//

#import "PBUser.h"
#import "EGOCache.h"
//#import "InterFaceModels.h"

@implementation PBUser

#define keyStr @"ZCUserUser-yser"
#define getKey(member) [NSString stringWithFormat:@"ZCUserser-%u",member.hash]

static PBUser *_tempUser=nil;

+(BOOL)isContainParent
{
    return YES;
}
+ (instancetype)sharedUser{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[EGOCache globalCache] hasCacheForKey:getKey(keyStr)]) {
            __strong id temp=[[EGOCache globalCache] objectForKey:getKey(keyStr)];
            if ([temp isKindOfClass:[PBUser class]]) {
                _tempUser=temp;
            }else{
                _tempUser=[[PBUser alloc]init];
            }
        }else{
            _tempUser=[[PBUser alloc]init];
        }
    });
    return _tempUser;
}
//是否是完善资料
- (BOOL)isPerfect{
    return YES;
}
+ (NSString *)userID{
    if ([self isLogin]) {
        return [PBUser sharedUser].UserID;
    }
    return @"-1";
}
- (NSString *)userID{
    return self.UserID;
}
//判断是否登陆
+ (BOOL)isLogin{
    PBUser *userd=[PBUser sharedUser];
    if (userd.UserID) {
        return YES;
    }
    return NO;
}
//设置登陆成功
+ (void)lginOK{
    [[NSNotificationCenter defaultCenter] postNotificationName:ZCUserLoginNotificationName object:nil];
}
//同步
- (void)synchronize{
    [PBUser changeWithUser:self];
    [[EGOCache globalCache] setObject:self forKey:getKey(keyStr) withTimeoutInterval:NSTimeIntervalSince1970];
}
//退出登陆
- (void)exit{
    [[NSNotificationCenter defaultCenter] postNotificationName:ZCUserExitNotificationName object:nil];
    [[EGOCache globalCache] removeCacheForKey:getKey(keyStr)];
    [PBUser  changeWithUser:nil];
    [[PBUser sharedUser] synchronize];
}
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil;
}

+(instancetype)changeWithUser:(PBUser *)user{
    //    [PBUser sharedUser].UserID = user.UserID;
    //    [PBUser sharedUser].DisplayName                = user.DisplayName;
    //    [PBUser sharedUser].EMail   = user.EMail;
    //    [PBUser sharedUser].PhoneNo                      = user.PhoneNo;
    //    [PBUser sharedUser].LastLoginTime                 = user.LastLoginTime;
    //    [PBUser sharedUser].CreateTime              = user.CreateTime;
    _tempUser=user;
    
    return [PBUser sharedUser];
}


@end
