#define HUD_STRING_DEFAULT @"加载中..."

typedef NS_ENUM(NSInteger, QXPLoadHUDStyle) {
    ///无加载
    QXPLoadHUDStyleNone=0,
    ///默认的加载模式
    QXPLoadHUDStyleDefault=1,
    //环状的进度条显示
    QXPLoadHUDStyleAnnularDeterminate=2,
    //圆饼的进度条显示
    QXPLoadHUDStyleDeterminate=3,
    //自定义的视图显示
    QXPLoadHUDStyleCustomView=4,
} ;

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "QXPNetWorkDelegate.h"
#import "MBProgressHUD.h"

@interface QXPNetWorkQueue : NSObject
@property(nonatomic, strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic, strong)NSMutableArray *downloadDelegates;
+ (instancetype)sharedQueue;
- (void)cancelAll;
+ (void)addInterface:(id)face;
+ (void)removeInterface:(id)face;
+ (void)removeInterfaceWithClass:(NSString *)tag;
@end

@interface QXPNetWorkInterface : NSObject<QXPNetWorkSerializeDataSource,QXPNetWorkCacheDataSource>

@property(nonatomic, copy)QXPLoadFinishBlock loadFinshBlock;
@property(nonatomic, copy)QXPLoadFailedBlock loadFaildBlock;
@property(nonatomic, copy)QXPProgressBlock loadProgressBlock;
@property(nonatomic, copy)QXPLoadCancelBlock loadCancelBlock;
//@property(nonatomic, copy)NSString  *URLString;
@property(nonatomic, assign)QXPNetWorkType connectType;
@property(nonatomic, assign)QXPLoadHUDStyle HUDStyle;
@property(nonatomic, retain)MBProgressHUD  *MBHUDView;
@property(nonatomic, assign)QXPNetWorkSerializeType SerializeType;
@property(nonatomic, assign)QXPNetWorkCacheType cacheType;
//覆盖的HUD用径向渐变的背景视图。默认为NO
@property(nonatomic, assign)BOOL dimBackground;
//是否响应用户触摸事件。默认为NO
@property(nonatomic, assign)BOOL HUDUserInteractionEnabled;
@property(nonatomic,copy)NSString *tagString;

+ (void)cancelAll;
- (void)cancel;
+ (void)cancelForTag:(NSString *)tag;

/**
 设置自定义请求方法
 只在设置使用自定义请求时候有用,其它请求方式不必使用,默认提供4种请求
 */
- (void)setQXPNetWorkLoadDataSource:(id<QXPNetWorkLoadDataSource>)dataSourceObject;

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

- (void)startLoadInformationWithParameters:(NSArray *)arr URLString:(NSString *)string connectType:(QXPNetWorkType)type;


+ (id)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                          tag:(NSString *)str;


+ (id)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                  cancelBlock:(void(^)())cancelBlock
                          tag:(NSString *)str;


+ (id)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
            HUDBackgroundView:(UIView *)view
                          tag:(NSString *)str;


+ (id)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                  cancelBlock:(void(^)())cancelBlock
            HUDBackgroundView:(UIView *)view
                          tag:(NSString *)str;



+ (id)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                 interFaceHUD:(QXPLoadHUDStyle)style
            HUDBackgroundView:(UIView *)view
                          tag:(NSString *)str;


+ (id)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                  cancelBlock:(void(^)())cancelBlock
                 interFaceHUD:(QXPLoadHUDStyle)style
            HUDBackgroundView:(UIView *)view
                          tag:(NSString *)str;


+ (id)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                 interFaceHUD:(QXPLoadHUDStyle)style
                    HUDString:(NSString *)string
            HUDBackgroundView:(UIView *)view
                          tag:(NSString *)str;


+ (id)interfaceWithFinshBlock:(void (^)(id responseObje))finshBlock
                   faildBlock:(void (^)(NSError *err))faildBlock
                  cancelBlock:(void(^)())cancelBlock
                 interFaceHUD:(QXPLoadHUDStyle)style
                    HUDString:(NSString *)string
            HUDBackgroundView:(UIView *)view
                          tag:(NSString *)str;

- (void)addRequestHeader:(NSString *)key value:(NSString *)obj;
@end

