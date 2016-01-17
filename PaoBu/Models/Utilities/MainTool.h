//
//  MainTool.h
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-7-30.
//  Copyright (c) 2014年 9tong.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainTool : NSObject

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
+ (NSString *)DownLoadDiskSpaceInBytes;
//单个文件大小
+ (long long) fileSizeAtPath:(NSString*) filePath;



@end
