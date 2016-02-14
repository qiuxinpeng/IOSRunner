//
//  NSString+Helpers.m
//  DOOCT_IPhone
//
//  Created by 邱新鹏 on 13-7-3.
//  Copyright (c) 2013年 DCT. All rights reserved.
//

#import "NSString+Helpers.h"
#import "CommonCrypto/CommonDigest.h"


@implementation NSString (Helpers)

//判断是否是电话号码
-(BOOL)checkPhoneNumInput{
    NSString *regex =@"(13[0-9]|0[1-9]|0[1-9][0-9]|0[1-9][0-9][0-9]|15[0-9]|18[02356789])\\d{8}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [mobileTest evaluateWithObject:self];
}
//判断是否是email
-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}


//判断是否是手机号
-(BOOL)isValidateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *temp=@"^13[0-9]{1}[0-9]{8}$|15[0-9]{1}[0-9]{8}$|17[0-9]{1}[0-9]{8}$|18[0-9]{9}$|17[0-9]{9}$|14[0-9]{9}$";
    NSPredicate *regextesTemp = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", temp];
    return [regextesTemp evaluateWithObject:self];
}
//判断字符是否是数字
-(BOOL)isNumber{
    NSCharacterSet*cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString*filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}
//判断是否是为空或者空字符串
-(BOOL)isNilOrEmpty{
    return (self==(NSString *)[NSNull null] || !self || [self isEmpty] );
}

//判断是否是空字符串
-(BOOL)isEmpty{
    return [self isEqualToString:@""];
}

- (NSString*)TORC4:(NSString*)aKey
{
    
    NSMutableArray *iS = [[NSMutableArray alloc] initWithCapacity:256];
    NSMutableArray *iK = [[NSMutableArray alloc] initWithCapacity:256];
    
    for (int i= 0; i<256; i++) {
        [iS addObject:[NSNumber numberWithInt:i]];
    }
    
    int j=1;
    
    for (short i=0; i<256; i++) {
        
        UniChar c = [aKey characterAtIndex:i%aKey.length];
        
        [iK addObject:[NSNumber numberWithChar:c]];
    }
    
    j=0;
    
    for (int i=0; i<255; i++) {
        int is = [[iS objectAtIndex:i] intValue];
        UniChar ik = (UniChar)[[iK objectAtIndex:i] charValue];
        
        j = (j + is + ik)%256;
        NSNumber *temp = [iS objectAtIndex:i];
        [iS replaceObjectAtIndex:i withObject:[iS objectAtIndex:j]];
        [iS replaceObjectAtIndex:j withObject:temp];
        
    }
    
    int i=0;
    j=0;
    
    NSString *result = self;
    
    for (short x=0; x<[self length]; x++) {
        i = (i+1)%256;
        
        int is = [[iS objectAtIndex:i] intValue];
        j = (j+is)%256;
        
        int is_i = [[iS objectAtIndex:i] intValue];
        int is_j = [[iS objectAtIndex:j] intValue];
        
        int t = (is_i+is_j) % 256;
        int iY = [[iS objectAtIndex:t] intValue];
        
        UniChar ch = (UniChar)[self characterAtIndex:x];
        UniChar ch_y = ch^iY;
        
        result = [result stringByReplacingCharactersInRange:NSMakeRange(x, 1) withString:[NSString stringWithCharacters:&ch_y length:1]];
    }
    iS=nil;
    iK=nil;
    return result;
}
//将Int转成Str
NSString* stringWithInt(NSInteger number){
    return [NSString stringWithFormat:@"%ld",(long)number];
}
//将double转成Str
NSString* stringWithDouble(double number){
    return [NSString stringWithFormat:@"%lf",number];
}
NSString* stringWithFloat(float number){
    return [NSString stringWithFormat:@"%f",number];
}


/**
 *得到本机现在用的语言
 * en:英文  zh-Hans:简体中文   zh-Hant:繁体中文    ja:日本  ......
 */
+ (NSString*)stringWithPreferredLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}
/**
 得到当前的日期
 */
+(NSString*) stringWithCurDate
{
    NSDate *curDate = [NSDate date];//获取当前日期
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];//这里去掉 具体时间 保留日期
    NSString * curTime = [formater stringFromDate:curDate];
    return curTime;
}

/**
 得到当前的时间轴
 */
+(NSString*) gstringWithCurLongTime
{
    NSDate *curDate = [NSDate date];//获取当前日期
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[curDate timeIntervalSince1970]];
    return timeSp;
}

//获取截取String并去除首尾空格
- (NSString *)getSelectTitle:(NSRange)range {
    NSString *tempStr=[[self substringWithRange:range] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *tempStr2=tempStr.length<SELECTTITLE_COUNT?tempStr:[tempStr substringWithRange:NSMakeRange(0, SELECTTITLE_COUNT)];
    tempStr=nil;
    return tempStr2;
}
//删除首尾空格
- (NSString *)trim{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
//去除空格
- (NSString *)removeSpaces{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//MD5
-(NSString *) md5{

    const char* str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (unsigned int)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//

    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02X", result[i]];
    }
    return ret;
}
//根据秒数获取时间
+ (NSString *)timeFormatted:(int)totalSeconds{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}
+ (NSString *)timeFormatted2:(int)totalSeconds{
    
    if (totalSeconds<0) {
        
        return @"00:00";
    }
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    //int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    
}

- (NSString*)stringByEscapingForURLArgument {
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    CFStringRef escaped =
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            NULL,
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8);
    return (__bridge NSString *)(escaped);
}

- (NSString*)stringByUnescapingFromURLArgument {
    NSMutableString *resultString = [NSMutableString stringWithString:self];
    [resultString replaceOccurrencesOfString:@"+"
                                  withString:@" "
                                     options:NSLiteralSearch
                                       range:NSMakeRange(0, [resultString length])];
    return [resultString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end
