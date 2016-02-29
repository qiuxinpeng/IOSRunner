#import "QXPNetWorkManager.h"
#import "QXPNetWorkLoadDefault.h"
#import "QXPNetWorkLoadPUT.h"
#import "QXPNetWorkLoadSOAP.h"
#import "AFNetworking.h"
#import "QXPNetWorkEntityClass.h"
#import "XMLDictionary.h"
#import "EGOCache.h"


Class object_getClass(id object);
@interface QXPNetWorkManager(){
    dispatch_queue_t workQueue;
}
- (void)performBlockOnMainThread:(QXPBasicBlock)block;
- (void)releaseBlocksOnMainThread;
+ (void)releaseBlocks:(NSArray *)blocks;
- (void)callBlock:(QXPBasicBlock)block;
- (void)ASIHTTPRequestCancel;
- (void )connectTypeWithASIRequest:(QXPNetWorkType)type;

@property (nonatomic, assign) Class                  SerializedelegateClass;
@property (nonatomic, assign) Class                  cachedelegateClass;
@property (nonatomic, assign) BOOL                   isUsedCompelcache;
@property (nonatomic, strong  ) AFHTTPRequestOperation *requestOperation;
@property(nonatomic, strong)NSData *responseData;

/**
 取消连接和clear
 */
- (void)cancelAndclear;
@end

@implementation QXPNetWorkManager

inline static NSString* cacheKeyForURL(NSString* url, NSString* data) {
	if(data) {
		return [NSString stringWithFormat:@"QXPNETWORKCACHE-%lu-%lu", (unsigned long)url.hash, (unsigned long)data.hash];
	} else {
		return [NSString stringWithFormat:@"QXPNETWORKCACHE-%lu", (unsigned long)url.hash];
	}
}

- (NSString *)getCacheKey{
    NSMutableString *str=[NSMutableString stringWithFormat:@"%@",self.URLString];
    for (QXPNetWorkParameter *parameter in self.parameters) {
        if ([parameter isKindOfClass:[QXPNetWorkParameter class]])
            [str appendFormat:@"%@%@%d",parameter.parameterName,parameter.parameterValue,(int)parameter.parameterType];
        else
            [NSException raise:@"参数错误" format:@"当属性为QXPNetWorkParameterTypePUT时候参数必须是NSData类型"];
    }
    return cacheKeyForURL(str, nil);
}

- (void)setSerializeDataSource:(id<QXPNetWorkSerializeDataSource>)SerializeDataSource{
    _SerializeDataSource=SerializeDataSource;
    self.SerializedelegateClass=object_getClass(SerializeDataSource);
#if NETWORK_DEBUG_Serialize
    if (SerializeDataSource) NETWORK_DEBUG_LOG(@"解析--->设置自定义解析DataSource:%@",self.SerializeDataSource);
#endif
}
- (void)setCacheDataSource:(id<QXPNetWorkCacheDataSource>)cacheDataSource{
    _cacheDataSource=cacheDataSource;
    self.cachedelegateClass=object_getClass(cacheDataSource);
    
#if NETWORK_DEBUG_RESPONSE_CACHE
    if (cacheDataSource) NETWORK_DEBUG_LOG(@"缓存--->设置自定义缓存DataSource:%@",_cacheDataSource);
#endif
}

- (void)dealloc{
    [self cancelAndclear];
}
- (void)releaseBlocksOnMainThread{
    NSMutableArray *blocks = [NSMutableArray array];
    if (_progressBlocks) {
        [blocks addObject:_progressBlocks];
        _progressBlocks=nil;
    }
    if (_finishBlocks) {
        [blocks addObject:_finishBlocks];
        _finishBlocks=nil;
    }
    if (_failedBlocks) {
        [blocks addObject:_failedBlocks];
        _failedBlocks=nil;
    }
    if (_cancelBlocks) {
        [blocks addObject:_cancelBlocks];
        _cancelBlocks=nil;
    }
    [[self class] performSelectorOnMainThread:@selector(releaseBlocks:) withObject:blocks waitUntilDone:[NSThread isMainThread]];
}
- (void)performBlockOnMainThread:(QXPBasicBlock)block{
	[self performSelectorOnMainThread:@selector(callBlock:) withObject:block waitUntilDone:[NSThread isMainThread]];
}
- (void)releaseSelf{
    
    NSMutableArray *blocks = [NSMutableArray array];
    [blocks addObject:self];
    [[self class] performSelectorOnMainThread:@selector(releaseBlocks:) withObject:blocks waitUntilDone:[NSThread isMainThread]];
}

