#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMDatabaseAdditions.h"
#import "LKDBHelper.h"
#import "MainViewController.h"
////#import "BaseNavigationController.h"
//#import "QXPCacheUtilit.h"
#import "AKTabBarController.h"




//#define User_FMDatabase_path [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:User_FMDatabase_Name];
//
//#define System_FMDatabase_path [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:System_FMDatabase_Name];

@interface RefreshInfo:NSObject

@property(nonatomic,strong)NSMutableArray *muArr_info;
@property(nonatomic, assign)int page;
@property(nonatomic, assign)NSUInteger count;
@property(nonatomic, assign)int total;

@end

@interface MainManager : NSObject

@property(nonatomic, strong)MainViewController *VCMain;

///**缓存*/
//@property (nonatomic, strong)QXPCacheUtilit *cacheUtitlit;

////下载完成显示信息
//+ (void)showWithMessage_downLoad:(NSString *)message subtitle:(NSString *)subtitle completionBlock:(void (^)(void))completion;

////Toast提示
//+ (void)showToastWithMessage:(NSString *)message subtitle:(NSString *)subtitle imageName:(NSString *)imageName completionBlock:(void (^)(void))completion;


+ (instancetype)manager;

//+ (void)setToastDefaultOption;

//void QXPDispatch_after(double time, dispatch_block_t block);

@end

@interface MainManager(FMDatabase)

+ (NSString *)FMDatabase_path;
+ (NSString *)User_FMDatabase_path;
+ (NSString *)System_FMDatabase_path;
+ (FMDatabaseQueue *)FMDatabaseQueue;
+ (FMDatabaseQueue *)FMDatabaseQueueUser;
+ (FMDatabaseQueue *)FMDatabaseQueueSystem;
+ (LKDBHelper *) LKDBglobalHelper;//默认
+ (LKDBHelper *) LKDBstatisticsHelper;//统计使用

@end