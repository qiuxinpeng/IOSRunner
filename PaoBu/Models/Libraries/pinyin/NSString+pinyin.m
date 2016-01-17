//
//  NSString+pinyin.m
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-9-17.
//  Copyright (c) 2014年 9tong.com. All rights reserved.
//

#import "NSString+pinyin.h"
#import "Qpinyin.h"
@implementation NSString (pinyin)
//首字母拼音
- (NSString *)firstPinYin{
    return [self firstPinYinWithIsContacts:NO];
}
//全部拼音
- (NSString *)allPinYin{
    return [self allPinYinIsContacts:NO];
}
//去不拼音数组
- (NSArray *)allPinYinArr{
    return [self allPinYinArrIsContacts:NO];
}


//首字母拼音 是否是人姓名 是姓名要做特殊处理
- (NSString *)firstPinYinWithIsContacts:(BOOL)contacts{
    
    if ([self isNilOrEmpty]) {
        return @"";
    }
    if (contacts && [self pingYinWithTeShuXing]) {
        return [self pingYinWithTeShuXing];
    }
    return [[NSString stringWithFormat:@"%c",QpinyinFirstLetter([self characterAtIndex:0])] uppercaseString];

    return @"";
}
//全部拼音 是否是人姓名 是姓名要做特殊处理
- (NSString *)allPinYinIsContacts:(BOOL)contacts{
    
    if ([self isNilOrEmpty]) {
        return @"";
    }
    NSMutableString *str=[NSMutableString string];
    for(int j=0;j<self.length;j++){
        if (contacts && j==0) {
            [str appendString:[self firstPinYinWithIsContacts:YES]];
        }else{
            NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",QpinyinFirstLetter([self characterAtIndex:j])]uppercaseString];
            [str appendString:singlePinyinLetter];
        }
    }
    return str;
}
//去不拼音数组 是否是人姓名 是姓名要做特殊处理
- (NSArray *)allPinYinArrIsContacts:(BOOL)contacts{

    if ([self isNilOrEmpty]) {
        return nil;
    }
    NSMutableArray *strArr=[NSMutableArray array];
    for(int j=0;j<self.length;j++){
        if (contacts && j==0) {
            [strArr addObject:[self firstPinYinWithIsContacts:YES]];
        }else{
            NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",QpinyinFirstLetter([self characterAtIndex:j])]uppercaseString];
            [strArr addObject:singlePinyinLetter];
        }
    }
    return strArr;
}
//特殊性别的首字母
- (NSString *)pingYinWithTeShuXing{
    NSString *tempStr=nil;
    if([NSString searchResult:self searchText:@"曾"])
        tempStr = @"Z";
    else if([NSString searchResult:self searchText:@"解"])
        tempStr = @"X";
    else if([NSString searchResult:self searchText:@"仇"])
        tempStr = @"Q";
    else if([NSString searchResult:self searchText:@"朴"])
        tempStr = @"P";
    else if([NSString searchResult:self searchText:@"查"])
        tempStr = @"Z";
    else if([NSString searchResult:self searchText:@"能"])
        tempStr = @"N";
    else if([NSString searchResult:self searchText:@"乐"])
        tempStr = @"Y";
    else if([NSString searchResult:self searchText:@"单"])
        tempStr = @"S";
    return tempStr;
}
+(BOOL)searchResult:(NSString *)contactName searchText:(NSString *)searchT{
	NSComparisonResult result = [contactName compare:searchT options:NSCaseInsensitiveSearch
											   range:NSMakeRange(0, searchT.length)];
	if (result == NSOrderedSame)
		return YES;
	else
		return NO;
}
@end