- (void)callBlock:(QXPBasicBlock)block{
	block();
}
// 始终在主线程执行
+ (void)releaseBlocks:(NSArray *)blocks{
	// 该方法退出时blocks将被释放时，
}
- (void)ASIHTTPRequestCancel{
    [self.requestOperation cancel];
}
- (void)cancelConnect{
    if (self.requestOperation && ![self.requestOperation isFinished]) {
#if NETWORK_DEBUG_CANCEL
        NETWORK_DEBUG_LOG(@"连接方式:%d--连接地%@\n--->取消连接",(int)_workType,_URLString);
#endif
        if (self.cancelBlocks){
            //[self setFailedBlocks:nil];
            //[self performBlockOnMainThread:^{ if(self.cancelBlocks) self.cancelBlocks();}];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cancelBlocks();
            });
        }
        [self ASIHTTPRequestCancel];
    }
}
- (void)cancelAndclear{
    self.dataSourceObject=nil;
    self.operationManager=nil;
    self.SerializeDataSource=nil;
    self.cacheDataSource=nil;
    self.responseData=nil;
    
    //[self ASIHTTPRequestCancel];
    [self releaseBlocksOnMainThread];
}
- (instancetype)init{
    if ((self=[super init])){
        workQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //dispatch_queue_create("com.QXPNetWork.workQueue", DISPATCH_QUEUE_CONCURRENT);
        self.SerializeType=QXPNetWorkSerializeTypeNone;
        self.cacheType=QXPNetWorkCacheTypeNone;
        self.dataSourceObject=nil;
        self.requestOperation=nil;
        self.isUsedCompelcache=NO;
    }
    return self;
}
- (instancetype)initWithAFHTTPRequestOperationManager:(AFHTTPRequestOperationManager *)manager{
    if ((self=[self init])) {
        self.operationManager=manager;
        self.requestOperation=nil;
    }
    return self;
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
}
- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval{
    [self.operationManager.requestSerializer setTimeoutInterval:timeoutInterval];
}
- (void )connectWithNetWorkType:(QXPNetWorkType)type{
    self.workType=type;
    //__weak __typeof(self)wself = self;
    if (self.cacheType==QXPNetWorkCacheTypeCompel){
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            // __strong __typeof(wself)strongSelf = wself;
            //网络不通
            if (status==AFNetworkReachabilityStatusNotReachable) {
                self.isUsedCompelcache=YES;
                NSString *keyStr=[self getCacheKey];
                NSData *tempData=[[EGOCache globalCache] dataForKey:keyStr] ;
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (tempData){
                        [self serializeWithData:tempData];
#if NETWORK_DEBUG_RESPONSE_CACHE
                        NETWORK_DEBUG_LOG(@"缓存--->连接地址:%@  获取到强制缓存对象",self.URLString);
#endif
                    }
                    else{
                        [self connectTypeWithASIRequest:type];
#if NETWORK_DEBUG_RESPONSE_CACHE
                        NETWORK_DEBUG_LOG(@"缓存--->连接地址:%@  获取到强制缓存失败",self.URLString);
#endif
                    }
                });
            }else{
                [self connectTypeWithASIRequest:type];
            }
            [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
        }];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }else if (self.cacheType==QXPNetWorkCacheTypeCustom){
        dispatch_async(workQueue, ^{
            NSData *tempData=(self.cachedelegateClass==object_getClass(self.cacheDataSource) && self.cacheDataSource &&[self.cacheDataSource respondsToSelector:@selector(QXPNetWorkManager:cacheWithQXPNetWorkType:)])?[self.cacheDataSource QXPNetWorkManager:self cacheWithQXPNetWorkType:type]:nil;
#if NETWORK_DEBUG_RESPONSE_CACHE
            NETWORK_DEBUG_LOG(@"缓存--->连接地址:%@  返回缓存对象以提供解析",self.URLString);
#endif
            dispatch_async(dispatch_get_main_queue(), ^{
                if (tempData)
                    [self serializeWithData:tempData];
                else
                    [self connectTypeWithASIRequest:type];
            });
        });
    }else{
        [self connectTypeWithASIRequest:type];
    }
}

