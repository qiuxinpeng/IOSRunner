#import <Foundation/Foundation.h>
#import "QXPNetWorkManager.h"

@interface QXPNetWorkLoadPUT : NSObject<QXPNetWorkLoadDataSource>
@property(nonatomic, weak)QXPNetWorkManager *manager;
@end
