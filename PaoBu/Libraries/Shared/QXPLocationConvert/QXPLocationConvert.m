//
//  QXPLocationConvert.m
//  airShangHai
//
//  Created by XiaoBai on 13-12-25.
//  Copyright (c) 2013年 QXP. All rights reserved.
//

#import "QXPLocationConvert.h"
#import "AFNetworking.h"
//#import "Reachability.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//#import "JSONKit.h"
#include <AddressBook/ABPerson.h>

#if HAVE_AMapSearchKit
#import <AMapSearchKit/AMapSearchAPI.h>
#endif

#define CONVERT_PROXY_ADDRESS @"10.0.0.172"
#define CONVERT_PROXY_PORT 80






//
// Krasovsky 1940
//
// a = 6378245.0, 1/f = 298.3
// b = a * (1 - f)
// ee = (a^2 - b^2) / a^2;
const double QXP_pi = 3.1415926535897;
const double QXP_a = 6378245.0;
const double QXP_ee = 0.00669342162296594323;

const double x_pi = QXP_pi * 3000.0 / 180.0;

bool outOfChina(double lat, double lon);
static double transformLat(double x, double y);
static double transformLon(double x, double y);

bool outOfChina(double lat, double lon)
{
    if (lon < 72.004 || lon > 137.8347)
        return true;
    if (lat < 0.8293 || lat > 55.8271)
        return true;
    return false;
}

double transformLat(double x, double y)
{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(abs(x));
    ret += (20.0 * sin(6.0 * x * QXP_pi) + 20.0 * sin(2.0 * x * QXP_pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * QXP_pi) + 40.0 * sin(y / 3.0 * QXP_pi)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * QXP_pi) + 320 * sin(y * QXP_pi / 30.0)) * 2.0 / 3.0;
    return ret;
    
}

double transformLon(double x, double y)
{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(abs(x));
    ret += (20.0 * sin(6.0 * x * QXP_pi) + 20.0 * sin(2.0 * x * QXP_pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * QXP_pi) + 40.0 * sin(x / 3.0 * QXP_pi)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * QXP_pi) + 300.0 * sin(x / 30.0 * QXP_pi)) * 2.0 / 3.0;
    return ret;
}

#if HAVE_AMapSearchKit
@interface QXPLocationConvert ()<AMapSearchDelegate>
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong)QXPLocationSerchBlock serchBlock;//地理编码
@property (nonatomic, strong)QXPLocationSerchBlock reverseSerchBlock;//反地理编码
@property (assign)CLLocationCoordinate2D coordinate;

@property (nonatomic, weak)id tempDelegate;
@end
#endif

@implementation QXPLocationConvert

//是否是中国移动
+ (BOOL) isChinaMobile{

    return [[[self getCellularProviderName] objectForKey:@"Carriername"] isEqualToString:@"中国移动"];
}
//获取运营商信息
+(NSDictionary *)getCellularProviderName
{
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier*carrier = [netInfo subscriberCellularProvider];
    //QLog(@"carrier:%@",carrier);
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    if (carrier!=NULL) {
        [dic setObject:[carrier carrierName] forKey:@"Carriername"];
        [dic setObject:[carrier mobileCountryCode] forKey:@"MobileCountryCode"];
        [dic setObject:[carrier mobileNetworkCode]forKey:@"MobileNetworkCode"];
        [dic setObject:[carrier isoCountryCode] forKey:@"ISOCountryCode"];
        [dic setObject:[carrier allowsVOIP]?@"YES":@"NO" forKey:@"AllowsVOIP"];
    }
    return dic;
}


#if HAVE_AMapSearchKit
- (id)init{

    if ((self=[super init])) {
        [self _init];
    }
    return self;
}
- (void)setSearch:(AMapSearchAPI *)search{

    _search=search;
    self.tempDelegate=_search.delegate;
    _search.delegate=self;
}
- (void)_init{
    self.search=[[AMapSearchAPI alloc]initWithSearchKey:GD_APPKEY Delegate:self];
}
#endif


