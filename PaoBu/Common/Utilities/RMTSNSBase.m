//
//  RMTSNSBase.m
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-7-21.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import "RMTSNSBase.h"
//#import "RMTSNSInfo.h"
#import "WXApi.h"
#import "UMSocial.h"
@implementation RMTSNSBase

+ (instancetype)base{
    static RMTSNSBase *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[RMTSNSBase alloc] init];
    });
    return _manager;
}

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
//    if ([url.absoluteString rangeOfString:WECHAT_APPID].length > 0) {
//        //微信
//        return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
//    }else if ([url.absoluteString rangeOfString:QQ_APPID].length > 0){
//        //QQ
//        //return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
//
//        return [UMSocialSnsService handleOpenURL:url];
//        return [TencentOAuth HandleOpenURL:url];
//    }else if ([url.absoluteString rangeOfString:SINA_APPKEY].length > 0){
//        //微博
//    }else if ([url.absoluteString rangeOfString:ALIPAY_URL_SCHEME].length > 0){
//        //支付宝
//        return YES;
//    }
    return YES;
}

+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [[self class] application:nil openURL:url sourceApplication:nil annotation:nil];
    return YES;
}


@end
