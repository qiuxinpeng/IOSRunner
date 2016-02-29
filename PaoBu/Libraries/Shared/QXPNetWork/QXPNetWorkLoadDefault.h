#import <Foundation/Foundation.h>
#import "QXPNetWorkManager.h"

@interface QXPNetWorkLoadDefault : NSObject <QXPNetWorkLoadDataSource>

@property(nonatomic, weak)QXPNetWorkManager *manager;
@end
