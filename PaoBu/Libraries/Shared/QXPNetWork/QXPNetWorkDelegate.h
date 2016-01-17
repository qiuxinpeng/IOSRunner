//
//  QXPNetWorkDelegate.h
//  QXPNetWork
//
//  Created by 小白 on 13-2-22.
//  Copyright (c) 2013年 小白. All rights reserved.
//

typedef NS_ENUM(NSInteger, QXPNetWorkType) {
    /// 默认连接类型,大多数时候都使用这个
    QXPNetWorkTypeGet = 1,
    
    /// POST请求
    QXPNetWorkTypePost = 2,
    
    /// PUT请求,当接口要求使用直接POST一段json或者其他数据
    QXPNetWorkTypePUT = 3,
    
    /// SOAP请求
    QXPNetWorkTypeSoap = 4
};
typedef NS_ENUM(NSInteger, QXPNetWorkParameterType) {
    
    /// 默认参数类型,大多数时候都使用这个
    QXPNetWorkParameterTypeDefault = 1,
    
    /// 当出现表单提交图片或者文件的时候使用,提交的参数是NSData类型
    QXPNetWorkParameterTypeForm = 2,
    
    /// 提交表单是路径的参数,通常使用在上传的文件比较大的情况下
    QXPNetWorkParameterTypeFormPath = 3,
    
    /// PUT提交参数,参数只有一个
    QXPNetWorkParameterTypePUT = 4
};

typedef NS_ENUM(NSInteger, QXPNetWorkSerializeType) {
    
    /// 默认类型,拿到原始数据
    QXPNetWorkSerializeTypeNone = 1,
    
    /// 使用JSON解析
    QXPNetWorkSerializeTypeJSON = 2,
    
    /// 使用XML解析
    QXPNetWorkSerializeTypeXML = 3,
    
    /// 定制解析 需要是实现QXPNetWorkSerializeDataSource
    QXPNetWorkSerializeTypeCustom = 4,
    
    /// 默认类型,拿到原始字符串数据
    QXPNetWorkSerializeTypeString = 5,
};

typedef NS_ENUM(NSInteger, QXPNetWorkCacheType) {
    
    /// 默认无缓存
    QXPNetWorkCacheTypeNone = 1,
    
    ///设置缓存数据存储策略，这里采取的是如果无更新或无法联网就读取缓存数据
    QXPNetWorkCacheTypeSystem = 2,
    
    /// 把缓存数据永久保存在本地
    QXPNetWorkCacheTypeSystemStorage=3,
    
    /// 强制使用缓存,只要没有网络连接,就从缓存里查找数据,有网络就是用网络数据
    QXPNetWorkCacheTypeCompel = 4,
    
    /// 定制缓存 需要是实现缓存使用策略QXPNetWorkCacheDataSource
    QXPNetWorkCacheTypeCustom = 5
};






#import <Foundation/Foundation.h>
///#import "ASIHTTPRequest.h"
@class AFHTTPRequestOperation;
@class QXPNetWorkManager;


/**
 BasicBlock
 */
typedef void (^QXPBasicBlock)(void);

/**
 QXPProgressBlock是连接过程中返回数据每次下载的数据大小
 */
typedef void (^QXPProgressBlock)(unsigned long long size, unsigned long long total);
/**
 QXPLoadFailedBlock是连接过程中失败回调block
 */
typedef void (^QXPLoadFailedBlock)(NSError *error);
/**
 QXPLoadFinishBlock是连接过程成功并返回数据回调block
 */
typedef void (^QXPLoadFinishBlock)(id responseObje);
/**
 QXPLoadCancelBlock是连接过程手动取消的回调block
 */
typedef void (^QXPLoadCancelBlock)();

@protocol QXPNetWorkLoadDataSource<NSObject>

/**
 requestWithQXPNetWorkLoad默认是QXPDownLoadManager在使用的时候用QXPNetWorkLoadDataSource返回的ASIHTTPRequest
 进行连接.
 */
@required
- (AFHTTPRequestOperation *)requestWithQXPNetWorkLoad:(QXPNetWorkManager *)manager cacheType:(QXPNetWorkCacheType)type;

@end

@protocol QXPNetWorkSerializeDataSource<NSObject>

/**
 进行自定义的解析,目的是使解析更加灵活,特别适用语于XML里面包JSON格式或者反之,当然还有更加复杂结构,只要你想,你都能做到.
 注意,本身已经使用异步,请勿在此方法再次异步
 */
@required
- (id)QXPNetWorkManager:(QXPNetWorkManager *)manager serializeWithData:(NSData *)data error:(NSError **)error;

@end


/**
 进行自定义的缓存,目的是使缓存更加灵活,特别适用复杂的缓存策略
 注意,本身已经使用异步,请勿在此方法再次异步
 */
@protocol QXPNetWorkCacheDataSource <NSObject>

@required
- (NSData *)QXPNetWorkManager:(QXPNetWorkManager *)manager cacheWithQXPNetWorkType:(QXPNetWorkType)type;
- (void)QXPNetWorkManager:(QXPNetWorkManager *)manager responseData:(NSData *)data;

@end



