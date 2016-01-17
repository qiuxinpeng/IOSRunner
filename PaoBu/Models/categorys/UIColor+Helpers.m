//
//  UIColor+Helpers.m
//  YouPlayNew
//
//  Created by yon on 14年10月12日.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import "UIColor+Helpers.h"

@implementation UIColor (Helpers)

//主色调
+ (instancetype)YPMainBlueColor {
    return [UIColor colorWithRed:0.16 green:0.55 blue:0.86 alpha:1];
}
//主背景
+ (instancetype)YPBackgroundColor {
    return [UIColor colorWithRed:239./255 green:239./255 blue:239./255 alpha:1];
}
//分组列表的背景iOS8
+ (instancetype)YPGroupListBackgroundColor {
    return [UIColor colorWithRed:242./255 green:242./255 blue:242./255 alpha:1];
}
+ (instancetype)YPGroupListLightBackgroundColor {
    return [UIColor colorWithRed:235./255 green:235./255 blue:242./255 alpha:1];
}
+ (instancetype)YPGroupListSectionBackgroundColor {
    return [UIColor colorWithRed:228./255 green:228./255 blue:228./255 alpha:1];
}
//CCC
+ (instancetype)YPCCCBackgroundColor {
    return [UIColor colorWithHexString:@"cccccc"];
}
//E4E4E4
+ (instancetype)YPE4E4E4BackgroundColor{
    return [UIColor colorWithHexString:@"E4E4E4"];
}
//f9f9f9
+ (instancetype)f9f9f9BackgroundColor{
    return [UIColor colorWithHexString:@"f9f9f9"];
}
//80808
+ (instancetype)f80808TitleColor{
    return [UIColor colorWithHexString:@"808080"];
}
//f2f2f2
+ (instancetype)f2f2f2TitleColor{
    return [UIColor colorWithHexString:@"f2f2f2"];
}
//666666
+ (instancetype)text66666Color{
    return [UIColor colorWithHexString:@"666666"];
}

//文本颜色
+ (instancetype)YPTextWhiteColor {
    return [UIColor whiteColor];
}
+ (instancetype)YPTextBlackColor {
    return [UIColor blackColor];
}
+ (instancetype)YPTextDarkGrayColor {
    return [UIColor darkGrayColor];
}
+ (instancetype)YPTextLightGrayColor {
    return [UIColor lightGrayColor];
}
//左侧栏背景
+ (instancetype)YPLeftBackGroundLightGrayColor {
    return [UIColor colorWithRed:221./255 green:221./255 blue:221./255 alpha:1];
}




@end
