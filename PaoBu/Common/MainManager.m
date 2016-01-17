//
//  MainManager.m
//  PaoBu
//
//  Created by Apple on 16/1/17.
//  Copyright © 2016年 LunSheng. All rights reserved.
//

#import "MainManager.h"
//#import "EGOCache.h"
#import "FCFileManager.h"
//#import "CRToast.h"
//#import "Reachability.h"
//#import "WXApi.h"
//#import <TencentOpenAPI/QQApiInterface.h>

#define User_FMDatabase_Name @"User_FMDatabase_path.db"
#define System_FMDatabase_Name @"System_FMDatabase_path.db"

@implementation RefreshInfo

- (instancetype)init{
    if ((self=[super init])) {
        
        self.muArr_info=[NSMutableArray array];
        self.page=1;
        self.count=PAGE_COUNT_DEFAULT;
        self.total=0;
    }
    return self;
}
- (NSUInteger)count{
    return self.muArr_info.count;
}

@end

@implementation MainManager

//@synthesize cacheUtitlit=_cacheUtitlit;
static FMDatabaseQueue * _instanceUserDB;
static FMDatabaseQueue * _instanceSystemDB;
+ (MainManager *)manager{
    static MainManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[MainManager alloc] init];
    });
    return _manager;
}
//void QXPDispatch_after(double time, dispatch_block_t block){
//    QXPMainAfterBlock_define(time, block);
//}
//- (void)setCacheUtitlit:(QXPCacheUtilit *)cacheUtitlit{
//    [self setCacheUtitlit:cacheUtitlit save:YES];
//}
//- (void)setCacheUtitlit:(QXPCacheUtilit *)cacheUtitlit save:(BOOL)save{
//    _cacheUtitlit=cacheUtitlit;
//    if (save && _cacheUtitlit) {
//        [[EGOCache globalCache] setObject:(id<NSCoding>)_cacheUtitlit forKey:CACHEUTITLIT_KEY withTimeoutInterval:NSTimeIntervalSince1970];
//    }
//}
//- (QXPCacheUtilit *)cacheUtitlit{
//
//    if (!_cacheUtitlit) {
//        QXPCacheUtilit *utilit=(QXPCacheUtilit *)[[EGOCache globalCache] objectForKey:CACHEUTITLIT_KEY];
//        if ([utilit isKindOfClass:[QXPCacheUtilit class]]) {
//            [self setCacheUtitlit:utilit save:NO];
//            utilit=nil;
//        }else{
//            _cacheUtitlit=[[QXPCacheUtilit alloc] init];
//        }
//    }
//    return _cacheUtitlit;
//}
////同步
//- (void)synchronize{
//
//}
//+ (void)setToastDefaultOption {
//    //    [CRToastManager setDefaultOptions:@{kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
//    //                                        kCRToastFontKey             : [UIFont fontWithName:@"HelveticaNeue-Light" size:16],
//    //                                        kCRToastTextColorKey        : [UIColor whiteColor],
//    //                                        kCRToastBackgroundColorKey  : [UIColor orangeColor],
//    //                                        kCRToastAutorotateKey       : @(YES)}];
//    //
//    
//}
//CRToastAnimationType CRToastAnimationTypeFromSegmentedControl(UISegmentedControl *segmentedControl) {
//    return segmentedControl.selectedSegmentIndex == 0 ? CRToastAnimationTypeLinear :
//    segmentedControl.selectedSegmentIndex == 1 ? CRToastAnimationTypeSpring :
//    CRToastAnimationTypeGravity;
//}
//+ (NSMutableDictionary *)options{
//    // kCRToastTextKey                           : self.txtNotificationMessage.text,
//    NSMutableDictionary *options = [@{kCRToastNotificationTypeKey               : @(CRToastTypeNavigationBar),
//                                      kCRToastNotificationPresentationTypeKey   :  @(CRToastPresentationTypeCover),
//                                      kCRToastUnderStatusBarKey                 : @(YES),
//                                      kCRToastBackgroundColorKey                : [UIColor clearColor],
//                                      kCRToastTextAlignmentKey                  : @(NSTextAlignmentLeft),
//                                      kCRToastSubtitleTextAlignmentKey          : @(NSTextAlignmentLeft),
//                                      kCRToastTimeIntervalKey                   : @(3),
//                                      kCRToastAnimationInTypeKey                : @(CRToastAnimationTypeLinear),
//                                      kCRToastAnimationOutTypeKey               : @(CRToastAnimationTypeLinear),
//                                      kCRToastAnimationInDirectionKey           : @(CRToastAnimationDirectionTop),
//                                      kCRToastAnimationOutDirectionKey          : @(CRToastAnimationDirectionTop),
//                                      kCRToastShowActivityIndicatorKey          : @(NO)}mutableCopy];
//    return options;
//}

