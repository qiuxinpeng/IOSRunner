//
//  NSData+AES256.h
//  SiFaKaoShi
//
//  Created by XiaoBai on 14-4-22.
//  Copyright (c) 2014年 QXP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)
- (NSData *)AES256EncryptWithKey:(NSString *)key;//加密
- (NSData *)AES256DecryptWithKey:(NSString *)key;//解密
@end
