//
//  QXPNetWorkInterface.m
//  QXPNetWork
//
//  Created by 小白 on 13-3-7.
//  Copyright (c) 2013年 小白. All rights reserved.
//

#import "QXPNetWorkInterface.h"
#import "QXPNetWorkManager.h"
#import "AFNetworkActivityIndicatorManager.h"




@implementation QXPNetWorkQueue

- (instancetype)init{
    if ((self=[super init])){
        _manager= [AFHTTPRequestOperationManager manager];
        [_manager.operationQueue setMaxConcurrentOperationCount:6];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_manager.requestSerializer setTimeoutInterval:REQUST_TIMEOUT];
        
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        _downloadDelegates=[[NSMutableArray alloc] init];
        //[(ASINetworkQueue*)_quequ go];
    }
    return self;
}
- (NSOperationQueue *)quequ{

    return self.manager.operationQueue;
}
- (void)cancelAll{

    [self.quequ cancelAllOperations];

}
+ (id)sharedQueue
{
    static dispatch_once_t pred = 0;
    __strong static QXPNetWorkQueue *_sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

+ (void)addInterFace:(id)face{

    [[[QXPNetWorkQueue sharedQueue] downloadDelegates] addObject:face];
}
+ (void)removeInterFace:(id)face{

     NSUInteger idx;
    while ((idx = [[[QXPNetWorkQueue sharedQueue] downloadDelegates] indexOfObjectIdenticalTo:face]) != NSNotFound)
    {
        [[[QXPNetWorkQueue sharedQueue] downloadDelegates] removeObjectAtIndex:idx];
    }
}
+ (void)removeInterFaceWithClass:(NSString *)tag{

    NSArray *arr=[NSArray arrayWithArray:[[QXPNetWorkQueue sharedQueue] downloadDelegates]];
    
    [arr enumerateObjectsUsingBlock:^(QXPNetWorkInterface *obj, NSUInteger idx, BOOL *stop) {
        
        if (obj.tagString && [obj.tagString isEqualToString:tag]){
            // NSLog(@"%@cale",obj);
            //obj.tagString=nil;
            //[QXPNetWorkQueue removeInterFace:obj];
            [obj cancel];
            obj=nil;
        }
    }];
    [[self class] performSelectorOnMainThread:@selector(releaseBlocks:) withObject:arr waitUntilDone:[NSThread isMainThread]];
    arr=nil;
}

// 始终在主线程执行
+ (void)releaseBlocks:(NSArray *)InterFaces
{
	// 该方法退出时对象将被释放时，
}
- (void)dealloc{
    [_downloadDelegates removeAllObjects];
    _downloadDelegates=nil;
    [self.quequ cancelAllOperations];
}
@end


@interface QXPNetWorkInterface();


@property(nonatomic,assign)UIView *HUDBackgroundView;
@property(nonatomic,strong)NSString *HUDString;
@property(nonatomic,strong)QXPNetWorkManager *manager;

/**
 soapConfig是soap配置参数,只有在使用soap连接的时候有用
 */
@property(nonatomic, retain)QXPNetWorkSOPAEntityClass *soapConfig;

//- (instancetype)initWithBlocks:(QXPLoadFinishBlock)finshBlick faildBlock:(QXPLoadFailedBlock)faildBlock cancelBlock:(QXPLoadCancelBlock)cancelBlock connectType:(QXPNetWorkType)type URLString:(NSString *)urlString interFaceHUD:(QXPLoadHUDStyle)style HUDString:(NSString *)string HUDBackgroundView:(UIView *)backgroundView;

- (instancetype)initWithBlocks:(QXPLoadFinishBlock)finshBlick faildBlock:(QXPLoadFailedBlock)faildBlock cancelBlock:(QXPLoadCancelBlock)cancelBlock connectType:(QXPNetWorkType)type URLString:(NSString *)urlString interFaceHUD:(QXPLoadHUDStyle)style HUDString:(NSString *)string HUDBackgroundView:(UIView *)backgroundView tag:(NSString *)str;


- (void)performBlockOnMainThread:(QXPBasicBlock)block;
- (void)releaseBlocksOnMainThread;
- (void)releaseSelf;
+ (void)releaseBlocks:(NSArray *)blocks;
- (void)callBlock:(QXPBasicBlock)block;
@end

@implementation QXPNetWorkInterface
@synthesize loadFaildBlock=_loadFaildBlock,loadFinshBlock=_loadFinshBlock,loadProgressBlock=_loadProgressBlock;
//@synthesize URLString=_URLString;
@synthesize MBHUDView=_MBHUDView, connectType=_connectType, HUDStyle=_HUDStyle;


@synthesize SerializeType=_SerializeType;
@synthesize cacheType=_cacheType;

@synthesize  dimBackground=_dimBackground, HUDUserInteractionEnabled=_HUDUserInteractionEnabled;
@synthesize soapConfig=_soapConfig;


- (void)setSerializeType:(QXPNetWorkSerializeType)SerializeType{
    _SerializeType=SerializeType;
    if (_SerializeType==QXPNetWorkSerializeTypeCustom) {
        [self.manager setSerializeDataSource:self];
    }
}
- (void)setCacheType:(QXPNetWorkCacheType)cacheType{
    _cacheType=cacheType;
    if (_cacheType==QXPNetWorkCacheTypeCustom) {
        [self.manager setCacheDataSource:self];
    }
}
- (void)setSoapConfig:(QXPNetWorkSOPAEntityClass *)soapConfig{
    _soapConfig=soapConfig;
    [self.manager setSoapConfig:_soapConfig];
}
- (void)setMBHUDView:(MBProgressHUD *)MBHUDView{
    _MBHUDView=MBHUDView;
}

// 始终在主线程执行
+ (void)releaseBlocks:(NSArray *)blocks
{
	// 该方法退出时blocks将被释放时，
}
- (void)performBlockOnMainThread:(QXPBasicBlock)block
{
	[self performSelectorOnMainThread:@selector(callBlock:) withObject:block   waitUntilDone:[NSThread isMainThread]];
}
- (void)callBlock:(QXPBasicBlock)block
{
	block();
}
- (void)releaseSelf{

    self.manager=nil;
    [self releaseBlocksOnMainThread];
    /**/
    NSMutableArray *blocks = [NSMutableArray array];
    [blocks addObject:self];
    [[self class] performSelectorOnMainThread:@selector(releaseBlocks:) withObject:blocks waitUntilDone:[NSThread isMainThread]];
    

}
- (void)releaseBlocksOnMainThread{
    
    /**/
    NSMutableArray *blocks = [NSMutableArray array];
    if (_loadFinshBlock) {
        [blocks addObject:_loadFinshBlock];
        _loadFinshBlock=nil;
    }
    if (_loadFaildBlock) {
        [blocks addObject:_loadFaildBlock];
        _loadFaildBlock=nil;
    }
    if (_loadProgressBlock) {
        [blocks addObject:_loadProgressBlock];
        _loadProgressBlock=nil;
    }
    if (_loadCancelBlock) {
        [blocks addObject:_loadCancelBlock];
        _loadCancelBlock=nil;
    }
    [[self class] performSelectorOnMainThread:@selector(releaseBlocks:) withObject:blocks waitUntilDone:[NSThread isMainThread]];
     
}

+ (void)cancelAll{

    [[QXPNetWorkQueue sharedQueue] cancelAll];
}

- (void)cancel{

    [_manager cancelConnect];
}

+ (void)cancelForTag:(NSString *)str{

    [QXPNetWorkQueue removeInterFaceWithClass:str];
}

- (void)dealloc{
    //[self.URLString release];
    self.manager=nil;
    self.tagString=nil;
    self.MBHUDView=nil;
    self.HUDString=nil;
    self.soapConfig=nil;;
}
- (instancetype)init{
    if ((self=[super init])){
        
        self.cacheType=QXPNetWorkCacheTypeNone;
        self.SerializeType=QXPNetWorkSerializeTypeNone;
        self.HUDUserInteractionEnabled=NO;
        self.dimBackground=NO;
        self.manager=[[QXPNetWorkManager alloc] initWithAFHTTPRequestOperationManager:[QXPNetWorkQueue sharedQueue].manager] ;

    }
    return  self;
}
- (instancetype)initWithBlocks:(QXPLoadFinishBlock)finshBlick faildBlock:(QXPLoadFailedBlock)faildBlock cancelBlock:(QXPLoadCancelBlock)cancelBlock connectType:(QXPNetWorkType)type URLString:(NSString *)urlString interFaceHUD:(QXPLoadHUDStyle)style HUDString:(NSString *)string HUDBackgroundView:(UIView *)backgroundView tag:(NSString *)str{

    if ((self=[super init])) {
        
        
        self.cacheType=QXPNetWorkCacheTypeNone;
        self.SerializeType=QXPNetWorkSerializeTypeNone;
        self.HUDUserInteractionEnabled=NO;
        self.dimBackground=NO;
        self.manager=[[QXPNetWorkManager alloc] initWithAFHTTPRequestOperationManager:[QXPNetWorkQueue sharedQueue].manager] ;
        
        self.loadFinshBlock=finshBlick;
        self.loadFaildBlock=faildBlock;
        self.loadCancelBlock=cancelBlock;
        //self.URLString=string;
        self.connectType=type;
        
        if (backgroundView)
            self.HUDBackgroundView=backgroundView;
        else
            self.HUDBackgroundView=[[UIApplication sharedApplication] keyWindow];
        
        self.HUDString=string;
        self.HUDStyle=style;
        //self.URLString=urlString;
        if (str) {
            self.tagString=str;
        }else
            self.tagString=nil;
    }
    return  self;
}
/*
- (instancetype)initWithBlocks:(QXPLoadFinishBlock)finshBlick faildBlock:(QXPLoadFailedBlock)faildBlock cancelBlock:(QXPLoadCancelBlock)cancelBlock connectType:(QXPNetWorkType)type URLString:(NSString *)urlString interFaceHUD:(QXPLoadHUDStyle)style HUDString:(NSString *)string HUDBackgroundView:(UIView *)backgroundView{

    if ((self=[super init])) {
        
        self.cacheType=QXPNetWorkCacheTypeNone;
        self.SerializeType=QXPNetWorkSerializeTypeNone;
        self.HUDUserInteractionEnabled=NO;
        self.dimBackground=NO;
        self.manager=[[QXPNetWorkManager alloc] initWithAFHTTPRequestOperationManager:[QXPNetWorkQueue sharedQueue].manager] ;
        
        
        self.loadFinshBlock=finshBlick;
        self.loadFaildBlock=faildBlock;
        self.loadCancelBlock=cancelBlock;
        //self.URLString=string;
        self.connectType=type;
        
        if (backgroundView)
            self.HUDBackgroundView=backgroundView;
        else
            self.HUDBackgroundView=[[UIApplication sharedApplication] keyWindow];
        
        self.HUDString=string;
        self.HUDStyle=style;
        //self.URLString=urlString;
        self.tagString=nil;

        
    }
    return self;
}
*/
- (MBProgressHUDMode)getHUDMode{

    switch (self.HUDStyle) {
        case QXPLoadHUDStyleDefault: return MBProgressHUDModeIndeterminate;
        case QXPLoadHUDStyleAnnularDeterminate: return MBProgressHUDModeAnnularDeterminate;
        case QXPLoadHUDStyleDeterminate: return MBProgressHUDModeDeterminate;
        case QXPLoadHUDStyleCustomView: return MBProgressHUDModeCustomView;
        default: return MBProgressHUDModeIndeterminate;
    }
}
- (void)starLoadInformationWithParameters:(NSArray *)arr URLString:(NSString *)string connectType:(QXPNetWorkType)type{
    //self.URLString=string;
    __weak __typeof(self)weakSelf = self;
    //__weak __typeof(self)strongSelf = self;
    //__block QXPNetWorkInterface *strongSelf=self;

    self.connectType=type;
    if (self.HUDStyle>0) {
        self.MBHUDView = [[MBProgressHUD alloc] initWithView:self.HUDBackgroundView] ;
        [self.HUDBackgroundView addSubview:self.MBHUDView];
        self.MBHUDView.labelText = self.HUDString;
        [self.MBHUDView show:YES];
        self.MBHUDView.mode = [self getHUDMode ];
        self.MBHUDView.removeFromSuperViewOnHide=YES;
        
    }
    if (self.tagString) {
        [QXPNetWorkQueue addInterFace:self];
    }
    self.manager.URLString=string;
    [self.manager setSerializeType:self.SerializeType];
    [self.manager setCacheType:self.cacheType];
    [self.manager setFinishBlocks:^(id responseObje){
        __strong __typeof(weakSelf)strongSelf = weakSelf;

        id object=responseObje ;
        if (strongSelf.loadFinshBlock) {
            strongSelf.loadFinshBlock(object);
            //[strongSelf performBlockOnMainThread:^{ if(strongSelf.loadFinshBlock) strongSelf.loadFinshBlock(object);}];
        }
        [strongSelf.MBHUDView hide:YES];
        
        if (strongSelf.tagString) {
            [QXPNetWorkQueue removeInterFace:strongSelf];
            strongSelf.tagString=nil;
        }
        [strongSelf releaseSelf];
        object=nil;
        //strongSelf=nil;

    }];
    [self.manager setFailedBlocks:^(NSError *err){
        __strong __typeof(weakSelf)strongSelf = weakSelf;

        NSError *error=err;
        if (strongSelf.loadFaildBlock) {
            strongSelf.loadFaildBlock(error);
         //[strongSelf performBlockOnMainThread:^{ if(strongSelf.loadFaildBlock) strongSelf.loadFaildBlock(error);}];
        }
        [strongSelf.MBHUDView hide:YES];
       
        if (strongSelf.tagString) {
            [QXPNetWorkQueue removeInterFace:strongSelf];
            strongSelf.tagString=nil;
        }

        [strongSelf releaseSelf];
        
        error=nil;
        //strongSelf=nil;

    }];
    [self.manager setCancelBlocks:^(){
        __strong __typeof(weakSelf)strongSelf = weakSelf;

        if (strongSelf.loadCancelBlock) {
            strongSelf.loadCancelBlock();
            //[strongSelf performBlockOnMainThread:^{ if(strongSelf.loadCancelBlock) strongSelf.loadCancelBlock();}];
        }
        [strongSelf.MBHUDView hide:YES];
        
        if (strongSelf.tagString) {
            [QXPNetWorkQueue removeInterFace:strongSelf];
            strongSelf.tagString=nil;
        }
        [strongSelf releaseSelf];
       // strongSelf=nil;

    }];
    if (self.loadProgressBlock) {
        [_manager setProgressBlocks:^(unsigned long long size, unsigned long long total){
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            if (strongSelf.MBHUDView) {
                float progressAmount = (float)((size*1.0)/(total*1.0));
                [strongSelf.MBHUDView setProgress:progressAmount];
            }
            if (strongSelf.loadProgressBlock) {
                strongSelf.loadProgressBlock(size,total);
                //[strongSelf performBlockOnMainThread:^{ if(strongSelf.loadProgressBlock) strongSelf.loadProgressBlock(size,total);}];
            }
        }];
 
    }
    [self.manager setParameters:arr];
    [self.manager connectWithNetWorkType:type];
    
    //[self release];
}
/**
 设置自定义请求方法
 只在设置使用自定义请求时候有用,其它请求方式不必使用,默认提供4种请求
 */
- (void)setQXPNetWorkLoadDataSource:(id<QXPNetWorkLoadDataSource>)dataSourceObject{

    [self.manager setDataSourceObject:dataSourceObject];
}

/**
 设置SOAP参数
 只在设置使用SAOP协议时候有用,其它请求方式不必使用
 */
- (void)setSoapConfigInfo:(NSString *)soapName
                soapXmlns:(NSString *)xmlns
             soapXmlnsXsd:(NSString *)xsd
             soapXmlnsXsi:(NSString *)xsi
                 bodyName:(NSString *)bodyName
                bodyXmlns:(NSString *)bodyXmlns{

    QXPNetWorkSOPAEntityClass *soap=[[QXPNetWorkSOPAEntityClass alloc]init];
    soap.soapName=soapName;
    soap.soapXmlns=xmlns;
    soap.soapXmlnsXsd=xsd;
    soap.soapXmlnsXsi=xsi;
    soap.soapBodyName=bodyName;
    soap.soapBodyXmlns=bodyXmlns;
    self.soapConfig=soap;
    soap=nil;
}
+ (instancetype)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                          tag:(NSString *)str{
    
    return [[self alloc] initWithBlocks:finshBlock faildBlock:faildBlock cancelBlock:nil connectType:0 URLString:nil interFaceHUD:0 HUDString:nil HUDBackgroundView:nil tag:str] ;
}
+ (instancetype)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                  cancelBlock:(void(^)())cancelBlock
                          tag:(NSString *)str{
    return [[self alloc] initWithBlocks:finshBlock faildBlock:faildBlock cancelBlock:cancelBlock connectType:0 URLString:nil interFaceHUD:0 HUDString:nil HUDBackgroundView:nil tag:str];
}
+ (instancetype)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
            HUDBackgroundView:(UIView *)view
                          tag:(NSString *)str{
    
    return [[self alloc] initWithBlocks:finshBlock faildBlock:faildBlock cancelBlock:nil connectType:0 URLString:nil interFaceHUD:QXPLoadHUDStyleDefault HUDString:HUD_STRING_DEFAULT HUDBackgroundView:view tag:str] ;
}

+ (instancetype)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                  cancelBlock:(void(^)())cancelBlock
            HUDBackgroundView:(UIView *)view
                          tag:(NSString *)str{
    
    return [[self alloc] initWithBlocks:finshBlock faildBlock:faildBlock cancelBlock:cancelBlock connectType:0 URLString:nil interFaceHUD:QXPLoadHUDStyleDefault HUDString:HUD_STRING_DEFAULT HUDBackgroundView:view tag:str] ;
}

+ (instancetype)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                 interFaceHUD:(QXPLoadHUDStyle)style
            HUDBackgroundView:(UIView *)view
                          tag:(NSString *)str{
    
    return [[self alloc] initWithBlocks:finshBlock faildBlock:faildBlock cancelBlock:nil connectType:0 URLString:nil interFaceHUD:style HUDString:HUD_STRING_DEFAULT HUDBackgroundView:view tag:str] ;
}

+ (instancetype)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                  cancelBlock:(void(^)())cancelBlock
                 interFaceHUD:(QXPLoadHUDStyle)style
            HUDBackgroundView:(UIView *)view
                          tag:(NSString *)str{
    
    return [[self alloc] initWithBlocks:finshBlock faildBlock:faildBlock cancelBlock:cancelBlock connectType:0 URLString:nil interFaceHUD:style HUDString:HUD_STRING_DEFAULT HUDBackgroundView:view tag:str] ;
}


+ (instancetype)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                 interFaceHUD:(QXPLoadHUDStyle)style
                    HUDString:(NSString *)string
            HUDBackgroundView:(UIView *)view
                          tag:(NSString *)str{
    
    return [[self alloc] initWithBlocks:finshBlock faildBlock:faildBlock cancelBlock:nil connectType:0 URLString:nil interFaceHUD:style HUDString:string HUDBackgroundView:view tag:str] ;
}

+ (instancetype)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                  cancelBlock:(void(^)())cancelBlock
                 interFaceHUD:(QXPLoadHUDStyle)style
                    HUDString:(NSString *)string
            HUDBackgroundView:(UIView *)view
                          tag:(NSString *)str{
    
    return [[self alloc] initWithBlocks:finshBlock faildBlock:faildBlock cancelBlock:cancelBlock connectType:0 URLString:nil interFaceHUD:style HUDString:string HUDBackgroundView:view tag:str] ;
}
#pragma -mack DataSource
- (id)QXPNetWorkManager:(QXPNetWorkManager *)manager serializeWithData:(NSData *)data error:(NSError **)error{

    if (error!=NULL) {
       *error=[NSError errorWithDomain:@"未设置自定义解析方法" code:5 userInfo:nil]; 
    }
    return nil;
}
- (NSData *)QXPNetWorkManager:(QXPNetWorkManager *)manager cacheWithQXPNetWorkType:(QXPNetWorkType)type{
    [NSException raise:@"自定义缓存错误" format:@"缓存方法未实现"];
    return nil;
}
- (void)QXPNetWorkManager:(QXPNetWorkManager *)manager responseData:(NSData *)data{

}
- (void)addRequestHeader:(NSString *)key value:(NSString *)obj{

}
@end



