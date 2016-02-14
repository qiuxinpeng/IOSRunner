#import "QXPCacheUtilit.h"
#import "EGOCache.h"


@implementation QXPCacheUtilit
//获取单例user
+ (instancetype)sharedCacheUtilit{

    static QXPCacheUtilit *_tempUser=nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([[EGOCache globalCache] hasCacheForKey:CACHEUTITLIT_KEY]) {
            __strong id temp=[[EGOCache globalCache] objectForKey:CACHEUTITLIT_KEY];
            if ([temp isKindOfClass:[QXPCacheUtilit class]]) {
                _tempUser=temp;
            }else{
                _tempUser=[[QXPCacheUtilit alloc]init];
            }
        }else{
            _tempUser=[[QXPCacheUtilit alloc]init];
        }
    });
    return _tempUser;
}
//同步
- (void)synchronize{
    [[EGOCache globalCache] setObject:self forKey:CACHEUTITLIT_KEY withTimeoutInterval:NSTimeIntervalSince1970];
}
@end
