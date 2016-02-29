#import "QXPCacheUtility.h"
#import "EGOCache.h"


@implementation QXPCacheUtility
//获取单例user
+ (instancetype)sharedCacheUtility{

    static QXPCacheUtility *_tempUser = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[EGOCache globalCache] hasCacheForKey:CACHEUTITLIT_KEY]) {
            //[[EGOCache globalCache] clearCache];
            __strong id temp = [[EGOCache globalCache] objectForKey:CACHEUTITLIT_KEY];
            if ([temp isKindOfClass:[QXPCacheUtility class]]) {
                _tempUser = temp;
            }else{
                _tempUser = [[QXPCacheUtility alloc]init];
            }
        }else{
            _tempUser = [[QXPCacheUtility alloc]init];
        }
    });
    return _tempUser;
}
//同步
- (void)synchronize{
    [[EGOCache globalCache] setObject:self forKey:CACHEUTITLIT_KEY withTimeoutInterval:NSTimeIntervalSince1970];
}
@end
