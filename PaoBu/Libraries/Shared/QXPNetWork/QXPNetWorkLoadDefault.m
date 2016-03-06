#import "QXPNetWorkLoadDefault.h"
#import "QXPNetWorkTools.h"
#import "AFNetworking.h"
#import "QXPNetWorkEntityClass.h"

@interface QXPNetWorkLoadDefault(){
}
@end

@implementation QXPNetWorkLoadDefault

- (instancetype)init{
    if ((self = [super init])) {
    }
    return self;
}

- (AFHTTPRequestOperation *)requestWithQXPNetWorkLoad:(QXPNetWorkManager *)manager cacheType:(QXPNetWorkCacheType)type{
    self.manager = manager;
    
    if (self.manager.workType == QXPNetWorkTypeGet){
        return [self requestWithParameters:manager.parameters Method:@"GET" cacheType:type];
    }
    else if (self.manager.workType == QXPNetWorkTypePost){
        return [self requestWithParameters:manager.parameters Method:@"POST" cacheType:type];
    }
    
    return nil;
}

- (AFHTTPRequestOperation *)requestWithParameters:(NSArray *)parameters Method:(NSString *)method cacheType:(QXPNetWorkCacheType)type{
    NSString *URLString = [self.manager.URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *paramerDict = [NSMutableDictionary dictionary];
    NSMutableArray  *formArr = [NSMutableArray array];
    
    for (QXPNetWorkParameter *parameter in parameters) {
        if ([parameter isKindOfClass:[QXPNetWorkParameter class]] && parameter.parameterType == QXPNetWorkParameterTypeDefault) {
            [paramerDict setObject:parameter.parameterValue forKey:parameter.parameterName];
        }else if ([parameter isKindOfClass:[QXPNetWorkParameter class]]){
            //[formArr addObject:parameters];
            [formArr addObject:parameter];
        }else{
            NSAssert([parameter isKindOfClass:[QXPNetWorkParameter class]], @"参数类型必须为QXPNetWorkParameter");
        }
    }
    NSMutableURLRequest *request = nil;
    NSError *requestErr = nil;
    
    if (formArr.count > 0) {
        request = [self.manager.operationManager.requestSerializer multipartFormRequestWithMethod:method URLString:URLString parameters:paramerDict?paramerDict:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (QXPNetWorkParameter *parameter in formArr) {
                if (parameter.parameterType == QXPNetWorkParameterTypeForm) {
                    NSAssert([parameter.parameterValue isKindOfClass:[NSData class]], @"当属性为QXPNetWorkParameterTypeForm时候参数必须是NSData类型");
                    [formData appendPartWithFileData:parameter.parameterValue name:parameter.parameterName fileName:parameter.fileName?parameter.fileName:@"" mimeType:parameter.fileContentType?parameter.fileContentType:@""];
                }else if (parameter.parameterType == QXPNetWorkParameterTypeFormPath){
                    NSURL *fileURL = [NSURL fileURLWithPath:parameter.parameterValue];
                    NSAssert(fileURL, @"当属性为QXPNetWorkParameterTypeFormPath时候参数必须是路径");
                    [formData appendPartWithFileURL:fileURL name:parameter.parameterName fileName:parameter.fileName mimeType:parameter.fileContentType error:nil];
                }
            }
        } error:&requestErr];
    }else{
        request = [self.manager.operationManager.requestSerializer requestWithMethod:method URLString:URLString parameters:paramerDict.count>0?paramerDict:nil error:&requestErr];
    }
    NSAssert(request, @"NSMutableURLRequest创建失败 连接方式:%@--连接地址:%@", method, URLString);
    
    switch (type) {
        case QXPNetWorkCacheTypeNone:
            [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
            break;
        case QXPNetWorkCacheTypeSystem:
            [request setCachePolicy:NSURLRequestReloadRevalidatingCacheData];
            break;
        case QXPNetWorkCacheTypeSystemStorage:
            [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
            break;
        default:
            break;
    }
    
#if NETWORK_DEBUG_LINKURL
    if ([method isEqualToString:@"GET"]) {
        NETWORK_DEBUG_LOG(@"连接方式:%@--连接地址:%@", method, request.URL);
    }else{
        NETWORK_DEBUG_LOG(@"连接方式:%@--连接地址:%@", method, URLString);
        NSString *strBody = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        if ([strBody rangeOfString:@"&"].length > 0) {
            NETWORK_DEBUG_LOG(@"转化为GET地址:%@&%@", URLString, strBody);
        }
        strBody = nil;
    }
#endif
#if NETWORK_DEBUG_SENDINFO
    NSMutableString *logInfoStr = [[NSMutableString alloc] init];
    NSMutableString *decryptParams = [[NSMutableString alloc] init];
    
    for (int i=0; i<self.manager.parameters.count; i++) {
        QXPNetWorkParameter *parameter = [parameters objectAtIndex:i];
        [logInfoStr appendFormat:@"\n-> %d  参数名:%@  参数%@  参数类型:%d", i+1, parameter.parameterName, parameter.parameterValue, (int)parameter.parameterType];
        //TODO:新增语句用来显示解密后的数据，上线记得删除，避免被反编译
        [decryptParams appendFormat:@"%@", [CommonFn decryptDES: parameter.parameterValue ]];
    }
    NETWORK_DEBUG_LOG(@"连接方式:%@--发送加密后的参数:%@", method, logInfoStr);
    NETWORK_DEBUG_LOG(@"连接方式:%@--解密后的请求信息:%@&%@", method, URLString, decryptParams);
    NSArray *params = [decryptParams componentsSeparatedByString:@"&"];
    
    [logInfoStr setString:@""];
    for(int i=0; i<params.count; i++) {
        NSArray *p = [[params objectAtIndex:i ] componentsSeparatedByString:@"="];
        [logInfoStr appendFormat:@"\n-> %d  参数名:%@  参数%@", i+1, p[0], p[1]];
    }
    NETWORK_DEBUG_LOG(@"连接方式:%@--解密后的参数:%@", method, logInfoStr);
    logInfoStr = nil;
    decryptParams = nil;
#endif
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = self.manager.operationManager.responseSerializer;
    operation.shouldUseCredentialStorage = self.manager.operationManager.shouldUseCredentialStorage;
    operation.credential = self.manager.operationManager.credential;
    operation.securityPolicy = self.manager.operationManager.securityPolicy;
    
    //[operation setCompletionBlockWithSuccess:success failure:failure];
    operation.completionQueue = self.manager.operationManager.completionQueue;
    operation.completionGroup = self.manager.operationManager.completionGroup;
    
    request = nil;
    URLString = nil;
    paramerDict = nil;
    formArr = nil;
    request = nil;
    
    return operation;
}
@end
