//
//  UIView+draw.h
//  DOOCT_IPhone
//
//  Created by 邱新鹏 on 13-6-21.
//  Copyright (c) 2013年 DCT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface UIView (draw)
//添加阴影
- (void)addShadow;

//添加圆角
- (void)addRoundWithRadius:(float)radius;

//添加渐变
- (void)addGradient;

//添加边框

- (void)addBorderWithColor:(UIColor*)color Width:(CGFloat )width;
@end
