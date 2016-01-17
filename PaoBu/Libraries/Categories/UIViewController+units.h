//
//  UIViewController+units.h
//  DOOCT_IPhone
//
//  Created by 邱新鹏 on 13-5-10.
//  Copyright (c) 2013年 DCT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (barItem)
//根据Btn来创建barItem
-(void)setLeftBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action;
-(void)setRightBarWithBtn:(NSString *)title imageName:(NSString *)inmageName action:(SEL)action;

- (NSString *)tagWithInterFace;

@end
