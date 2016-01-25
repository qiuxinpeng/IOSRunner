//
//  RMTSNSBase.h
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-7-21.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import "WXApi.h"


@interface RMTSNSBase : NSObject
+ (instancetype)base;

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
+ (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
@end
