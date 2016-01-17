//
//  Qpinyin.h
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-9-17.
//  Copyright (c) 2014年 9tong.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ALPHA_Q	@"ABCDEFGHIJKLMNOPQRSTUVWXYZ#"

@protocol Qpinyin <NSObject>

char QpinyinFirstLetter(unsigned short hanzi);
@end