//标准坐标系 ==> 火星坐标系
//WGS-84 到 GCJ-02 的转换
CLLocationCoordinate2D WGS84ToGCJ02(CLLocationCoordinate2D wgsCoordinate){

    double wgLat = wgsCoordinate.latitude;
    double wgLon = wgsCoordinate.longitude;
    
    if (outOfChina(wgLat, wgLon))
    {
        return wgsCoordinate;
    }
    
    double dLat = transformLat(wgLon - 105.0, wgLat - 35.0);
    double dLon = transformLon(wgLon - 105.0, wgLat - 35.0);
    double radLat = wgLat / 180.0 * QXP_pi;
    double magic = sin(radLat);
    magic = 1 - QXP_ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((QXP_a * (1 - QXP_ee)) / (magic * sqrtMagic) * QXP_pi);
    dLon = (dLon * 180.0) / (QXP_a / sqrtMagic * cos(radLat) * QXP_pi);
    
    CLLocationCoordinate2D marsCoordinate = {wgLat + dLat, wgLon + dLon};
    return marsCoordinate;
}
//火星坐标系 ==> 标准坐标系 未实现
//GCJ-02 坐标转换成 WGS-84 坐标
CLLocationCoordinate2D GCJ02ToWGS84(CLLocationCoordinate2D gcjCoordinate){
    return gcjCoordinate;
}

//火星坐标系转换成百度坐标
//GCJ-02 坐标转换成 BD-09 坐标
CLLocationCoordinate2D GCJ02ToBD09(CLLocationCoordinate2D gcjCoordinate){
    
    double wgLat = gcjCoordinate.latitude;
    double wgLon = gcjCoordinate.longitude;
    
    if (outOfChina(wgLat, wgLon))
    {
        return gcjCoordinate;
    }
    
    double x = wgLon, y = wgLat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);

    CLLocationCoordinate2D newCoordinate ={z * sin(theta) + 0.006,z * cos(theta) + 0.0065};
    return newCoordinate;
}
//百度坐标转换火成星坐标系
//BD-09 坐标转换成GCJ-02 坐标
CLLocationCoordinate2D BD09ToGCJ02(CLLocationCoordinate2D BDCoordinate){
    
    double wgLat = BDCoordinate.latitude;
    double wgLon = BDCoordinate.longitude;
    
    if (outOfChina(wgLat, wgLon))
    {
        return BDCoordinate;
    }
    double x = wgLon - 0.0065, y = wgLat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    CLLocationCoordinate2D newCoordinate ={z * sin(theta),z * cos(theta)};
    return newCoordinate;
}
//标准坐标系 ==> 百度坐标系
//WGS-84 坐标转换成BD-09  坐标
CLLocationCoordinate2D WGS84ToBD09(CLLocationCoordinate2D wgsCoordinate){
  
    if (outOfChina(wgsCoordinate.latitude, wgsCoordinate.longitude))
    {
        return wgsCoordinate;
    }
    CLLocationCoordinate2D tempCoordinate=WGS84ToGCJ02(wgsCoordinate);
    return GCJ02ToBD09(tempCoordinate);
}




