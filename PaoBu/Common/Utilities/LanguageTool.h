//
//  LanguageTool.h
//  RMT_iphone
//
//  Created by Mr.Qiu on 14-7-8.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

//NSString *str=[[NSBundle mainBundle] localizedStringForKey:@"1232" value:@"" table:@"zh-Hans.lproj/Localizable"];
#define Localize(Key) NSLocalizedString(Key, nil)

@interface LanguageTool : NSObject

@end
