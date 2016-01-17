//
//  UIColor+Helpers.h
//  YouPlayNew
//
//  Created by yon on 14年10月12日.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Helpers)

//主色调
+ (instancetype)YPMainBlueColor;
//主背景
+ (instancetype)YPBackgroundColor;
//分组列表的背景iOS8
+ (instancetype)YPGroupListBackgroundColor;
+ (instancetype)YPGroupListLightBackgroundColor;
+ (instancetype)YPGroupListSectionBackgroundColor;
//CCC
+ (instancetype)YPCCCBackgroundColor;
//E4E4E4
+ (instancetype)YPE4E4E4BackgroundColor;
//f9f9f9
+ (instancetype)f9f9f9BackgroundColor;
//80808
+ (instancetype)f80808TitleColor;
//f2f2f2
+ (instancetype)f2f2f2TitleColor;
//666666
+ (instancetype)text66666Color;


//文本颜色
+ (instancetype)YPTextWhiteColor;
+ (instancetype)YPTextBlackColor;
+ (instancetype)YPTextDarkGrayColor;
+ (instancetype)YPTextLightGrayColor;

//左侧栏背景
+ (instancetype)YPLeftBackGroundLightGrayColor;

@end
