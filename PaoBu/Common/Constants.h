//判断当前版本大于指定版本
#define QXPSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
//判断是否是Iphone5
#define IS_IPHONE_5 (fabs( (double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON )

#define IS_IOS7_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)

//当前系统语言
#define CURRENT_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])

//Documents文件夹
#define DOCUMENT_FOLDER   [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]


#define VERSION_GREATER_THAN_OR_EQUAL_TO(v)([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] compare:v options:NSNumericSearch]==NSOrderedAscending)


#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#define APP_VERSION @"1.1.0"

//app进入后台通知名称
#define APP_DidEnterBackground  @"APP_DidEnterBackground_KEY"

//app进入前台台通知名称
#define APP_DidBecomeActive  @"APP_DidBecomeActive_KEY"

//jpge 压缩比例
#define JPEGQULITY 0.7

//跳过ARC编译警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//延时在主线程执行
#define QXPMainAfter_define(time,Stuff)\
do{\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){Stuff});\
}while (0)
//延时在主线程执行Block
#define QXPMainAfterBlock_define(time,block)\
do{\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);\
}while (0)



/*
 *是否开启强制Log
 0->off
 1->on
 */
#ifndef LOG_LOGALL
#define LOG_LOGALL 1
#endif



/*
 *是否是appSotre版本
 0->off
 1->on
 */
#ifndef VERSION_APPSTORE
#define VERSION_APPSTORE 1
#endif



/*
 *创建日志输出方法
 */
#ifdef DEBUG
//static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#define QLog(frmt, ...)  NSLog((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,        ##__VA_ARGS__)
#define QLogE(frmt, ...) NSLog((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,       ##__VA_ARGS__)
#define QLogW(frmt, ...) NSLog((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,        ##__VA_ARGS__)
#define QLogI(frmt, ...) NSLog((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,        ##__VA_ARGS__)
#define QLogD(frmt, ...) NSLog((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,       ##__VA_ARGS__)
#define QLogV(frmt, ...) NSLog((@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,     ##__VA_ARGS__)

#define ICLog(frmt, ...)  [iConsole log:(@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,       ##__VA_ARGS__];
#define ICLogI(frmt, ...) [iConsole info:(@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,       ##__VA_ARGS__];
#define ICLogW(frmt, ...) [iConsole warn:(@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,       ##__VA_ARGS__];
#define ICLogE(frmt, ...) [iConsole error:(@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,       ##__VA_ARGS__];
#define ICLogC(frmt, ...) [iConsole crash:(@"%s [第%d行]:" frmt), __PRETTY_FUNCTION__, __LINE__,       ##__VA_ARGS__];

#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#define QLog(frmt, ...)
#define QLogE(frmt, ...)
#define QLogW(frmt, ...)
#define QLogI(frmt, ...)
#define QLogD(frmt, ...)
#define QLogV(frmt, ...)

#define ICLog(frmt, ...)
#define ICLogI(frmt, ...)
#define ICLogW(frmt, ...)
#define ICLogE(frmt, ...)
#define ICLogC(frmt, ...)
#endif


#define _po(o) QLog(@"%@", (o))
#define _pn(o) QLog(@"%d", (o))
#define _pf(o) QLog(@"%f", (o))
#define _ps(o) QLog(@"CGSize: {%.0f, %.0f}", (o).width, (o).height)
#define _pr(o) QLog(@"NSRect: {{%.0f, %.0f}, {%.0f, %.0f}}", (o).origin.x, (o).origin.x, (o).size.width, (o).size.height)

/**/
//定义UIImage对象 在资源不吃紧的情况下,这种反而是个累赘,因为没有缓存.imagenamed只是说要缓存,而且无法手动清空而已.缓存是好是坏,只能自己判定.
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]


//获得颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height

#define PAGE_COUNT_DEFAULT 10

//收到消息通知名称
#define HOME_MESSAGE_NotificationName @"HOME_MESSAGE_NotificationName"

