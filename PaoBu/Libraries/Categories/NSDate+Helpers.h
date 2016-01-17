//
//  NSDate+Helpers.h
//  MobileEverwhere
//
//  Created by zhangp on 14-3-12.
//  Copyright (c) 2014年 zhangp. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSDate (Helpers)


#pragma mark-获取年月日如:19871127.
- (NSString *)getFormatYearMonthDay;

#pragma mark-该日期是该年的第几周
- (int )getWeekOfYear;

#pragma mark-返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)dateAfterDay:(int)day;

#pragma mark-month个月后的日期
- (NSDate *)dateafterMonth:(int)month;

#pragma mark-获取日
- (NSUInteger)getDay;

#pragma mark-获取月
- (NSUInteger)getMonth;

#pragma mark-获取年
- (NSUInteger)getYear;

#pragma mark-获取小时
- (int )getHour ;

#pragma mark-获取分钟
- (int)getMinute ;

- (int )getHour:(NSDate *)date ;

- (int)getMinute:(NSDate *)date;

#pragma mark-在当前日期前几天
- (NSUInteger)daysAgo ;

#pragma mark-午夜时间距今几天
- (NSUInteger)daysAgoAgainstMidnight;


- (NSString *)stringDaysAgo;


- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag ;


#pragma mark-返回一周的第几天(周末为第一天)
- (NSUInteger)weekday ;

#pragma mark-转为NSString类型的
+ (NSDate *)dateFromString:(NSString *)string ;


+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format ;


+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;


+ (NSString *)stringFromDate:(NSDate *)date ;


+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed ;


+ (NSString *)stringForDisplayFromDate:(NSDate *)date ;


- (NSString *)stringWithFormat:(NSString *)format;


- (NSString *)string ;

+ (NSString *)string;


- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle ;

#pragma mark-返回周日的的开始时间
- (NSDate *)beginningOfWeek;

#pragma mark-返回当前天的年月日.
- (NSDate *)beginningOfDay ;

#pragma mark-返回该月的第一天
- (NSDate *)beginningOfMonth;

#pragma mark-该月的最后一天
- (NSDate *)endOfMonth;

#pragma mark-返回当前周的周末
- (NSDate *)endOfWeek ;


+ (NSString *)dateFormatString ;


+ (NSString *)timeFormatString;


+ (NSString *)timestampFormatString ;


#pragma mark- preserving for compatibility
+ (NSString *)dbFormatString ;

//获取当前时间戳
+ (NSString *)timeInterval;
//获取当前时间戳
+ (long)timeIntervalWithLong;
//获取多少时间
+(NSString *)compareCurrentTime:(NSDate*)compareDate;
//获取多少时间
+(NSString *)compareCurrentTimeWithStr:(NSString*)compareStr;
//根据生日判断年龄
+(NSString *)ageWithTimeStr:(NSString *)timeStr;

+ (NSDateComponents *)getTodayComponents;

+ (NSString *)getStringCurrentTime:(NSString *)compareTime;

+ (NSString *)getSimpleQQDateString:(NSString *)compareStr;
+ (NSString *)getQQDateString:(NSString *)compareStr;
@end


//@interface NSDate+Helpers : NSObject
//
//@end

