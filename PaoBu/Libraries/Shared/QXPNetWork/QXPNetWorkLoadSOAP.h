//
//  QXPNetWorkLoadSOAP.h
//  QXPNetWork
//
//  Created by 小白 on 13-3-4.
//  Copyright (c) 2013年 小白. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QXPNetWorkManager.h"

@interface QXPNetWorkLoadSOAP : NSObject<QXPNetWorkLoadDataSource>
@property(nonatomic, weak)QXPNetWorkManager *manager;
@property(nonatomic, strong)NSMutableDictionary *XMLDict;
@end
