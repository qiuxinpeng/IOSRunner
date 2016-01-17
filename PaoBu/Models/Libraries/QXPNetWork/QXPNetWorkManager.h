//
//  QXPNetWorkManager.h
//  QXPNetWork
//
//  Created by 小白 on 13-2-22.
//  Copyright (c) 2013年 小白. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "QXPNetWorkConfig.h"
#import "QXPNetWorkDelegate.h"
#import "QXPNetWorkEntityClass.h"
#import "AFNetworking.h"

@interface QXPNetWorkManager : NSObject
/**
 dataSourceObject默认是使用QXPNetWorkLoadDefault,当有比如POST,PUT,SOAP请求的时候可以使用其他类
 当然,也可以使用定制的,前提是你继承<QXPNetWorkLoadDataSource>协议返回ASIHTTPRequest提供连接.
 */
@property(nonatomic, strong)id<QXPNetWorkLoadDataSource> dataSourceObject;

/**
 初始化方法,当ASINetworkQueue为nil的时候默认是用ASINetworkQueue全局默认queue,但这个queue默认最多只允许4个连接
 同时进行,当然你可以修改最大连接数(暂未实现).
 */
- (instancetype)initWithAFHTTPRequestOperationManager:(AFHTTPRequestOperationManager *)manager;
/**
 全局的networkQueue,注意这个并非是当前对象初始化的,所以你可以不用管它的生命周期,这个由其他对象来控制
 */
@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;


/**
 URLString是连接的地址
 */
@property(nonatomic, strong)NSString *URLString;


/**
 parameters是参数数组
 */
@property(nonatomic, strong)NSArray *parameters;


/**
 soapConfig是soap配置参数,只有在使用soap连接的时候有用
 */
@property(nonatomic, strong)QXPNetWorkSOPAEntityClass *soapConfig;


/**
 workType是参数类型
 */
@property(nonatomic )QXPNetWorkType workType;


/**
 用来显示下载进度的回调block
 */
@property(nonatomic, strong)QXPProgressBlock progressBlocks;


/**
 QXPLoadFinishBlock是连接过程成功并返回数据回调block
 */
@property(nonatomic, strong)QXPLoadFinishBlock finishBlocks;

/**
 QXPLoadFailedBlock是连接过程中失败回调block
 */
@property(nonatomic, strong)QXPLoadFailedBlock failedBlocks;


/**
 QXPLoadCancelBlock是连接过程手动取消的回调block
 */
@property(nonatomic, strong)QXPLoadCancelBlock cancelBlocks;


/**
 设置SOAP参数
 只在设置使用SAOP协议时候有用,其它请求方式不必使用
 */
- (void)setSoapConfigInfo:(NSString *)soapName
                soapXmlns:(NSString *)xmlns
             soapXmlnsXsd:(NSString *)xsd
             soapXmlnsXsi:(NSString *)xsi
                 bodyName:(NSString *)bodyName
                bodyXmlns:(NSString *)bodyXmlns;
/**
 开始连接
 */
- (void )connectWithNetWorkType:(QXPNetWorkType)Type;


/**
 取消连接
 */
- (void)cancelConnect;


/**
 设置解析配置.默认为QXPNetWorkSerializeTypeNone
 */
@property(nonatomic, assign)QXPNetWorkSerializeType SerializeType;


/**
 当你使用自定义解析方法时候需要使用它
 */
@property(nonatomic, strong)id<QXPNetWorkSerializeDataSource>SerializeDataSource;


/**
 设置缓存类型,默认是QXPNetWorkCacheTypeNone
 */
@property(nonatomic, assign)QXPNetWorkCacheType cacheType;


/**
 当你使用自定义缓存方法时候需要使用它
 */
@property(nonatomic, strong)id<QXPNetWorkCacheDataSource>cacheDataSource;


/**
 The timeout interval, in seconds, for created requests. The default timeout interval is 60 seconds.
 
 @see NSMutableURLRequest -setTimeoutInterval:
 */
- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval;
@end


