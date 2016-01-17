//
//  NSString+pinyin.h
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-9-17.
//  Copyright (c) 2014年 9tong.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (pinyin)
//首字母拼音
- (NSString *)firstPinYin;
//全部拼音
- (NSString *)allPinYin;
//全部拼音数组
- (NSArray *)allPinYinArr;


//首字母拼音 是否是人姓名 是姓名要做特殊处理
- (NSString *)firstPinYinWithIsContacts:(BOOL)contacts;
//全部拼音 是否是人姓名 是姓名要做特殊处理
- (NSString *)allPinYinIsContacts:(BOOL)contacts;
//全部拼音数组 是否是人姓名 是姓名要做特殊处理
- (NSArray *)allPinYinArrIsContacts:(BOOL)contacts;

@end
