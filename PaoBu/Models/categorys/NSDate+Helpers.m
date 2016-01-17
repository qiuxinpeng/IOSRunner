//
//  NSDate+Helpers.m
//  MobileEverwhere
//
//  Created by zhangp on 14-3-12.
//  Copyright (c) 2014年 zhangp. All rights reserved.
//




#import "NSDate+Helpers.h"


/*
 
 【今天】： 22:36
 【昨天】： 昨天 22:36
 【前天-第七天】: 星期日 22:36
 【第七天以前】：11-02 22:36
 【年份变化】： 14-11-12 22:36
 
 */

typedef enum : NSUInteger {
    DateQQSectionDefault    = 0,  //默认，初始
    DateQQSectionToday      = 1,  //【今天】： 22:36
    DateQQSectionYesterday  = 2,  //【昨天】： 昨天 22:36
    DateQQSectionWeek       = 3,  //【前天-第七天】: 星期日 22:36
    DateQQSectionMonth      = 4,  //【第七天以前】：11-02 22:36
    DateQQSectionYear       = 5,  //【年份变化】： 14-11-12 22:36
    DateQQSectionFuture     = 6,  //【超过当前时间】： 14-11-12 22:36
    
}DateQQSection;

@implementation NSDate(Helpers)

#pragma mark-获取年月日如:19871127.
- (NSString *)getFormatYearMonthDay
{
    NSString *string = [NSString stringWithFormat:@"%d%02d%02d",[self getYear],[self getMonth],[self getDay]];
    return string;
}

#pragma mark-该日期是该年的第几周
- (int )getWeekOfYear
{
    int i;
    int year = [self getYear];
    NSDate *date = [self endOfWeek];
    for (i = 1;[[date dateAfterDay:-7 * i] getYear] == year;i++)
    {
    }
    return i;
}
#pragma mark-返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)dateAfterDay:(int)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    componentsToAdd=nil;
    
    return dateAfterDay;
}
#pragma mark-month个月后的日期
- (NSDate *)dateafterMonth:(int)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    componentsToAdd=nil;
    
    return dateAfterMonth;
}
#pragma mark-获取日
- (NSUInteger)getDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:self];
    return [dayComponents day];
}
#pragma mark-获取月
- (NSUInteger)getMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:self];
    return [dayComponents month];
}
#pragma mark-获取年
- (NSUInteger)getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:self];
    return [dayComponents year];
}
#pragma mark-获取小时
- (int )getHour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger hour = [components hour];
    return (int)hour;
}
#pragma mark-获取分钟
- (int)getMinute {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger minute = [components minute];
    return (int)minute;
}
- (int )getHour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger hour = [components hour];
    return (int)hour;
}
- (int)getMinute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger minute = [components minute];
    return (int)minute;
}
#pragma mark-在当前日期前几天
- (NSUInteger)daysAgo {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components day];
}
#pragma mark-午夜时间距今几天
- (NSUInteger)daysAgoAgainstMidnight {
    // get a midnight version of ourself:
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
    mdf=nil;
    
    return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSString *)stringDaysAgo {
    return [self stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag {
    NSUInteger daysAgo = (flag) ? [self daysAgoAgainstMidnight] : [self daysAgo];
    NSString *text = nil;
    switch (daysAgo) {
        case 0:
            text = @"Today";
            break;
        case 1:
            text = @"Yesterday";
            break;
        default:
            text = [NSString stringWithFormat:@"%d days ago", daysAgo];
    }
    return text;
}

#pragma mark-返回一周的第几天(周末为第一天)
- (NSUInteger)weekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSWeekdayCalendarUnit) fromDate:self];
    return [weekdayComponents weekday];
}
#pragma mark-转为NSString类型的
+ (NSDate *)dateFromString:(NSString *)string {
    return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    inputFormatter=nil;
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    return [date stringWithFormat:format];
}