- (void )connectTypeWithASIRequest:(QXPNetWorkType)type{
    if (self.requestOperation) [self ASIHTTPRequestCancel];
    _dataSourceObject=nil;
    
    switch (type) {
        case QXPNetWorkTypeGet:
            self.dataSourceObject=[[QXPNetWorkLoadDefault alloc]init];
            break;
        case QXPNetWorkTypePost:
            self.dataSourceObject=[[QXPNetWorkLoadDefault alloc]init];
            break;
        case QXPNetWorkTypePUT:
            self.dataSourceObject=[[QXPNetWorkLoadPUT alloc]init];
            break;
        case QXPNetWorkTypeSoap:
            if (!self.soapConfig){
                [NSException raise:@"设置错误" format:@"当使用SOAP协议时候必须设置soapConfig"];
            }
            self.dataSourceObject=[[QXPNetWorkLoadSOAP alloc]init];
            break;
        default:
            [NSException raise:@"设置错误" format:@"不确定的连接类型,请明确设置"];
            break;
    }
    __block QXPNetWorkManager *strongSelf = self;
    self.requestOperation=[self.dataSourceObject requestWithQXPNetWorkLoad:self cacheType:self.cacheType];
    [self.requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, id responseObject) {
        //__strong QXPNetWorkManager *strongSelf = wself;
        
#if NETWORK_DEBUG_RESPONSE_STRING
        NETWORK_DEBUG_LOG(@"连接方式:%d--连接地址:%@\n--->获取的数据:\n%@\n<---\n\n\n",(int)strongSelf.workType,op.request.URL,op.responseString);
#endif
        if(strongSelf.finishBlocks){
            [strongSelf serializeWithData:op.responseObject];
            strongSelf.requestOperation=nil;
            strongSelf=nil;
        }else{
            [strongSelf releaseSelf];
            strongSelf.requestOperation=nil;
            strongSelf=nil;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //__strong __typeof(wself)strongSelf = wself;
        
#if NETWORK_DEBUG_CANCEL
        if (error.code==NSURLErrorCancelled)
            NETWORK_DEBUG_LOG(@"--->取消连接:%@ 连接方式:%d--连接地址:%@\n",error,(int)strongSelf.workType,strongSelf.URLString);
#endif
        if (error.code==NSURLErrorCancelled && strongSelf.cancelBlocks){
            //[self performBlockOnMainThread:^{ if(self.cancelBlocks) self.cancelBlocks();}];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(strongSelf.cancelBlocks) strongSelf.cancelBlocks();
                strongSelf.requestOperation=nil;
                [strongSelf releaseSelf];
                strongSelf=nil;
            });
        }else if(strongSelf.failedBlocks){
            dispatch_async(dispatch_get_main_queue(), ^{
                if(strongSelf.failedBlocks)strongSelf.failedBlocks(error);
                strongSelf.requestOperation=nil;
                [strongSelf releaseSelf];
                strongSelf=nil;
            });
        }
    }];
    
    if(self.progressBlocks){
        [self.requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            //__strong __typeof(wself)strongSelf = wself;
            dispatch_async(dispatch_get_main_queue(), ^{
                if(strongSelf.progressBlocks) strongSelf.progressBlocks(totalBytesRead,totalBytesExpectedToRead);
            });
            //[self performBlockOnMainThread:^{ if(self.progressBlocks) self.progressBlocks(totalBytesRead,totalBytesExpectedToRead);}];
        }];
    }
    
    if (self.cacheType!=QXPNetWorkCacheTypeCompel && self.cacheType!=QXPNetWorkCacheTypeCustom) {
        [self.requestOperation setCacheResponseBlock:^NSCachedURLResponse *(NSURLConnection *connection, NSCachedURLResponse *cachedResponse) {
            return cachedResponse;
        }];
    }
    
    [self.operationManager.operationQueue addOperation:self.requestOperation];
}

