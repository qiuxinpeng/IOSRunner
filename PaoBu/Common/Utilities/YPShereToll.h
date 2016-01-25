//
//  YPShereToll.h
//  YouPlayNew
//
//  Created by Mr.Qiu on 14/11/23.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPShereToll : NSObject
//录音分享
+ (void)ShareMP3:(NSString *)path mp3name:(NSString *)name
        shareURL:(NSString *)shareURL shareTitle:(NSString *)shareTitle
       shareText:(NSString *)shareText shareImage:(UIImage *)shareImage sheetController:(UIViewController *)VC;
//曲谱分享
+ (void)ShareTab:(NSString *)shareURL shareTitle:(NSString *)shareTitle
       shareText:(NSString *)shareText shareImage:(UIImage *)shareImage sheetController:(UIViewController *)VC
           tabid:(NSString *)tabid userid:(NSString *)userid;
// 详情
+ (void)ShareTheme:(NSString *)shareURL shareTitle:(NSString *)shareTitle
                 shareText:(NSString *)shareText shareImage:(UIImage *)shareImage sheetController:(UIViewController *)VC
                   themeID:(NSString *)themeID userid:(NSString *)userid  ;
@end