+ (NSString *)stringFromDate:(NSDate *)date {
    return [date string];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed {
    /*
     * if the date is in today, display 12-hour time with meridian,
     * if it is within the last 7 days, display weekday name (Friday)
     * if within the calendar year, display as Jan 23
     * else display as Nov 11, 2008
     */
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                                                     fromDate:today];
    
    NSDate *midnight = [calendar dateFromComponents:offsetComponents];
    
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    NSString *displayString = nil;
    
    // comparing against midnight
    if ([date compare:midnight] == NSOrderedDescending) {
        if (prefixed) {
            [displayFormatter setDateFormat:@"'at' h:mm a"]; // at 11:30 am
        } else {
            [displayFormatter setDateFormat:@"h:mm a"]; // 11:30 am
        }
    } else {
        // check if date is within last 7 days
        NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
        [componentsToSubtract setDay:-7];
        NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];
        componentsToSubtract=nil;
        if ([date compare:lastweek] == NSOrderedDescending) {
            [displayFormatter setDateFormat:@"EEEE"]; // Tuesday
        } else {
            // check if same calendar year
            NSInteger thisYear = [offsetComponents year];
            
            NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                                                           fromDate:date];
            NSInteger thatYear = [dateComponents year];
            if (thatYear >= thisYear) {
                [displayFormatter setDateFormat:@"MMM d"];
            } else {
                [displayFormatter setDateFormat:@"MMM d, yyyy"];
            }
        }
        if (prefixed) {
            NSString *dateFormat = [displayFormatter dateFormat];
            NSString *prefix = @"'on' ";
            [displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
        }
    }
    
    // use display formatter to return formatted date string
    displayString = [displayFormatter stringFromDate:date];
    displayFormatter=nil;
    return displayString;
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date {
    return [self stringForDisplayFromDate:date prefixed:NO];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:self];
    outputFormatter=nil;
    return timestamp_str;
}

- (NSString *)string {
    return [self stringWithFormat:[NSDate dbFormatString]];
}
+ (NSString *)string{
    return [[NSDate date] stringWithFormat:[NSDate dbFormatString]];
    
}
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateStyle:dateStyle];
    [outputFormatter setTimeStyle:timeStyle];
    NSString *outputString = [outputFormatter stringFromDate:self];
    outputFormatter=nil;
    return outputString;
}
#pragma mark-返回周日的的开始时间
- (NSDate *)beginningOfWeek {
    // largely borrowed from "Date and Time Programming Guide for Cocoa"
    // we'll use the default calendar and hope for the best
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *beginningOfWeek = nil;
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek
                           interval:NULL forDate:self];
    if (ok) {
        return beginningOfWeek;
    }
    
    // couldn't calc via range, so try to grab Sunday, assuming gregorian style
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    
    /*
     Create a date components to represent the number of days to subtract from the current date.
     The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
     */
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
    beginningOfWeek = nil;
    beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    componentsToSubtract=nil;
    
    //normalize to midnight, extract the year, month, and day components and create a new date from those components.
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                                               fromDate:beginningOfWeek];
    return [calendar dateFromComponents:components];
}
#pragma mark-返回当前天的年月日.
- (NSDate *)beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                                               fromDate:self];
    return [calendar dateFromComponents:components];
}
#pragma mark-返回该月的第一天
- (NSDate *)beginningOfMonth
{
    return [self dateAfterDay:-[self getDay] + 1];
}
#pragma mark-该月的最后一天
- (NSDate *)endOfMonth
{
    return [[[self beginningOfMonth] dateafterMonth:1] dateAfterDay:-1];
}
//返回当前周的周末
- (NSDate *)endOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])];
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    componentsToAdd=nil;
    
    return endOfWeek;
}

+ (NSString *)dateFormatString {
    return @"yyyy/MM/dd";
}

+ (NSString *)timeFormatString {
    return @"HH:mm:ss";
}

+ (NSString *)timestampFormatString {
    return @"yyyy/MM/dd HH:mm:ss";
}

// preserving for compatibility
+ (NSString *)dbFormatString {
    return [NSDate timestampFormatString];
}
//获取当前时间戳
+ (NSString *)timeInterval{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    return timeSp;
}
//获取当前时间戳
+ (long)timeIntervalWithLong{
    return [[NSDate date] timeIntervalSince1970];
}

