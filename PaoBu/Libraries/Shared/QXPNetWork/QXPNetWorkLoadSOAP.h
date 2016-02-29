#import <Foundation/Foundation.h>
#import "QXPNetWorkManager.h"

@interface QXPNetWorkLoadSOAP : NSObject<QXPNetWorkLoadDataSource>
@property(nonatomic, weak)QXPNetWorkManager *manager;
@property(nonatomic, strong)NSMutableDictionary *XMLDict;
@end
