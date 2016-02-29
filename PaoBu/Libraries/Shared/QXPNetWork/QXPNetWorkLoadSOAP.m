#import "QXPNetWorkLoadSOAP.h"
#import "XMLDictionary.h"
#import "QXPNetWorkEntityClass.h"
#import "AFNetworking.h"
#import "QXPNetWorkTools.h"

@interface QXPNetWorkLoadSOAP(){

    
}
@property(nonatomic,weak)QXPNetWorkSOPAEntityClass *soapConfig;
- (void)buildXMLDict;
@end

@implementation QXPNetWorkLoadSOAP

- (id)init{

    if ((self=[super init]))
        _XMLDict=[[NSMutableDictionary alloc]init];
    return self;
}
- (AFHTTPRequestOperation *)requestWithQXPNetWorkLoad:(QXPNetWorkManager *)manager cacheType:(QXPNetWorkCacheType)type{
    self.manager=manager;
    self.soapConfig=manager.soapConfig;
    [self buildXMLDict];
    
    NSString *URLString=[self.manager.URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSError             *requestErr=nil;
    NSMutableURLRequest *request=nil;
    
    request= [self.manager.operationManager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString *soapStr=[[self.XMLDict XMLString] addXMLHeader];
        NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapStr length]];
        
        NSMutableDictionary *mutableHeaders = [NSMutableDictionary dictionary];
        [mutableHeaders setValue:@"text/xml; charset=utf-8" forKey:@"Content-Type"];
        [mutableHeaders setValue:msgLength forKey:@"Content-Length"];
        
        [formData appendPartWithHeaders:mutableHeaders body:[soapStr dataUsingEncoding:NSUTF8StringEncoding]];
        soapStr=nil;
        msgLength=nil;
        mutableHeaders=nil;
        
    } error:&requestErr];
    
#if NETWORK_DEBUG_LINKURL
    NETWORK_DEBUG_LOG(@"连接方式:SOAP--连接地址:%@",manager.URLString);
#endif
    
#if NETWORK_DEBUG_SENDINFO
    NETWORK_DEBUG_LOG(@"连接方式:SOAP--发送的数据:%@",[[self.XMLDict XMLString] addXMLHeader]);
#endif

    return nil;
}
- (void)buildXMLDict{
    
    [_XMLDict setObject:self.soapConfig.soapName forKey:@"__name"];
    [_XMLDict setObject:self.soapConfig.soapXmlns forKey:@"_xmlns:soap"];
    [_XMLDict setObject:self.soapConfig.soapXmlnsXsd forKey:@"_xmlns:xsd"];
    [_XMLDict setObject:self.soapConfig.soapXmlnsXsi forKey:@"_xmlns:xsi"];
    NSMutableDictionary *bodyDict=[NSMutableDictionary dictionary];
    for (QXPNetWorkParameter *parameter in self.manager.parameters) {
        [bodyDict setObject:parameter.parameterValue forKey:parameter.parameterName];
    }
    [bodyDict setObject:self.soapConfig.soapBodyName forKey:@"__name"];
    [bodyDict setObject:self.soapConfig.soapBodyXmlns forKey:@"_xmlns"];
    NSDictionary *soapDict=[NSDictionary dictionaryWithObjectsAndKeys:bodyDict,self.soapConfig.soapBodyName,@"soap:Body",@"__name", nil];
    [_XMLDict setObject:soapDict forKey:@"soap:Body"];    
}
@end
