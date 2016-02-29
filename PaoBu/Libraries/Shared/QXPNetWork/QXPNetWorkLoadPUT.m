#import "QXPNetWorkLoadPUT.h"
#import "QXPNetWorkTools.h"
#import "AFNetworking.h"
#import "QXPNetWorkEntityClass.h"


@implementation QXPNetWorkLoadPUT
- (AFHTTPRequestOperation *)requestWithQXPNetWorkLoad:(QXPNetWorkManager *)manager cacheType:(QXPNetWorkCacheType)type{
    self.manager=manager;
    
    NSString *URLString=[self.manager.URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSError             *requestErr=nil;
    NSMutableURLRequest *request=nil;
    
    request= [self.manager.operationManager.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (QXPNetWorkParameter *parameter in manager.parameters) {
            if ([parameter.parameterValue isKindOfClass:[NSData class]]){
             
                [formData appendPartWithHeaders:nil body:parameter.parameterValue];
            }
            else{
                NSAssert([parameter.parameterValue isKindOfClass:[NSData class]], @"当属性为QXPNetWorkParameterTypePUT时候参数必须是NSData类型");
            }
        }
    } error:&requestErr];
    
    NSAssert(request, @"NSMutableURLRequest创建失败 连接方式:%@--连接地址:%@",@"PUT",URLString);

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
    NETWORK_DEBUG_LOG(@"连接方式:PUT--连接地址:%@",URLString);
#endif
#if NETWORK_DEBUG_SENDINFO
    NSString *postStr=[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    NETWORK_DEBUG_LOG(@"连接方式:PUT--发送的参数:%@",postStr);
    postStr=nil;
#endif
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = self.manager.operationManager.responseSerializer;
    operation.shouldUseCredentialStorage = self.manager.operationManager.shouldUseCredentialStorage;
    operation.credential = self.manager.operationManager.credential;
    operation.securityPolicy = self.manager.operationManager.securityPolicy;
    
    operation.completionQueue = self.manager.operationManager.completionQueue;
    operation.completionGroup = self.manager.operationManager.completionGroup;
    
    
    request=nil;
    URLString=nil;
    request=nil;
    
    return operation;
}
@end
