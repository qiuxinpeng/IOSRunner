//
//  MainConfig.m
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-7-8.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import "MainConfig.h"
#import "IQKeyBoardManager.h"
//#import "DDLog+LOGV.h"
//#import "DDTTYLogger.h"
//#import "SysInfoOBJ.h"
//#import "PayManager.h"
//#import "iConsole.h"
//#import "MobClick.h"
//#import "RMTSNSInfo.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

#import <CoreLocation/CoreLocation.h>
//#import "ProgramDetailDownloadCache.h"

#import "BaLaDouStatistics.h"
//#import "PlayStatistics.h"
#import "UserTimeStatistics.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface MainConfig ()<CLLocationManagerDelegate>

@end
@implementation MainConfig
+ (instancetype)config{

    static MainConfig *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[MainConfig alloc] init];
    });
    return _manager;

}
//添加高德地图
+ (void)addGDMap{
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
    [AMapSearchServices sharedServices].apiKey = (NSString *)APIKey;
}
//测试数据
+ (void)setinfo{
    
//    [ProgramDetailDownloadCache search:@"外" callback:^(NSMutableArray *arr) {
//        
//        
//    }];
    //[DDLog addLogger:[DDTTYLogger sharedInstance]];
    //[[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
   // [iConsole sharedConsole].enabled=YES;
    
}
//检查是否需要更新
+ (void)cheakUpdate{
    
    
}
//首次统计需求
+ (void)firstInstall{
    

    
}
//准备数据库
+ (void)setingDB{
    
   }
//添加键盘中心
+ (void)addIQKeyBoardManager{

    //Enabling keyboard manager
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:15];
	//Enabling autoToolbar behaviour. If It is set to NO. You have to manually create IQToolbar for keyboard.
	[[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
	//Setting toolbar behavious to IQAutoToolbarBySubviews. Set it to IQAutoToolbarByTag to manage previous/next according to UITextField's tag property in increasing order.
	[[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    
    //Resign textField if touched outside of UITextField/UITextView.
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    //Giving permission to modify TextView's frame
    [[IQKeyboardManager sharedManager] setCanAdjustTextView:NO];
    
    //Show TextField placeholder texts on autoToolbar
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];
    
    //[IQKeyboardManager sharedManager].overrideKeyboardAppearance=YES;
}
//添加友盟统计
+ (void)addYouMeng{

    /**/
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
//    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
//    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
//    //
//    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
//    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
//    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
//    
//    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
//    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
//    
//    [MobClick updateOnlineConfig];  //在线参数配置
//    
//    
//    QXPDispatch_after(5, ^{
//        [MobClick checkUpdate];
//
//    });
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
     
}
//添加友盟分享
+ (void)addYouMengShere{
    
//    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline]];
//    /**/
//    //设置友盟社会化组件appkey
//    [UMSocialData setAppKey:UMENG_APPKEY];
//    //设置微信AppId，设置分享url，默认使用友盟的网址
//    [UMSocialWechatHandler setWXAppId:WECHAT_APPID appSecret:WECHAT_SECRET url:@"http://www.umeng.com/social"];
//    
//    
//    //    //设置分享到QQ空间的应用Id，和分享url 链接
//    [UMSocialQQHandler setQQWithAppId:QQ_APPID appKey:QQ_KEY url:@"http://www.umeng.com/social"];
//    //    //设置支持没有客户端情况下使用SSO授权
//    [UMSocialQQHandler setSupportWebView:NO];
  
    
}
//改变分享路径
+ (void)changeShereURL:(NSString *)url{
    
    //[UMSocialQQHandler setSupportWebView:NO];

//   // [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
//    
//    [UMSocialWechatHandler setWXAppId:WECHAT_APPID appSecret:WECHAT_SECRET url:url];
//    
//    //    //设置分享到QQ空间的应用Id，和分享url 链接
//    [UMSocialQQHandler setQQWithAppId:QQ_APPID appKey:QQ_KEY url:url];
    
}

//提交筹建康数据
+ (void)postHealthInfo{

    
}
//强制通知信息
+ (void)sysforce {
   
}
@end