- (void)serializeWithData:(NSData *)data{
    __block  id object=nil;
    __block  NSError *err=nil;
    //NSData *responseData=[[NSData alloc]initWithData:data];
    self.responseData=data;
    NSData *strongResponseData = self.responseData;
    dispatch_async(workQueue, ^{
        __strong __typeof(object)strongObject = object;
        __strong __typeof(err)strongErr = err;
        // __strong NSData *strongResponseData = self.responseData;
        
        if (self.SerializeType==QXPNetWorkSerializeTypeJSON) {
            strongObject=[NSJSONSerialization JSONObjectWithData:strongResponseData options:NSJSONReadingMutableLeaves error:&strongErr] ;
        }else if (self.SerializeType==QXPNetWorkSerializeTypeXML){
            strongObject=[NSDictionary dictionaryWithXMLData:strongResponseData];
        }else if (self.SerializeType==QXPNetWorkSerializeTypeCustom && self.SerializedelegateClass==object_getClass(self.SerializeDataSource) && [ self.SerializeDataSource respondsToSelector:@selector(QXPNetWorkManager:serializeWithData:error:)]){
            
            strongObject=[self.SerializeDataSource QXPNetWorkManager:self serializeWithData:self.responseData error:&strongErr];
            
#if NETWORK_DEBUG_Serialize
            NETWORK_DEBUG_LOG(@"解析--->连接地址:%@  获取自定义的解析对象",self.URLString);
#endif
        }else if (self.SerializeType==QXPNetWorkSerializeTypeNone){
            strongObject=strongResponseData;
        }else if(self.SerializeType==QXPNetWorkSerializeTypeString){
            strongObject=[[NSString alloc] initWithData:strongResponseData encoding:self.requestOperation.responseStringEncoding];
        }
        
        if (self.cacheType==QXPNetWorkCacheTypeCustom && self.cachedelegateClass==object_getClass(self.cacheDataSource) && self.cacheDataSource &&[ self.cacheDataSource respondsToSelector:@selector(QXPNetWorkManager:responseData:)]) {
            [self.cacheDataSource QXPNetWorkManager:self responseData:strongObject];
#if NETWORK_DEBUG_RESPONSE_CACHE
            NETWORK_DEBUG_LOG(@"缓存--->连接地址:%@  正常网络连接获取到将要缓存的对象,请自行处理",self.URLString);
#endif
        }else if (self.cacheType==QXPNetWorkCacheTypeCompel && !self.isUsedCompelcache){
            
            [[EGOCache globalCache] setData:strongObject forKey:[self getCacheKey]];
#if NETWORK_DEBUG_RESPONSE_CACHE
            NETWORK_DEBUG_LOG(@"缓存--->连接地址:%@  跟新缓存信息",self.URLString);
#endif
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (strongErr || !strongObject) {
                if(self.failedBlocks){
                    //[self performBlockOnMainThread:^{ if(self.failedBlocks)self.failedBlocks(strongErr?strongErr:[NSError errorWithDomain:@"数据解析失败" code:1 userInfo:nil]);}];
                    if(self.failedBlocks)self.failedBlocks(strongErr?strongErr:[NSError errorWithDomain:@"数据解析失败" code:1 userInfo:nil]);
                    //[self releaseSelf];
#if NETWORK_DEBUG_Serialize
                    NETWORK_DEBUG_LOG(@"解析--->连接地址:%@  解析失败",self.URLString);
#endif
                }
            }else{
                if (self.finishBlocks){
                    self.finishBlocks(strongObject);
                    //[self performBlockOnMainThread:^{ if(self.finishBlocks)self.finishBlocks(strongObject);}];
                    //[self releaseSelf];
                }
            }
        });
        
        strongObject=nil;
        strongErr=nil;
        //strongResponseData=nil;
        //responseData=nil;
        object=nil;
        err=nil;
        
        [self releaseSelf];
    });
}

@end
