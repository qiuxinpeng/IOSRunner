//
//  JGProgressHUD+helper.m
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-8-8.
//  Copyright (c) 2014年 9tong.com. All rights reserved.
//

#import "JGProgressHUD+helper.h"

@implementation JGProgressHUD (helper)
+ (instancetype)showWithView:(UIView *)view style:(JGProgressHUDStyle)style
     userInteraction:(BOOL)userInteraction text:(NSString *)text
   dismissAfterDelay:(NSTimeInterval)delay 
            textFont:(UIFont *)font marginInsets:(UIEdgeInsets)edgeInsets
       indicatorView:(JGProgressHUDIndicatorView *)indicatorView position:(JGProgressHUDPosition)position{

    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:style];
    HUD.textLabel.text = text;
    HUD.textLabel.font=font;
    HUD.userInteractionEnabled = userInteraction;
    HUD.marginInsets=edgeInsets;
    HUD.indicatorView=indicatorView;
    HUD.position=position;
    [HUD showInView:view animated:YES];
    if (delay>0) {
        [HUD dismissAfterDelay:delay];
    }
    return HUD;
}

+ (instancetype)showWithTextOnly:(NSString *)text{

    return [self showWithView:[[UIApplication sharedApplication] keyWindow] style:JGProgressHUDStyleDark userInteraction:YES text:text dismissAfterDelay:2 textFont:[UIFont systemFontOfSize:13] marginInsets:(UIEdgeInsets) {.top = 0.f,.bottom = 20.0f,.left = 0.0f,.right = 0.0f,
    } indicatorView:nil position:JGProgressHUDPositionBottomCenter];
}
@end
