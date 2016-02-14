#import "QXPCacheForUser.h"

@implementation QXPCacheForUser
static QXPCacheForUser *_tempUser=nil;

- (instancetype)init{
    if (([super init])) {
        self.userID=[PBUser userID];
    }
    return self;
}
//在类 初始化的时候
+(void)initialize
{
    [super initialize];
    [[self getUsingLKDBHelper] createTableWithModelClass:self];
    
}
+(NSString *)getPrimaryKey
{
    return @"userID";
}
//获取单例user
+ (instancetype)instancetypeUtilit{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (_tempUser) {
            QXPCacheForUser *temp =[[MainManager LKDBglobalHelper] searchSingle:[self class] where:@{@"userID":[PBUser userID]} orderBy:nil ];
            if (!temp) {
                temp=[[QXPCacheForUser alloc] init];
                [[MainManager LKDBglobalHelper] insertToDB:temp];
            }
            _tempUser=temp;
        }
        
    });
    return _tempUser;

}

//获取user
+ (instancetype)sharedCacheUtilit{

    if (![[QXPCacheForUser instancetypeUtilit].userID isEqualToString:[PBUser userID]]) {
        
        QXPCacheForUser *temp =[[MainManager LKDBglobalHelper] searchSingle:[self class] where:@{@"userID":[PBUser userID]} orderBy:nil ];
        if (!temp) {
            temp=[[QXPCacheForUser alloc] init];
            [[MainManager LKDBglobalHelper] insertToDB:temp];
        }
        [_tempUser synchronize];
        _tempUser=temp;
    }
    
    return [QXPCacheForUser instancetypeUtilit];
}
//同步
- (void)synchronize{

    [[MainManager LKDBglobalHelper] updateToDB:self where:@{@"userID":self.userID}];
}
@end
