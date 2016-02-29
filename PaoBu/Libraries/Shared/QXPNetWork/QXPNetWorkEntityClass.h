#import <Foundation/Foundation.h>
//#import "QXPNetWorkEntityClass.h"
#import "QXPNetWorkDelegate.h"

@interface QXPNetWorkEntityClass : NSObject
@end

/**
 参数实体类
 */
@interface QXPNetWorkParameter : NSObject
@property (nonatomic, strong) NSString                *parameterName;//参数名称
@property (nonatomic, strong) id                      parameterValue;//参数值
@property (nonatomic, strong) NSString                *fileContentType;//可选值,只在表单参数有用
@property (nonatomic, strong) NSString                *fileName;//可选值,只在表单参数有用
@property (nonatomic ,assign) QXPNetWorkParameterType parameterType;//参数类型
@end


/**
 SOAP配置实体类
 */
@interface QXPNetWorkSOPAEntityClass : NSObject
@property (nonatomic, strong) NSString *soapName;
@property (nonatomic, strong) NSString *soapXmlns;
@property (nonatomic, strong) NSString *soapXmlnsXsd;
@property (nonatomic, strong) NSString *soapXmlnsXsi;
@property (nonatomic, strong) NSString *soapBodyName;
@property (nonatomic, strong) NSString *soapBodyXmlns;

@end