//获取多少时间
+(NSString *)compareCurrentTime:(NSDate*) compareDate
//
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
}
//获取多少时间
+(NSString *) compareCurrentTimeWithStr:(NSString*)compareStr{
    
    
    
    return [self getStringCurrentTime:compareStr];
    
    //    NSDate *data=[NSDate dateFromString:compareStr];
    //
    //    return [NSDate compareCurrentTime:data];
}
//根据生日判断年龄
+(NSString *)ageWithTimeStr:(NSString *)timeStr{
    
    if (!timeStr || [timeStr isNilOrEmpty]) {
        
        return @"";
    }
    NSDate *data=[NSDate dateFromString:timeStr];
    if (!data) {
        return @"";
    }
    NSTimeInterval dateDiff = [data timeIntervalSinceNow];
    int age=fabs(trunc(dateDiff/(60*60*24))/365);
    return [NSString stringWithFormat:@"%d",age];
}
#pragma mark -
+ (NSDateComponents *)getComponents:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *compsDate = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitYearForWeekOfYear|NSCalendarUnitWeekOfYear fromDate:date];
    return compsDate;
}
+ (NSDateComponents *)getTodayComponents{
    //今天
    NSDate *todayDate = [NSDate date];
    return [NSDate getComponents:todayDate];
}
+ (NSDateComponents *)getYesterdayComponents{
    //昨天
    NSDate *yesterdayDate = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]];
    return [NSDate getComponents:yesterdayDate];
}

+ (NSString *)getStringCurrentTime:(NSString *)compareTime {
    
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    //[inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    //[inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [inputFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];//2014/2/27 15:34:42
    //相比较的那天
    NSDate *compareDate = [inputFormatter dateFromString:compareTime];
    NSDateComponents *compsCompare = [NSDate getComponents:compareDate];
    
    //今天
    NSDateComponents *compsToday = [NSDate getTodayComponents];
    
    //昨天
    NSDateComponents *compsYesterday = [NSDate getYesterdayComponents];
    
    
    NSString *dateStr = nil;//日期
    NSString *timeStr = nil;//时间
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger firstWeekday = calendar.firstWeekday;
    
    if (compsToday.yearForWeekOfYear == compsCompare.yearForWeekOfYear) {
        //同一年
        if (compsToday.weekOfYear == compsCompare.weekOfYear) {
            //在一周内
            //判断周几
            if (compsCompare.weekday == firstWeekday) {
                dateStr = @"星期日";
            } else if (compsCompare.weekday == firstWeekday+1) {
                dateStr = @"星期一";
            } else if (compsCompare.weekday == firstWeekday+2) {
                dateStr = @"星期二";
            } else if (compsCompare.weekday == firstWeekday+3) {
                dateStr = @"星期三";
            } else if (compsCompare.weekday == firstWeekday+4) {
                dateStr = @"星期四";
            } else if (compsCompare.weekday == firstWeekday+5) {
                dateStr = @"星期五";
            } else if (compsCompare.weekday == firstWeekday+6) {
                dateStr = @"星期六";
            }
            
        }else {
            //一周以上
            // dateStr = [NSString stringWithFormat:@"%zd-%zd", compsCompare.month, compsCompare.day];
            
            NSString *year = [NSString stringWithFormat:@"%zd",compsCompare.year] ;
            //NSString *year = [NSString stringWithFormat:@"%zd",compsCompare.year];
            dateStr = [NSString stringWithFormat:@"%@-%zd-%zd", year, compsCompare.month, compsCompare.day];
        }
        
    } else {
        //不同年份
        NSString *year = [[NSString stringWithFormat:@"%zd",compsCompare.year] substringWithRange:NSMakeRange(2, 2)];
        //NSString *year = [NSString stringWithFormat:@"%zd",compsCompare.year];
        dateStr = [NSString stringWithFormat:@"%@-%zd-%zd", year, compsCompare.month, compsCompare.day];
    }
    
    
    //判断昨天
    if (compsYesterday.year == compsCompare.year && compsYesterday.month == compsCompare.month && compsYesterday.day == compsCompare.day) {
        dateStr = @"昨天";
    }
    
    // 时间
    NSString *hour = [NSString stringWithFormat:@"%zd",compsCompare.hour];
    NSString *minute = [NSString stringWithFormat:@"%zd",compsCompare.minute];
    hour = ([hour length] == 1) ? [NSString stringWithFormat:@"0%@",hour] : hour;
    minute = ([minute length] == 1) ? [NSString stringWithFormat:@"0%@",minute] : minute;
    timeStr = [NSString stringWithFormat:@"%@:%@",hour, minute];
    
    return dateStr;
    
    //return [NSString stringWithFormat:@"%@ %@", dateStr, timeStr];
}


