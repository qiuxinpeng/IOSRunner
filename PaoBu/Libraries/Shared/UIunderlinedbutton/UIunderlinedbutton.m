//
//  UIunderlinedbutton.m
//  BaLaBaLa
//
//  Created by Mr.Qiu on 14/12/8.
//  Copyright (c) 2014年 Mr.Qiu. All rights reserved.
//

#import "UIunderlinedbutton.h"

@implementation UIunderlinedbutton

+ (UIunderlinedbutton*) underlinedButton {
    UIunderlinedbutton* button = [[UIunderlinedbutton alloc] init];
    return button ;
}

- (void) drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    
    // need to put the line at top of descenders (negative value)
    CGFloat descender = self.titleLabel.font.descender;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // set to same colour as text
    CGContextSetStrokeColorWithColor(contextRef, self.titleLabel.textColor.CGColor);
    
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender);
    
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender);
    
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke); 
}
@end
