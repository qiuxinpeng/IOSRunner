//
//  QXPNetWorkTools.h
//  QXPNetWork
//
//  Created by 小白 on 13-2-27.
//  Copyright (c) 2013年 小白. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QXPNetWorkEntityClass.h"
#import "QXPNetWorkDelegate.h"



/*
 *删除NSString两边空格
 */
@interface NSString(whitespaceAndNewline)
- (NSString *)removeWhitespaceAndNewline;
@end
@implementation NSString(isJSONString)
- (NSString *)removeWhitespaceAndNewline{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end

///*
// *判断NSString是否是xml格式
// */
@interface NSString(XMLString)
- (BOOL)isXMLString;
@end
@implementation NSString(XMLString)
- (BOOL)isXMLString{
    if (self.length>5 && [[[self removeWhitespaceAndNewline] substringToIndex:5] isEqualToString:@"<?xml"])
        return YES;
    else
        return NO;
}
@end

/*
 *判断NSString是否是JSON格式
 */
@interface NSString(JSONString)
- (BOOL)isJSONString;
@end
@implementation NSString(JSONString)
- (BOOL)isJSONString{
    
    NSString *tempStr=[self removeWhitespaceAndNewline];
    NSString *a=[tempStr substringToIndex:1];
    NSString *b=[tempStr substringFromIndex:(tempStr.length-1)];    
    if (([a isEqualToString:@"("] || [a isEqualToString:@"{"])&& ([b isEqualToString:@")"] || [b isEqualToString:@"}"])&&(([a isEqualToString:@"("] && [b isEqualToString:@")"])||([a isEqualToString:@"{"] && [b isEqualToString:@"}"])))
        return YES;
    else
        return NO;
}
@end

/*
 *NSString删除特殊字符
 */
@interface NSString(specialCharacters)
- (NSString *)removeSpecialCharacters;
@end
@implementation NSString(specialCharacters)
- (NSString *)removeSpecialCharacters{
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    //NSCharacterSet *set =[NSCharacterSet characterSetWithCharactersInString: @" ￡¤|§¨￠￢￣~——+|《》$_€"];
    //NSLog(@"self:%@",self);
    
    NSString *tempString=[[[[self stringByReplacingOccurrencesOfString:@"" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@"\"\"" ] stringByReplacingOccurrencesOfString:@"NULL" withString:@"\"\""];
    return tempString;
}
@end

/*
 *NSString删除特殊字符
 */
@interface NSString(addXMLHeader)
- (NSString *)addXMLHeader;
@end
@implementation NSString(addXMLHeader)
- (NSString *)addXMLHeader{

    return [NSString stringWithFormat:@"%@%@",@"<?xml version=\"1.0\" encoding=\"utf-8\"?>",self];
}
@end