+ (NSString *)getSimpleQQDateString:(NSString *)compareStr {
    
    @autoreleasepool {
        DateQQSection section = DateQQSectionDefault;
        
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//2014-2-27 15:34:42
        NSDate *compareDate = [inputFormatter dateFromString:compareStr];//要比较的时间
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *compsToday = [NSDate getTodayComponents];//今天此时
        NSDateComponents *compareComponentsDate = [calendar components:NSCalendarUnitYear|NSCalendarUnitWeekday fromDate:compareDate];//要比较的时间

        
        NSTimeInterval timeInterval = [compareDate timeIntervalSinceDate:[NSDate date]];
        
        if (timeInterval < 60 * 20) {
            
            if (compsToday.year == compareComponentsDate.year) {
                
                NSString *sinceStr = [[NSDate stringFromDate:[NSDate date] withFormat:@"yyyy-MM-dd"] stringByAppendingString:@" 00:00:00"];
                NSDate *sinceDate = [inputFormatter dateFromString:sinceStr];//今天零点
                
                timeInterval = [compareDate timeIntervalSinceDate:sinceDate];
                if (timeInterval < 0) {
                    timeInterval = -timeInterval;
                    if (timeInterval < 60 * 60 * 24) {
                        section = DateQQSectionYesterday;
                    }else if (timeInterval > 60 * 60 * 24 * (7-1)) {
                        section = DateQQSectionMonth;
                    } else {
                        section = DateQQSectionWeek;
                    }
                    
                } else {
                    section = DateQQSectionToday;
                }
            } else {
                section = DateQQSectionYear;
            }
        } else {
            section = DateQQSectionFuture;
        }
        
        NSString *result;
        switch (section) {
            case DateQQSectionToday:
            {
                
                result = @"今天";
                break;
            }
            case DateQQSectionYesterday:
            {
                result = @"昨天";
                break;
            }
            case DateQQSectionWeek:
            {
                
                NSInteger firstWeekday = calendar.firstWeekday;
                //判断周几
                switch (compareComponentsDate.weekday-firstWeekday) {
                    case 0:
                        result = @"星期日";
                        break;
                    case 1:
                        result = @"星期一";
                        break;
                    case 2:
                        result = @"星期二";
                        break;
                    case 3:
                        result = @"星期三";
                        break;
                    case 4:
                        result = @"星期四";
                        break;
                    case 5:
                        result = @"星期五";
                        break;
                    case 6:
                        result = @"星期六";
                        break;
                    default:
                        break;
                }
                
                break;
            }
            case DateQQSectionMonth:
            {
                result = [NSDate stringFromDate:compareDate withFormat:@"MM-dd"];
                break;
            }
            case DateQQSectionYear:
            {
                result = [NSDate stringFromDate:compareDate withFormat:@"yy-MM-dd"];//14-2-27
                break;
            }
            case DateQQSectionFuture:
            {
                result = [NSDate stringFromDate:compareDate withFormat:@"yy-MM-dd"];//14-2-27
                break;
            }
            default:
            {
                result = compareStr;
                break;
            }
        }
        return result;
    }
}
+ (NSString *)getQQDateString:(NSString *)compareStr {
    
    @autoreleasepool {
        DateQQSection section = DateQQSectionDefault;
        
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//2014-2-27 15:34:42
        NSDate *compareDate = [inputFormatter dateFromString:compareStr];//要比较的时间
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *compsToday = [NSDate getTodayComponents];//今天此时
        NSDateComponents *compareComponentsDate = [calendar components:NSCalendarUnitYear|NSCalendarUnitWeekday fromDate:compareDate];//要比较的时间
        
        NSTimeInterval timeInterval = [compareDate timeIntervalSinceDate:[NSDate date]];
        
        if (timeInterval < 60 * 20) {
            
            if (compsToday.year == compareComponentsDate.year) {
                
                NSString *sinceStr = [[NSDate stringFromDate:[NSDate date] withFormat:@"yyyy-MM-dd"] stringByAppendingString:@" 00:00:00"];
                NSDate *sinceDate = [inputFormatter dateFromString:sinceStr];//今天零点
                
                timeInterval = [compareDate timeIntervalSinceDate:sinceDate];
                if (timeInterval < 0) {
                    timeInterval = -timeInterval;
                    if (timeInterval < 60 * 60 * 24) {
                        section = DateQQSectionYesterday;
                    }else if (timeInterval > 60 * 60 * 24 * (7-1)) {
                        section = DateQQSectionMonth;
                    } else {
                        section = DateQQSectionWeek;
                    }
                    
                } else {
                    section = DateQQSectionToday;
                }
            } else {
                section = DateQQSectionYear;
            }
        } else {
            section = DateQQSectionFuture;
        }
        
        NSString *result;
        switch (section) {
            case DateQQSectionToday:
            {
                result = [NSString stringWithFormat:@"今天 %@", [NSDate stringFromDate:compareDate withFormat:@"HH:mm"]];
                break;
            }
            case DateQQSectionYesterday:
            {
                result = [NSString stringWithFormat:@"昨天 %@", [NSDate stringFromDate:compareDate withFormat:@"HH:mm"]];
                break;
            }
            case DateQQSectionWeek:
            {
                NSInteger firstWeekday = calendar.firstWeekday;
                //判断周几
                switch (compareComponentsDate.weekday-firstWeekday) {
                    case 0:
                        result = [NSString stringWithFormat:@"星期日 %@", [NSDate stringFromDate:compareDate withFormat:@"HH:mm"]];
                        break;
                    case 1:
                        result = [NSString stringWithFormat:@"星期一 %@", [NSDate stringFromDate:compareDate withFormat:@"HH:mm"]];
                        break;
                    case 2:
                        result = [NSString stringWithFormat:@"星期二 %@", [NSDate stringFromDate:compareDate withFormat:@"HH:mm"]];
                        break;
                    case 3:
                        result = [NSString stringWithFormat:@"星期三 %@", [NSDate stringFromDate:compareDate withFormat:@"HH:mm"]];
                        break;
                    case 4:
                        result = [NSString stringWithFormat:@"星期四 %@", [NSDate stringFromDate:compareDate withFormat:@"HH:mm"]];
                        break;
                    case 5:
                        result = [NSString stringWithFormat:@"星期五 %@", [NSDate stringFromDate:compareDate withFormat:@"HH:mm"]];
                        break;
                    case 6:
                        result = [NSString stringWithFormat:@"星期六 %@", [NSDate stringFromDate:compareDate withFormat:@"HH:mm"]];
                        break;
                    default:
                        break;
                }
                
                break;
            }
            case DateQQSectionMonth:
            {
                result = [NSDate stringFromDate:compareDate withFormat:@"MM-dd HH:mm"];
                break;
            }
            case DateQQSectionYear:
            {
                result = [NSDate stringFromDate:compareDate withFormat:@"yy-MM-dd HH:mm"];//14-2-27 15:34
                break;
            }
            case DateQQSectionFuture:
            {
                result = [NSDate stringFromDate:compareDate withFormat:@"yy-MM-dd HH:mm"];//14-2-27 15:34
                break;
            }
            default:
            {
                result = compareStr;
                break;
            }
        }
        return result;
    }
}




@end
//
//@implementation NSDate+Helpers
//
//
//@end


