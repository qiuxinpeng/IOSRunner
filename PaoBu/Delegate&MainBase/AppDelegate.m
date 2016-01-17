//
//  AppDelegate.m
//  NewBaLa
//
//  Created by Mr.Qiu on 15/8/4.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "AppDelegate.h"
#import "ADFirstViewController.h"
//#import "MainConfig.h"
//#import "QXPSoundManager.h"
//#import "UserTimeStatistics.h"
//#import "RMTSNSBase.h"
//#import "PlayStatistics.h"
//#import "UMSocialSnsService.h"
//#import "testViewController.h"

@interface AppDelegate ()
//@property(nonatomic, strong)UserTimeStatistics *tongjiOBJ;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    ADFirstViewController *VCFirst=[[ADFirstViewController alloc] initWithNibName:@"ADFirstViewController" bundle:nil];
    [self.window setRootViewController:VCFirst];
    [self.window makeKeyAndVisible];

    //添加高德地图
    [CommonFn addGDMap];

    //测试数据
    //[MainConfig setinfo];
    //准备数据库
    //[MainConfig setingDB];
    //添加键盘中心
   // [MainConfig addIQKeyBoardManager];
    //添加友盟统计
   // [MainConfig addYouMeng];
    //添加友盟分享
   // [MainConfig addYouMengShere];
    //强制通知信息
   // [MainConfig sysforce];
    //首次统计需求
    //[MainConfig firstInstall];
    
    return YES;
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    
//    
//    return [RMTSNSBase application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
//}
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [RMTSNSBase application:application handleOpenURL:url];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"\n ===> 程序进入后台 !");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
//    if ([QXPSoundManager sharedManager].status==AFSoundManagerStatusPlaying) {
//        [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
//        [self resignFirstResponder];
//        
//    }
    
    //[self stopDurationTimer];
    //[[NSNotificationCenter defaultCenter] postNotificationName:APP_DidEnterBackground object:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"\n ===> 程序进入前台 !");
    
    //    [self startDurationTimer];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    [self becomeFirstResponder];
    
    //[self startDurationTimer];
    
    //检查是否需要更新
    [CommonFn checkUpdate];
    
    //[UMSocialSnsService applicationDidBecomeActive];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:APP_DidBecomeActive object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"\n ===> 程序意外暂行 !");
    
    //[self stopDurationTimer];
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
//    if (receivedEvent.type == UIEventTypeRemoteControl) {
//        switch (receivedEvent.subtype) {
//            case UIEventSubtypeRemoteControlTogglePlayPause:{
//                
//                NSLog(@"1");
//                break;
//                
//            }
//            case UIEventSubtypeRemoteControlPlay:{
//                NSLog(@"2");
//                [[QXPSoundManager sharedManager] resume];
//                
//                break;
//                
//            }
//            case UIEventSubtypeRemoteControlPause:{
//                NSLog(@"3");
//                
//                [[QXPSoundManager sharedManager] pause];
//                
//                break;
//                
//            }
//            case UIEventSubtypeRemoteControlStop:
//            {
//                NSLog(@"4");
//                break;
//            }
//                
//            case UIEventSubtypeRemoteControlNextTrack:
//            {
//                //todo play next song
//                NSLog(@"5");
//                
//                break;
//            }
//                
//            case UIEventSubtypeRemoteControlPreviousTrack:
//            {
//                //todo play previous song
//                NSLog(@"6");
//                
//                break;
//            }
//            default:
//                break;
//        }
//    }
//}

//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}

//#pragma mark----- NSTimer
//- (void)startDurationTimer {
//    if (self.durationTimer) {
//        [self stopDurationTimer];
//        self.durationTimer=nil;
//    }
//    NSLog(@"startDurationTimer+++");
//    self.durationTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(monitorMoviePlayback) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:self.durationTimer forMode:NSDefaultRunLoopMode];
//    //userTime=[UserTimeTool getLoginTime];
//    
//    // [UserTimeStatistics getNowOBJ];
//    
//    self.tongjiOBJ=[UserTimeStatistics getNowOBJ];
//}
//- (void)stopDurationTimer {
//    NSLog(@"stopDurationTimer+++");
//    [self.durationTimer invalidate];
//    
//    [self.tongjiOBJ synchronizeToday];
//}

//- (void)monitorMoviePlayback {
//    // NSLog(@"app +++monitorMoviePlayback");
//    [self.tongjiOBJ addTime:3];
//}


@end
