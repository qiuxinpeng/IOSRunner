//
//  PayManager.h
//  BaLaBaLa
//
//  Created by Mr.Qiu on 15/3/31.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayManager : NSObject
@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSString *payID;
@property (nonatomic,strong) NSString *yanzheng;
@property (nonatomic,strong) NSString *time;

+ (void)payWithType:(PayTypeID)type block:(void (^)(BOOL yesNo ,NSString *message))block;

//检查旧的购买信息
+ (void)cheakOldPay;
@end
