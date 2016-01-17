//
//  QXPBlockUI.m
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-7-18.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import "QXPBlockUI.h"
#import "BlocksKit+UIKit.h"

/*==========================================>
 UIControl
 <==========================================>*/
@implementation UIControl (BlockUI)
- (void)addBlockActionForEvent:(UIControlEvents)event Block:(void(^)(id sender))block{
    
    [self bk_addEventHandler:block forControlEvents:event];
    
}
- (void)removeBlockActionForEvent:(UIControlEvents)event{
    
    [self bk_removeEventHandlersForControlEvents:event];
}
- (BOOL)hasBlockActionForEvent:(UIControlEvents)event{

    return [self bk_hasEventHandlersForControlEvents:event];
}
@end

/*==========================================>
 UIAlertView
 <==========================================>*/
@implementation UIAlertView(BlockUI)
+ (void)alertWithEventBlock:(void (^)(NSInteger buttonIndex, NSArray *messages))block
                      title:(NSString *)title
                    message:(NSString *)message
                cancelTitle:(NSString *)cancelTitle
           UIAlertViewStyle:(UIAlertViewStyle)style
          otherButtonTitles:(NSArray *)otherButtonTitles{
    
    
//    void (^tempBlock)(NSInteger buttonIndex,NSArray *messages) =nil;
//
//    if (block) {
//        void (^tempBlock)(NSInteger buttonIndex,NSArray *messages) =[block copy];
//    }
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:cancelTitle
                                          otherButtonTitles:nil];
    alert.alertViewStyle=style;
    
    for (NSString *str in otherButtonTitles) {
        [alert addButtonWithTitle:str];
    }
    
    [alert bk_setDidDismissBlock:^(UIAlertView *alert, NSInteger buttonIndex) {
        NSArray *arr=nil;
        if (alert.alertViewStyle==UIAlertViewStyleSecureTextInput||alert.alertViewStyle==UIAlertViewStylePlainTextInput) {
            arr=@[[alert textFieldAtIndex:0].text] ;
        }else if (alert.alertViewStyle==UIAlertViewStyleLoginAndPasswordInput){
            arr=@[[alert textFieldAtIndex:0].text,[alert textFieldAtIndex:1].text];
        }
        block(buttonIndex,arr);
        arr=nil;
    }];
    
    [alert show];
    alert=nil;
}

+ (void)alertWithEventBlock:(void (^)(NSInteger buttonIndex))block
                      title:(NSString *)title
                    message:(NSString *)message
                cancelTitle:(NSString *)cancelTitle
          otherButtonTitles:(NSArray *)otherButtonTitles{

//    void (^tempBlock)(NSInteger buttonIndex)=nil;
//    
//    if (block) {
//        tempBlock=block
//    }

    [UIAlertView bk_showAlertViewWithTitle:title message:message cancelButtonTitle:cancelTitle otherButtonTitles:otherButtonTitles handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (block) {
            block(buttonIndex);
        }
    }];
}
+ (void)say:(NSString *)message{
    
    
    [self alertWithEventBlock:nil title:nil message:message cancelTitle:nil otherButtonTitles: @[@"确定"]];
}

+ (void)say:(NSString *)message block:(void (^)(NSInteger buttonIndex))block{
    [self alertWithEventBlock:block title:nil message:message cancelTitle:nil otherButtonTitles: @[@"确定"]];
}
+ (void)ask:(NSString *)question EventBlock:(void (^)(NSInteger buttonIndex))block
    message:(NSString *)message
cancelTitle:(NSString *)cancelTitle
otherButtonTitles:(NSArray *)otherButtonTitles{
    
    [self alertWithEventBlock:block title:question message:message cancelTitle:cancelTitle otherButtonTitles:otherButtonTitles];
}

+ (void)ask:(NSString *)question EventBlock:(void (^)(BOOL yesNo))block{
    void (^tempBlock)(BOOL yesNo)=[block copy];
    [self alertWithEventBlock:^(NSInteger buttonIndex) {
        if (buttonIndex==0) {
            tempBlock(NO);
        } else {
            tempBlock(YES);
        }
    } title:question message:nil cancelTitle:nil otherButtonTitles:@[@"取消",@"确定"]];
    
}
+ (void)message:(NSString *)question EventBlock:(void (^)(NSInteger buttonIndex, NSArray *messages))block alertViewStyle:(UIAlertViewStyle)style{
    
    [self alertWithEventBlock:block title:question message:nil cancelTitle:nil UIAlertViewStyle:style otherButtonTitles:@[@"取消",@"确定"]];
}

@end

/*==========================================>
 UIActionSheet
 <==========================================>*/
@implementation UIActionSheet(BlockUI)

+ (void)actionSheetWithEventBlock:(void (^)(UIActionSheet *s ,NSInteger buttonIndex))block
                            title:(NSString *)title
           destructiveButtonTitle:(NSString *)message
                      cancelTitle:(NSString *)cancelTitle
                       showInView:(UIView *)inView
             otherButtonTitlesArr:(NSArray *)titles{
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title
                                                       delegate:nil
                                              cancelButtonTitle:cancelTitle
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil];
    
    for (NSString *title in titles) {
        
        if ([title isKindOfClass:[NSString class]])
            [sheet addButtonWithTitle:title];
        
    }
    [sheet bk_setDidDismissBlock:block];
    [sheet showInView:inView];
    sheet=nil;
}
@end