////下载完成显示信息
//+ (void)showWithMessage_downLoad:(NSString *)message subtitle:(NSString *)subtitle completionBlock:(void (^)(void))completion{
//    
//    NSMutableDictionary *downLoadoptions=[self options];
//    
//    downLoadoptions[kCRToastTextKey]=message?message:@"";
//    downLoadoptions[kCRToastSubtitleTextKey]=subtitle?subtitle:@"";
//    downLoadoptions[kCRToastBackgroundColorKey]=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
//    downLoadoptions[kCRToastImageKey] = [UIImage imageNamed:@"white_checkmark.png"];
//    
//    downLoadoptions[kCRToastInteractionRespondersKey] = @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
//                                                                                                          automaticallyDismiss:YES
//                                                                                                                         block:^(CRToastInteractionType interactionType){
//                                                                                                                             //NSLog(@"Dismissed with %@ interaction", NSStringFromCRToastInteractionType(interactionType));
//                                                                                                                         }]];
//    
//    
//    [CRToastManager showNotificationWithOptions:downLoadoptions
//                                 apperanceBlock:^(void) {
//                                     //NSLog(@"Appeared");
//                                 }
//                                completionBlock:completion];
//    
//}
////扣除巴豆显示信息
//+ (void)showWithMessage_BaDou:(NSString *)message subtitle:(NSString *)subtitle completionBlock:(void (^)(void))completion{
//    
//    NSMutableDictionary *downLoadoptions=[self options];
//    
//    downLoadoptions[kCRToastTextKey]=message?message:@"";
//    downLoadoptions[kCRToastSubtitleTextKey]=subtitle?subtitle:@"";
//    downLoadoptions[kCRToastBackgroundColorKey]=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
//    downLoadoptions[kCRToastImageKey] = [UIImage imageNamed:@"white_checkmark.png"];
//    
//    downLoadoptions[kCRToastInteractionRespondersKey] = @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
//                                                                                                          automaticallyDismiss:YES
//                                                                                                                         block:^(CRToastInteractionType interactionType){
//                                                                                                                             //NSLog(@"Dismissed with %@ interaction", NSStringFromCRToastInteractionType(interactionType));
//                                                                                                                         }]];
//    
//    
//    [CRToastManager showNotificationWithOptions:downLoadoptions
//                                 apperanceBlock:^(void) {
//                                     //NSLog(@"Appeared");
//                                 }
//                                completionBlock:completion];
//    
//}
////Toast提示
//+ (void)showToastWithMessage:(NSString *)message subtitle:(NSString *)subtitle imageName:(NSString *)imageName completionBlock:(void (^)(void))completion {
//    NSMutableDictionary *downLoadoptions=[self options];
//    
//    downLoadoptions[kCRToastTextKey]=message?message:@"";
//    downLoadoptions[kCRToastSubtitleTextKey]=subtitle?subtitle:@"";
//    downLoadoptions[kCRToastBackgroundColorKey]=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
//    downLoadoptions[kCRToastImageKey] = [UIImage imageNamed:imageName];
//    
//    downLoadoptions[kCRToastInteractionRespondersKey] = @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
//                                                                                                          automaticallyDismiss:YES
//                                                                                                                         block:^(CRToastInteractionType interactionType){
//                                                                                                                             //NSLog(@"Dismissed with %@ interaction", NSStringFromCRToastInteractionType(interactionType));
//                                                                                                                         }]];
//    
//    
//    [CRToastManager showNotificationWithOptions:downLoadoptions
//                                 apperanceBlock:^(void) {
//                                     //NSLog(@"Appeared");
//                                 }
//                                completionBlock:completion];
//}
@end

@implementation MainManager(FMDatabase)

//#define User_FMDatabase_path [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)[0] stringByAppendingPathComponent:User_FMDatabase_Name];
//
//#define System_FMDatabase_path [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)[0] stringByAppendingPathComponent:System_FMDatabase_Name];
+ (NSString *)FMDatabase_path{
    
    NSString* cachesDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return cachesDirectory = [cachesDirectory stringByAppendingPathComponent:@"db"];
}
+ (NSString *)User_FMDatabase_path{
    
    //    NSString* cachesDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //
    //    return cachesDirectory = [cachesDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"db/%@",User_FMDatabase_Name]] ;
    
    return [FCFileManager pathForDocumentsDirectoryWithPath:User_FMDatabase_Name];
    
    
    
}
+ (NSString *)System_FMDatabase_path{
    
    //    NSString* cachesDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //
    //    return cachesDirectory = [cachesDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"db/%@",System_FMDatabase_Name]] ;
    
    return [FCFileManager pathForDocumentsDirectoryWithPath:System_FMDatabase_Name];
    
    
}
+ (FMDatabaseQueue *)FMDatabaseQueueUser{
    
    if (!_instanceUserDB)
    {
        _instanceUserDB = [[FMDatabaseQueue alloc]initWithPath:[self User_FMDatabase_path]];
    }
    return _instanceUserDB;
}
+ (FMDatabaseQueue *)FMDatabaseQueueSystem{
    
    if (!_instanceSystemDB)
    {
        _instanceSystemDB = [[FMDatabaseQueue alloc]initWithPath:[self System_FMDatabase_path]];
    }
    return _instanceSystemDB;
    
    
}
+ (FMDatabaseQueue *)FMDatabaseQueue
{
    static FMDatabaseQueue * _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance)
        {
            NSArray* paths =NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES) ;
            _instance = [[FMDatabaseQueue alloc]initWithPath:[[paths objectAtIndex:0]stringByAppendingPathComponent:NSStringFromClass([self class])]];
        }
    });
    return _instance;
}
+ (LKDBHelper *) LKDBglobalHelper{
    return [LKDBHelper getUsingLKDBHelper];
}
//统计使用
+ (LKDBHelper *) LKDBstatisticsHelper{
    return [[LKDBHelper  alloc] initWithDBName:@"statistics"];
}
@end