//使用google地图地理编码
+ (void)serchWithGooleMaps:(NSString *)title language:(NSString *)tagStr responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block{
    
    
    
    
    
   
    /*
    __block CLGeocoder *gecoder=[[CLGeocoder alloc]init];
    __block NSMutableArray *arr_infos2=[[NSMutableArray alloc] init];
    
    NSDictionary *address=@{(__bridge id)kABPersonAddressCityKey:@"shanghai",(__bridge id)kABPersonAddressCountryKey:@"china",(__bridge id)kABPersonAddressStreetKey :@"1885 sichuan road",(__bridge id)kABPersonAddressZIPKey:@"1885"};
    
    [gecoder geocodeAddressDictionary:address  completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for (CLPlacemark *tempPlacemark in placemarks) {
            QLog(@"tempPlacemark:%@",tempPlacemark.addressDictionary);
            
            QXPUserLocationInfo *info=[[QXPUserLocationInfo alloc]init];
            info.address=tempPlacemark.name;
            info.cityName=tempPlacemark.administrativeArea;
            info.subAdministrativeArea=tempPlacemark.subLocality;
            info.thoroughfare=tempPlacemark.thoroughfare;
            info.thoroughCode=tempPlacemark.subThoroughfare;
            info.addressDictionary=tempPlacemark.addressDictionary;
            info.country=tempPlacemark.country;
            info.coordinate=tempPlacemark.location.coordinate;
            [arr_infos2 addObject:info];
            info=nil;
        }
        block(arr_infos2,error);
        arr_infos2=nil;
        gecoder=nil;
    }];
    
     */
    
    /*
    
    NSString *str=[[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&latlng=&sensor=true&language=%@",title,tagStr] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    __block ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:str]];
    //[request setUserAgentString:@"Mr.Liquid"];
    [request addRequestHeader:@"Accept-Language" value:tagStr];
    [request setNumberOfTimesToRetryOnTimeout:REQUST_RESET ];
    [request setPersistentConnectionTimeoutSeconds:15];
    
    if (![self isEnableWIFI] && [self isChinaMobile]) {
        [request setProxyHost:CONVERT_PROXY_ADDRESS];
        [request setProxyPort:CONVERT_PROXY_PORT];
    }
    
    
    __block __weak ASIHTTPRequest *wrequest=request;
    __block NSMutableArray *arr_infos=[[NSMutableArray alloc] init];
    
    [request setCompletionBlock:^{
        NSError *jsonErr=nil;
        NSDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:wrequest.responseData options:NSJSONReadingMutableLeaves error:&jsonErr];
        if (jsonErr) {
            block(nil,[NSError errorWithDomain:@"解析失败!" code:999 userInfo:nil]);
        }else if ([tempDic isKindOfClass:[NSDictionary class]] && [[tempDic objectForKey:@"status"] isEqualToString:@"OK"]){
            NSArray *tempArr=[tempDic objectForKey:@"results"];
            for (NSDictionary *dict in tempArr) {
                
                QXPUserLocationInfo *info=[[QXPUserLocationInfo alloc]init];
                //info.address=[dict objectForKey:@"formatted_address"];
                
                NSArray *tempArr_add=[dict objectForKey:@"address_components"];
                
                for (NSDictionary *addressDict in tempArr_add) {
                    NSString *types=nil;
                    if ([[addressDict objectForKey:@"types"] count]>0) {
                        types=[[addressDict objectForKey:@"types"] objectAtIndex:0];
                    };
                    if ([types isEqualToString:@"street_number"]) {
                        //门牌号
                        info.thoroughCode=[addressDict objectForKey:@"long_name"];
                    }else if ([types isEqualToString:@"route"]){
                        //街道地址
                        info.thoroughfare=[addressDict objectForKey:@"long_name"];
                    }else if ([types isEqualToString:@"sublocality"]){
                        //地区
                        info.subAdministrativeArea=[addressDict objectForKey:@"long_name"];
                    }else if ([types isEqualToString:@"administrative_area_level_1"]||[types isEqualToString:@"administrative_area_level_2"]){
                        //城市
                        info.cityName=[addressDict objectForKey:@"long_name"];

                    }else if ([types isEqualToString:@"country"]){
                        //国家
                        info.country=[addressDict objectForKey:@"long_name"];
                    }
                }
                
                if ([tagStr isEqualToString:@"en"]) {
                    info.address=[QXPLocationConvert specialWithStr:[dict objectForKey:@"formatted_address"] isEN:YES];
                }else{
                    
                    info.address=[NSString stringWithFormat:@"%@%@%@",info.subAdministrativeArea?info.subAdministrativeArea:@"",info.thoroughfare?info.thoroughfare:@"",info.thoroughCode?info.thoroughCode:@""];
                }
                
                //地址字典
                info.addressDictionary=@{@"Country":info.country?info.country:@"",
                                         @"Name":info.address?info.address:@"",
                                          @"State":info.cityName?info.cityName:@"",
                                         @"SubLocality":info.subAdministrativeArea?info.subAdministrativeArea:@"",
                                         @"Thoroughfare":info.thoroughfare?info.thoroughfare:@"",
                                         @"SubThoroughfare":info.thoroughCode?info.thoroughCode:@""
                                         };
                
                
                double lat=[[[[dict objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] doubleValue];
                double lng=[[[[dict objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] doubleValue];
                info.coordinate=CLLocationCoordinate2DMake(lat, lng);
                
                
                [arr_infos addObject:info];
                tempArr_add=nil;
                info=nil;
            }
            tempArr=nil;
            block(arr_infos,nil);
        }else{
            block(nil,[NSError errorWithDomain:@"搜索失败!" code:999 userInfo:nil]);
        }
        
        tempDic=nil;
        arr_infos=nil;
        [wrequest clearDelegatesAndCancel];
        wrequest=nil;
        
    }];
    [request setFailedBlock:^{
        block(nil,[NSError errorWithDomain:@"请求失败!" code:999 userInfo:nil]);
        arr_infos=nil;
        [wrequest clearDelegatesAndCancel];
        wrequest=nil;
    }];
    [request startAsynchronous];
    str=nil;
     
     */
    
}
//使用google地图反地理编码
+ (void)reverseWithGooleMaps:(CLLocationCoordinate2D)coordinate language:(NSString *)tagStr responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block{
    
    /*
    NSString *str=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%lf,%lf&sensor=true&language=%@",coordinate.latitude,coordinate.longitude,tagStr];
    //QLog(@"str:%@",str);
    __block ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:str]];
    [request setUserAgentString:@"Mr.Liquid"];
    [request addRequestHeader:@"Accept-Language" value:tagStr];
    [request setNumberOfTimesToRetryOnTimeout:REQUST_RESET ];
    [request setPersistentConnectionTimeoutSeconds:15];
    if ([self isEnableWIFI] && [self isChinaMobile]) {
        [request setProxyHost:CONVERT_PROXY_ADDRESS];
        [request setProxyPort:CONVERT_PROXY_PORT];
    }
    
    __block __weak ASIHTTPRequest *wrequest=request;
    __block NSMutableArray *arr_infos=[[NSMutableArray alloc] init];
    [request setCompletionBlock:^{
        NSError *jsonErr=nil;
        NSDictionary *tempDic = [NSJSONSerialization JSONObjectWithData:wrequest.responseData options:NSJSONReadingMutableLeaves error:&jsonErr];
        if (jsonErr) {
            block(nil,[NSError errorWithDomain:@"解析失败!" code:999 userInfo:nil]);
        }else if ([tempDic isKindOfClass:[NSDictionary class]] && [[tempDic objectForKey:@"status"] isEqualToString:@"OK"]){
            NSArray *tempArr=[tempDic objectForKey:@"results"];
            for (NSDictionary *dict in tempArr) {
                
                QXPUserLocationInfo *info=[[QXPUserLocationInfo alloc]init];
                
                
                NSArray *tempArr_add=[dict objectForKey:@"address_components"];
                
                for (NSDictionary *addressDict in tempArr_add) {
                    NSString *types=nil;
                    if ([[addressDict objectForKey:@"types"] count]>0) {
                        types=[[addressDict objectForKey:@"types"] objectAtIndex:0];
                    };
                    if ([types isEqualToString:@"street_number"]) {
                        //门牌号
                        info.thoroughCode=[addressDict objectForKey:@"long_name"];
                    }else if ([types isEqualToString:@"route"]){
                        //街道地址
                        info.thoroughfare=[addressDict objectForKey:@"long_name"];
                    }else if ([types isEqualToString:@"sublocality"]){
                        //地区
                        info.subAdministrativeArea=[addressDict objectForKey:@"long_name"];
                    }else if ([types isEqualToString:@"administrative_area_level_1"]||[types isEqualToString:@"administrative_area_level_2"]){
                        //城市
                        info.cityName=[addressDict objectForKey:@"long_name"];
                        
                    }else if ([types isEqualToString:@"country"]){
                        //国家
                        info.country=[addressDict objectForKey:@"long_name"];
                    }
                }
                //地址字典
                info.addressDictionary=@{@"Country":info.country?info.country:@"",
                                         @"Name":info.address?info.address:@"",
                                         @"State":info.cityName?info.cityName:@"",
                                         @"SubLocality":info.subAdministrativeArea?info.subAdministrativeArea:@"",
                                         @"Thoroughfare":info.thoroughfare?info.thoroughfare:@"",
                                         @"SubThoroughfare":info.thoroughCode?info.thoroughCode:@""
                                         };
                
                if ([tagStr isEqualToString:@"en"]) {
                    info.address=[QXPLocationConvert specialWithStr:[dict objectForKey:@"formatted_address"] isEN:YES];
                }else{
                
                    info.address=[NSString stringWithFormat:@"%@%@%@",info.subAdministrativeArea?info.subAdministrativeArea:@"",info.thoroughfare?info.thoroughfare:@"",info.thoroughCode?info.thoroughCode:@""];
                    //info.address=[NSString stringWithFormat:@"%@%@%@",info.subAdministrativeArea,info.thoroughfare,info.thoroughCode];
                }
                
                double lat=[[[[dict objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] doubleValue];
                double lng=[[[[dict objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] doubleValue];
                info.coordinate=CLLocationCoordinate2DMake(lat, lng);
                
                
                [arr_infos addObject:info];
                tempArr_add=nil;
                info=nil;
            }
            tempArr=nil;
            block(arr_infos,nil);
        }else{
            block(nil,[NSError errorWithDomain:@"搜索失败!" code:999 userInfo:nil]);
        }
        
        tempDic=nil;
        arr_infos=nil;
        [wrequest clearDelegatesAndCancel];
        wrequest=nil;
        
    }];
    [request setFailedBlock:^{
        block(nil,[NSError errorWithDomain:@"请求失败!" code:999 userInfo:nil]);
        arr_infos=nil;
        [wrequest clearDelegatesAndCancel];
        wrequest=nil;
    }];
    [request startAsynchronous];
    str=nil;
     
     */
    
}
//使用系统自带地理编码
+ (void)serchWithMKMaps:(NSString *)title  responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block{
    
    __block CLGeocoder *gecoder=[[CLGeocoder alloc]init];
    __block NSMutableArray *arr_infos=[[NSMutableArray alloc] init];
    [gecoder geocodeAddressString:title  completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for (CLPlacemark *tempPlacemark in placemarks) {
            
            QXPUserLocationInfo *info=[[QXPUserLocationInfo alloc]init];
            info.address=tempPlacemark.name;
            info.cityName=tempPlacemark.administrativeArea;
            info.subAdministrativeArea=tempPlacemark.subLocality;
            info.thoroughfare=tempPlacemark.thoroughfare;
            info.thoroughCode=tempPlacemark.subThoroughfare;
            info.addressDictionary=tempPlacemark.addressDictionary;
            info.country=tempPlacemark.country;
            info.coordinate=tempPlacemark.location.coordinate;
            [arr_infos addObject:info];
            info=nil;
        }
        block(arr_infos,error);
        arr_infos=nil;
        gecoder=nil;
    }];
}
//使用系统自带反地理编码
+ (void)reverseWithMKMaps:(CLLocationCoordinate2D)coordinate  responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block{

    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        __block CLGeocoder *gecoder=[[CLGeocoder alloc]init];
        __block NSMutableArray *arr_infos=[[NSMutableArray alloc] init];
        
        [gecoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude] completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark *tempPlacemark in placemarks) {
                
                QXPUserLocationInfo *info=[[QXPUserLocationInfo alloc]init];
                info.address=tempPlacemark.name;
                info.cityName=tempPlacemark.administrativeArea;
                info.subAdministrativeArea=tempPlacemark.subLocality;
                info.thoroughfare=tempPlacemark.thoroughfare;
                info.thoroughCode=tempPlacemark.subThoroughfare;
                info.addressDictionary=tempPlacemark.addressDictionary;
                info.country=tempPlacemark.country;
                info.coordinate=tempPlacemark.location.coordinate;
                [arr_infos addObject:info];
                info=nil;
            }
            block(arr_infos,error);
            arr_infos=nil;
            gecoder=nil;
        }];
    });
}

