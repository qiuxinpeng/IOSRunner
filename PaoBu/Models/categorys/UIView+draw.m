//
//  UIView+draw.m
//  DOOCT_IPhone
//
//  Created by 邱新鹏 on 13-6-21.
//  Copyright (c) 2013年 DCT. All rights reserved.
//

#import "UIView+draw.h"

@implementation UIView (draw)
//添加阴影
- (void)addShadow{

    self.layer.shouldRasterize = YES;
    self.layer.shadowPath =[UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    self.layer.shadowOffset = CGSizeMake(-5, 3);
    /*混浊的阴影。默认为0。指定以外的值
     *[0,1]范围内会给不确定的结果。动画*/
    self.layer.shadowOpacity = 0;
    /*用于创建阴影模糊半径。默认为3。动画*/
    self.layer.shadowRadius=8;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
//    CGRect bounds = self.bounds;
//    bounds.size.height +=10;
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
//                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
//                                                         cornerRadii:CGSizeMake(5.0, 5.0)];
//    
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.frame = bounds;
//    maskLayer.path = maskPath.CGPath;
//    
//    [self.layer addSublayer:maskLayer];
//    self.layer.mask = maskLayer;
//    self.layer.shadowOffset = CGSizeMake(1, 1);
//    self.layer.shadowOpacity = 0.1;
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

//添加圆角
- (void)addRoundWithRadius:(float)radius;{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds  = YES;//使用边界来做遮罩
}

//添加渐变
- (void)addGradient{



}
//添加边框

- (void)addBorderWithColor:(UIColor*)color Width:(CGFloat )width{
    self.layer.borderWidth = width;
    self.layer.borderColor = [color CGColor];
}
@end
