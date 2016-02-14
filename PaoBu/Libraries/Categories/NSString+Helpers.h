//
//  NSString+Helpers.h
//  DOOCT_IPhone
//
//  Created by 邱新鹏 on 13-7-3.
//  Copyright (c) 2013年 DCT. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SELECTTITLE_COUNT 20

@interface NSString (Helpers)
//判断是否是电话号码
-(BOOL)checkPhoneNumInput;
//判断是否是email
-(BOOL)isValidateEmail;
//判断是否是手机号
-(BOOL)isValidateMobile;
//判断字符是否是数字
-(BOOL)isNumber;

//判断是否是为空或者空字符串
-(BOOL)isNilOrEmpty;
//判断是否是空字符串
-(BOOL)isEmpty;
//RC4加密
- (NSString*)TORC4:(NSString*)aKey;

//将Int转成Str
NSString* stringWithInt(NSInteger number);
//将double转成Str
NSString* stringWithDouble(double number);
//将浮点转成Str
NSString* stringWithFloat(float number);

//得到本机现在用的语言
+ (NSString*)stringWithPreferredLanguage;
//得到当前的日期
+(NSString*) stringWithCurDate;
//得到当前的时间轴
+(NSString*) gstringWithCurLongTime;

//获取截取String并去除首尾空格
- (NSString *)getSelectTitle:(NSRange)range;

//删除首尾空格
- (NSString *)trim;
//去除空格
- (NSString *)removeSpaces;

//MD5
-(NSString *) md5 ;

//根据秒数获取时间
+ (NSString *)timeFormatted:(int)totalSeconds;
+ (NSString *)timeFormatted2:(int)totalSeconds;

//URL编码
- (NSString*)stringByEscapingForURLArgument;
//URL反编码
- (NSString*)stringByUnescapingFromURLArgument;

@end
