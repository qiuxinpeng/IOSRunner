//
//  LoginFirstViewController.h
//  NewBaLa
//
//  Created by Mr.Qiu on 15/8/10.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginFirstViewController : BaseViewController
@property (nonatomic, copy)void (^loginCallBlock) (BOOL isLogin ,LoginFirstViewController *loginVC);

@end