//根据经纬度计算距离
+(double)distanceBetweenOrderBy:(double)lat1 :(double)lng1 :(double)lat2 :(double)lng2{
    CLLocation* curLocation = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    CLLocation* otherLocation = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    double distance  = [curLocation distanceFromLocation:otherLocation];
    curLocation=nil;
    otherLocation=nil;;
    return distance;
}

#if HAVE_AMapSearchKit

/*地理编码*/
- (void)serchWithGaodeMaps:(NSString *)title{

    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
    geo.address = title;
    [self.search AMapGeocodeSearch:geo];
    geo=nil;
}
/* 逆地理编码 */
- (void)reverseWithGaodeMaps:(CLLocationCoordinate2D)coordinate{
    
    /**/
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.radius=2000;
    regeo.requireExtension = YES;
    [self.search AMapReGoecodeSearch:regeo];
    regeo=nil;
    
}
/*!
 @brief 地理编码 查询回调函数
 @param request 发起查询的查询选项(具体字段参考AMapGeocodeSearchRequest类中的定义)
 @param response 查询结果(具体字段参考AMapGeocodeSearchResponse类中的定义)
 */
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{

    
    if (response.count >0)
    {
        __block NSMutableArray *arr_infos=[[NSMutableArray alloc] init];

        [response.geocodes enumerateObjectsUsingBlock:^(AMapGeocode *obj, NSUInteger idx, BOOL *stop) {
            
            QXPUserLocationInfo *info=[[QXPUserLocationInfo alloc]init];
            info.address=obj.formattedAddress;
            info.cityName=obj.city;
            info.subAdministrativeArea=obj.district;
            info.thoroughCode=obj.adcode;
            info.coordinate=CLLocationCoordinate2DMake(obj.location.latitude, obj.location.longitude);
            
            //地址字典
            info.addressDictionary=@{@"Country":info.country?info.country:@"",
                                     @"Name":info.address?info.address:@"",
                                     @"State":info.cityName?info.cityName:@"",
                                     @"SubLocality":info.subAdministrativeArea?info.subAdministrativeArea:@"",
                                     @"Thoroughfare":info.thoroughfare?info.thoroughfare:@"",
                                     @"SubThoroughfare":info.thoroughCode?info.thoroughCode:@""
                                     };
            
            [arr_infos addObject:info];
            self.serchBlock(arr_infos,nil);
            info=nil;
            arr_infos=nil;
        }];
    }else
        self.serchBlock(nil,[NSError errorWithDomain:@"没有数据" code:800 userInfo:nil]);

}
/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        AMapReGeocode *regeocode=response.regeocode;
        
        QXPUserLocationInfo *info=[[QXPUserLocationInfo alloc]init];
        info.address=regeocode.formattedAddress;
        info.cityName=regeocode.addressComponent.city;
        info.subAdministrativeArea=regeocode.addressComponent.district;
        info.thoroughfare=regeocode.addressComponent.streetNumber.street;
        info.thoroughCode=regeocode.addressComponent.streetNumber.number;
        info.country=regeocode.addressComponent.province;
        info.coordinate=self.coordinate;
        //地址字典
        info.addressDictionary=@{@"Country":info.country?info.country:@"",
                                 @"Name":info.address?info.address:@"",
                                 @"State":info.cityName?info.cityName:@"",
                                 @"SubLocality":info.subAdministrativeArea?info.subAdministrativeArea:@"",
                                 @"Thoroughfare":info.thoroughfare?info.thoroughfare:@"",
                                 @"SubThoroughfare":info.thoroughCode?info.thoroughCode:@""
                                 };
        info.roadinters=regeocode.roadinters;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.reverseSerchBlock([NSArray arrayWithObject:info],nil);
        });
        info=nil;

    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.reverseSerchBlock(nil,[NSError errorWithDomain:@"没有数据" code:800 userInfo:nil]);
        });

    }
}
- (void)search:(id)searchRequest error:(NSString*)errInfo{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([searchRequest isKindOfClass:[AMapReGeocodeSearchRequest class]]) {
            self.reverseSerchBlock(nil,[NSError errorWithDomain:@"失败" code:800 userInfo:nil]);
        }else{
            self.serchBlock(nil,[NSError errorWithDomain:@"失败" code:800 userInfo:nil]);
        }
    });
    
}
- (void)releaseResources{
    
    self.serchBlock=nil;
    self.search=nil;
    self.search.delegate=self.tempDelegate;
    NSMutableArray *resources = [NSMutableArray array];
    [resources addObject:self];
    [[self class] performSelectorOnMainThread:@selector(releaseResources:) withObject:resources waitUntilDone:[NSThread isMainThread]];
    
}

