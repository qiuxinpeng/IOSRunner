//
//  QXPBlockUI.h
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-7-18.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

/*==========================================>
 UIControl
 <==========================================>*/
@interface UIControl (BlockUI)
- (void)addBlockActionForEvent:(UIControlEvents)event Block:(void(^)(id sender))block;
- (void)removeBlockActionForEvent:(UIControlEvents)event;
- (BOOL)hasBlockActionForEvent:(UIControlEvents)event;
@end


/*==========================================>
 UIAlertView
 <==========================================>*/
@interface UIAlertView (BlockUI)
+ (void)alertWithEventBlock:(void (^)(NSInteger buttonIndex))block
                      title:(NSString *)title
                    message:(NSString *)message
                cancelTitle:(NSString *)cancelTitle
          otherButtonTitles:(NSArray *)otherButtonTitles;

+ (void)say:(NSString *)message;

+ (void)say:(NSString *)message block:(void (^)(NSInteger buttonIndex))block;

+ (void)ask:(NSString *)question EventBlock:(void (^)(NSInteger buttonIndex))block
    message:(NSString *)message
cancelTitle:(NSString *)cancelTitle
otherButtonTitles:(NSArray *)otherButtonTitles;

+ (void)ask:(NSString *)question EventBlock:(void (^)(BOOL yesNo))block;

+ (void)message:(NSString *)question EventBlock:(void (^)(NSInteger buttonIndex, NSArray *messages))block alertViewStyle:(UIAlertViewStyle)style NS_AVAILABLE_IOS(5_0);
@end

/*==========================================>
 UIActionSheet
 <==========================================>*/
@interface UIActionSheet(BlockUI)


+ (void)actionSheetWithEventBlock:(void (^)(UIActionSheet *s ,NSInteger buttonIndex))block
                            title:(NSString *)title
           destructiveButtonTitle:(NSString *)message
                      cancelTitle:(NSString *)cancelTitle
                       showInView:(UIView *)inView
             otherButtonTitlesArr:(NSArray *)titles;

@end

