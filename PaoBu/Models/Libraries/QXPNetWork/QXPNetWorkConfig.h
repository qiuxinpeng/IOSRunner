//
//  QXPNetWorkConfig.h
//  QXPNetWorkNew
//
//  Created by Mr.Qiu on 14-7-14.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REQUST_TIMEOUT 60  //默认超时时间



#ifdef DEBUG
#ifndef NETWORK_DEBUG_LOG
#define NETWORK_DEBUG_LOG NSLog
#endif
#else
#ifndef NETWORK_DEBUG_LOG
#define NETWORK_DEBUG_LOG
#endif
#endif

/*
 *是否开启设置代理
 0->off
 1->on
 */
#ifndef NETWORK_DEBUG_PROXY
#define NETWORK_DEBUG_PROXY 0
#endif



/*
 *是否开启调试netWork运行信息
 0->off
 1->on
 */
#ifndef NETWORK_DEBUG_FIG
#define NETWORK_DEBUG_FIG 1
#endif

/*
 *是否开启调试netWork发送数据信息
 0->off
 1->on
 */
#ifndef NETWORK_DEBUG_SENDINFO
#define NETWORK_DEBUG_SENDINFO 1
#endif

/*
 *是否开启调试netWork连接地址
 0->off
 1->on
 */
#ifndef NETWORK_DEBUG_LINKURL
#define NETWORK_DEBUG_LINKURL 1
#endif


/*
 *是否开启调试netWork连接获取的原始数据
 0->off
 1->on
 */
#ifndef NETWORK_DEBUG_RESPONSE_STRING
#define NETWORK_DEBUG_RESPONSE_STRING 1
#endif


/*
 *是否开启调试缓存相关信息
 0->off
 1->on
 */
#ifndef NETWORK_DEBUG_RESPONSE_CACHE
#define NETWORK_DEBUG_RESPONSE_CACHE 1
#endif

/*
 *是否开启调试解析相关信息
 0->off
 1->on
 */
#ifndef NETWORK_DEBUG_SERIALIZE
#define NETWORK_DEBUG_SERIALIZE 1
#endif


/*
 *是否开启调试取消连接相关信息
 0->off
 1->on
 */
#ifndef NETWORK_DEBUG_CANCEL
#define NETWORK_DEBUG_CANCEL 1
#endif