// 始终在主线程执行
+ (void)releaseResources:(NSArray *)resources
{
	// 该方法退出时blocks将被释放时，
}
//使用高德地理编码
+ (void)serchWithGaodeMaps:(NSString *)title responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block{
    QXPLocationConvert *convet=[QXPLocationConvert sharedConvert];
    [convet setSerchBlock:block];
    [convet serchWithGaodeMaps:title];
}

//使用高德反地理编码
+ (void)reverseWithGaodeMaps:(CLLocationCoordinate2D)coordinate  responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block{
    
    QXPLocationConvert *convet=[QXPLocationConvert sharedConvert];
    convet.reverseSerchBlock=block;
    convet.coordinate=coordinate;
    [convet reverseWithGaodeMaps:coordinate];
}
//特别方法 使用google和高德反地理编码 使用google地址 高德路口
+ (void)reverseWithGaodeAndGoogleMaps:(CLLocationCoordinate2D)coordinate  responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block{

    [QXPLocationConvert reverseWithGooleMaps:coordinate language:@"zh-en" responseBlock:^(NSArray *locationInfos, NSError *error) {
        
        if (!error && locationInfos.count>0) {
            
            __block QXPUserLocationInfo *googleObj=locationInfos[0];
            [QXPLocationConvert reverseWithGaodeMaps:coordinate responseBlock:^(NSArray *locationInfos, NSError *error) {
                
                if (!error && locationInfos.count>0){
                    QXPUserLocationInfo *gaode=locationInfos[0];
                    gaode.address=googleObj.address;
                    block([NSArray arrayWithObject:gaode],nil);
                    gaode=nil;
                }else{
                    block(nil,[NSError errorWithDomain:@"shibai" code:888 userInfo:nil]);
                }
                googleObj=nil;
            }];
        }else{
            block(nil,[NSError errorWithDomain:@"shibai" code:888 userInfo:nil]);
        }
    }];

}
//特别方法 使用google和高德反地理编码 使用google地址 高德路口
+ (void)reverseWithGaodeAndGoogleMapsTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate responseBlock:(void (^)(NSArray *locationInfos, NSError *error))block{
    
    
    if (title) {
        [QXPLocationConvert serchWithGooleMaps:title language:@"zh-Hans" responseBlock:^(NSArray *locationInfos, NSError *error) {
            
            if (!error && locationInfos.count>0) {
                
                __block QXPUserLocationInfo *googleObj=locationInfos[0];
                [QXPLocationConvert reverseWithGaodeMaps:coordinate responseBlock:^(NSArray *locationInfos, NSError *error) {
                    
                    if (!error && locationInfos.count>0){
                        QXPUserLocationInfo *gaode=locationInfos[0];
                        gaode.address=googleObj.address;
                        block([NSArray arrayWithObject:gaode],nil);
                        gaode=nil;
                    }else{
                        block(nil,[NSError errorWithDomain:@"shibai" code:888 userInfo:nil]);
                    }
                    googleObj=nil;
                }];
            }else{
                block(nil,[NSError errorWithDomain:@"shibai" code:888 userInfo:nil]);
            }
            
        }];
    }else{
        [QXPLocationConvert reverseWithGooleMaps:coordinate language:@"zh-en" responseBlock:^(NSArray *locationInfos, NSError *error) {
            
            if (!error && locationInfos.count>0) {
                
                __block QXPUserLocationInfo *googleObj=locationInfos[0];
                [QXPLocationConvert reverseWithGaodeMaps:coordinate responseBlock:^(NSArray *locationInfos, NSError *error) {
                    
                    if (!error && locationInfos.count>0){
                        QXPUserLocationInfo *gaode=locationInfos[0];
                        gaode.address=googleObj.address;
                        block([NSArray arrayWithObject:gaode],nil);
                        gaode=nil;
                    }else{
                        block(nil,[NSError errorWithDomain:@"shibai" code:888 userInfo:nil]);
                    }
                    googleObj=nil;
                }];
            }else{
                block(nil,[NSError errorWithDomain:@"shibai" code:888 userInfo:nil]);
            }
        }];
        
    }
}
+ (QXPLocationConvert *)sharedConvert{
    static QXPLocationConvert *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[QXPLocationConvert alloc] init];
    });
    return _manager;
}
#endif

+ (NSString *)specialWithStr:(NSString *)str isEN:(BOOL)en{

    if (en) {
        
        NSMutableString *tempStr=[NSMutableString string];
        NSArray *tempArr=[str componentsSeparatedByString:@", "];
        
        if (tempArr.count>2) {
            [tempStr appendString:tempArr[0]];
            [tempStr appendString:@", "];
            [tempStr appendString:tempArr[1]];
        }else
            [tempStr appendString:str];
        tempArr=nil;
        return tempStr;
    }else{
        
        return str;
    }
    return nil;
}

@end

@implementation  QXPUserLocationInfo
@end
