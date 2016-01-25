//
//  PayManager.m
//  BaLaBaLa
//
//  Created by Mr.Qiu on 15/3/31.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "PayManager.h"
//#import "RMStore.h"
#import "NSDate+Helpers.h"

@interface PayManager ()
@end
@implementation PayManager

+(void)initialize
{
    [super initialize];
    //[[MainManager LKDBglobalHelper] createTableWithModelClass:[self class]];
}
+ (void)payWithType:(PayTypeID)type block:(void (^)(BOOL yesNo ,NSString *message))block{
    
    NSDictionary *dict_payInfo = @{@"1":@"com.blahblah.vip30",
                                   @"2":@"com.blahblah.vip30Discount",
                                   @"5":@"com.blahblah.vip365",
                                   @"6":@"com.blahblah.vip365Discount"
                                   };
//    NSDictionary *dict_payInfo = @{@"1":@"com.blahblah.vipfree",
//                                   @"2":@"com.blahblah.vipfree",
//                                   @"5":@"com.blahblah.vipfree",
//                                   @"6":@"com.blahblah.vipfree"
//
/*};
    NSString *payKey=stringWithInt(type);
    
    if ([dict_payInfo.allKeys containsObject:payKey]) {
     
        NSString *payID=[dict_payInfo objectForKey:payKey];
        
        [[RMStore defaultStore] requestProducts:[NSSet setWithArray:@[payID]] success:^(NSArray *products, NSArray *invalidProductIdentifiers) {
            [[RMStore defaultStore] addPayment:payID success:^(SKPaymentTransaction *transaction) {
                if (transaction.transactionState==SKPaymentTransactionStatePurchased) {
                    
                  //  __block  NSData *tempData=transaction.transactionReceipt;
                    
                    NSString *datastr=[NSString stringWithFormat:@"%@",transaction.transactionReceipt];
                    NSString *time=[NSDate timeInterval];
                    
                    
                    
                    [[BBInterFace interfaceWithFinshBlock:^(id responseObje) {
                        
                        if ([[responseObje objectForKey:@"ispayok"] boolValue]) {
                            block(YES,[responseObje objectForKey:@"message"]);
                        }else{
                        
                            block(NO,[responseObje objectForKey:@"message"]);
                        }
                        
                        
                        [[BBInterFace interfaceWithFinshBlock:^(id responseObje) {
                            
                            [BBUser sharedUser].J_User_JBID.isvip=[[responseObje objectForKey:@"isvip"] integerValue];
                            [BBUser sharedUser].J_User_JBID.ExpireDate=[responseObje objectForKey:@"ExpireDate"];
                            [BBUser sharedUser].J_User_JBID.message=[responseObje objectForKey:@"message"];

                            [[BBUser sharedUser] synchronize];
                            
                            [BBUser lginOK];
                            
                        } faildBlock:^(NSError *err) {
                            
                        } tag:nil] GetViptime:[BBUser userID]];
                        
                        
                        
                    } faildBlock:^(NSError *err) {
                        
                        PayManager *payInfo=[PayManager new];
                        payInfo.userID=[BBUser userID];
                        payInfo.payID=payKey;
                        payInfo.yanzheng=datastr;
                        payInfo.time=time;
                        [[MainManager LKDBglobalHelper] insertToDB:payInfo];
                        block(NO,@"您的网络好像出了点问题,我们已经记录了购买,请在下次打开软件时候重新查看会员到期时间!");
                        
                    } HUDBackgroundView:nil tag:nil] YZappleispay:payKey datastr:datastr userID:[BBUser userID]];
                    
                }else{
                
                    block(NO,@"购买失败");

                }

            } failure:^(SKPaymentTransaction *transaction, NSError *error) {
                block(NO,error.domain);
            }];
        } failure:^(NSError *error) {
            block(NO,error.domain);
        }];
    }else{
        block(NO,@"购买错误!");
    }
 */
}
//检查旧的购买信息
+ (void)cheakOldPay{
    /*
    NSArray *tempArr=[[MainManager LKDBglobalHelper] search:[self class] where:nil orderBy:nil offset:0 count:0];
    
    for (PayManager *payInfo in tempArr) {
        
        [[BBInterFace interfaceWithFinshBlock:^(id responseObje) {
            
            [[MainManager LKDBglobalHelper] deleteToDB:payInfo];
            
        } faildBlock:^(NSError *err) {
            
            
        } HUDBackgroundView:nil tag:nil] YZappleispay:payInfo.payID datastr:payInfo.yanzheng userID:payInfo.userID];
    }
    
    
    */

}
@end
