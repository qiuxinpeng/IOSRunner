//
//  QXPNetWorkLoadDefault.h
//  QXPNetWork
//
//  Created by 小白 on 13-2-22.
//  Copyright (c) 2013年 小白. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QXPNetWorkManager.h"

@interface QXPNetWorkLoadDefault : NSObject <QXPNetWorkLoadDataSource>

@property(nonatomic, weak)QXPNetWorkManager *manager;
@end
