//
//  JGProgressHUD+helper.h
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-8-8.
//  Copyright (c) 2014年 9tong.com. All rights reserved.
//

#import "JGProgressHUD.h"

@interface JGProgressHUD (helper)
+ (instancetype)showWithView:(UIView *)view style:(JGProgressHUDStyle)style
             userInteraction:(BOOL)userInteraction text:(NSString *)text
           dismissAfterDelay:(NSTimeInterval)delay 
                    textFont:(UIFont *)font marginInsets:(UIEdgeInsets)edgeInsets
               indicatorView:(JGProgressHUDIndicatorView *)indicatorView position:(JGProgressHUDPosition)position;

//在下方显示文字
+ (instancetype)showWithTextOnly:(NSString *)text;


@end
