//
//  CommonFn.h
//  PaoBu
//
//  Created by Apple on 16/1/17.
//  Copyright © 2016年 LunSheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFn : NSObject

//添加高德地图
+(void) addGDMap;

//检查是否需要更新
+(void) checkUpdate;

//下载并更新 APP
+(void) downloadUpdate;

// 是否wifi
+ (BOOL) IsEnableWIFI;
// 是否3G
+ (BOOL) IsEnable3G;
// 是否能连接网络
+ (BOOL) IsEnableNetWork;
//是否显示分享按钮
+ (BOOL) IsShowShere;

//获取UDID
+ (NSString* )getUDID4AD;
#pragma mark - IDFA
+ (NSString*)getIDFA;
#pragma mark - MacAddress
+ (NSString *)getMacAddress;
#pragma mark - PhoneNumber
+ (NSString*)getPhoneNumber;

#pragma mark -
+ (UIImage *)imageViaColor:(UIColor *)color;

//更新位置
+ (void)updataUserLocation;

//获取当前lat字符
+ (NSString *)latString;
//获取当前lon字符
+ (NSString *)lonString;

//获取iOS设备型号
+(NSString *)UIDeviceModel;
//获取iOS系统名称
+(NSString *)UIDeviceSystemName;
//获取iOS系统版本
+(NSString *)UIDeviceSystemVersion;
//获取iOS机器尺寸
+(NSString *)UIDeviceMainScreen;
//获取运营商信息
+ (NSString *)UIDeviceTelephonyCarrier;
//获取手机型号
+ (NSString *)UIDeviceModelNO;
//获取还剩下多少空间
+ (NSString *)freeDiskSpaceInBytes;
//下载节目使用的空间
//+ (NSString *)DownLoadDiskSpaceInBytes;
//单个文件大小
+ (long long) fileSizeAtPath:(NSString*) filePath;

void QXPDispatch_after(double time, dispatch_block_t block);

@end
