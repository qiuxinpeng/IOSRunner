//
//  CommonDefine.h
//  RMT_iphone
//  普通属性预定义
//  Created by Victor on 8/1/14.
//  Copyright (c) 2014 9tong.com. All rights reserved.
//

#ifndef RMT_iphone_CommonDefine_h
#define RMT_iphone_CommonDefine_h


#pragma mark - APP信息
/*--------------------------------------------------APP信息---------------------------------------------------*/
#define BB_VERSION     [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleDisplayName"]       //版本号
//我的下载删除通知
#define DOWNLOAD_NSNotification_DELEGATE  @"DOWNLOAD_NSNotification_DELEGATE"
//词句删除系在通知
#define KEYWORD_NSNotification_DELEGATE  @"KEYWORD_NSNotification_DELEGATE"



#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define MB_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif


#endif
