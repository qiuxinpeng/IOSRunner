//
//  QXPLocationConvert.h
//  airShangHai
//
//  Created by XiaoBai on 13-12-25.
//  Copyright (c) 2013年 QXP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#include <math.h>

/*
 *是集成高德地图SDK
 0->off
 1->on
 */
#ifndef HAVE_AMapSearchKit
#define HAVE_AMapSearchKit 0
#endif




@interface QXPUserLocationInfo : NSObject
@property(nonatomic,strong)NSString *country;//国家
@property(nonatomic,strong)NSString *cityName;//城市
@property(nonatomic,strong)NSString *subAdministrativeArea;//县/区
@property(nonatomic,strong)NSString *thoroughfare;//街道地址
@property(nonatomic,strong)NSString *thoroughCode;//街道号码
@property(nonatomic,strong)NSString *address;//详细信息
@property(nonatomic,strong)NSDictionary *addressDictionary;//地址字典
@property(nonatomic,strong)NSArray *roadinters; // 道路路口信息 AMapRoadInter 数组 只有在使用高德地图地理,反地理编码使用有用
@property(nonatomic)CLLocationCoordinate2D coordinate;
@end


/**
 QXPLocationConvert反地理编码用到的Block
 */
typedef void (^QXPLocationSerchBlock)(NSArray *locationInfos, NSError *error);


@interface QXPLocationConvert : NSObject

//标准坐标系 ==> 火星坐标系
//WGS-84 到 GCJ-02 的转换
CLLocationCoordinate2D WGS84ToGCJ02(CLLocationCoordinate2D wgsCoordinate);

//火星坐标系 ==> 标准坐标系 未实现
//GCJ-02 坐标转换成 WGS-84 坐标
CLLocationCoordinate2D GCJ02ToWGS84(CLLocationCoordinate2D gcjCoordinate);

//火星坐标系==>百度坐标
//GCJ-02 坐标转换成 BD-09 坐标
CLLocationCoordinate2D GCJ02ToBD09(CLLocationCoordinate2D gcjCoordinate);

//百度坐标==>星坐标系
//BD-09 坐标转换成GCJ-02 坐标
CLLocationCoordinate2D BD09ToGCJ02(CLLocationCoordinate2D BDCoordinate);

//标准坐标系 ==> 百度坐标系
//WGS-84 坐标转换成BD-09  坐标
CLLocationCoordinate2D WGS84ToBD09(CLLocationCoordinate2D wgsCoordinate);

//使用google地图地理编码
+ (void)serchWithGooleMaps:(NSString *)title language:(NSString *)tagStr responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block;
//使用google地图反地理编码
+ (void)reverseWithGooleMaps:(CLLocationCoordinate2D)coordinate language:(NSString *)tagStr responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block;


//使用系统自带地理编码
+ (void)serchWithMKMaps:(NSString *)title  responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block;
//使用系统自带反地理编码
+ (void)reverseWithMKMaps:(CLLocationCoordinate2D)coordinate  responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block;

//根据经纬度计算距离
+(double)distanceBetweenOrderBy:(double)lat1 :(double)lng1 :(double)lat2 :(double)lng2;


#if HAVE_AMapSearchKit

+ (QXPLocationConvert *)sharedConvert;

//使用高德地理编码
+ (void)serchWithGaodeMaps:(NSString *)title responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block;
//使用高德反地理编码
+ (void)reverseWithGaodeMaps:(CLLocationCoordinate2D)coordinate  responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block ;

//特别方法 使用google和高德反地理编码 使用google地址 高德路口
+ (void)reverseWithGaodeAndGoogleMaps:(CLLocationCoordinate2D)coordinate  responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block;
//特别方法 使用google和高德反地理编码 使用google地址 高德路口
+ (void)reverseWithGaodeAndGoogleMapsTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block;

#endif


@end
