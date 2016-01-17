//
//  QXPDownLoadManager.h
//  YouPlayNew
//
//  Created by 邱玲 on 14-9-1.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCBlobDownload.h"
#import "QXPBlobDownload.h"

#define QXPDefaultFilePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:@"QXPDownLoad"]


#define finderNameWithKey(key ,url) [NSString stringWithFormat:@"%@_%u",key,(int)url.hash]

#define fileNameWithKey(key ,url) [NSString stringWithFormat:@"%@.%@",finderNameWithKey(key,url),[[NSURL URLWithString:url] pathExtension]]

#define downLoadFilePath(name) [QXPDefaultFilePath stringByAppendingFormat:@"/%@",name]

static inline NSString* keyForUrlArray(NSArray *arr){
    NSString *tempStr=[arr componentsJoinedByString:@","];
    return  [NSString stringWithFormat:@"QXPDownLoad%u", (uint)tempStr.hash];
}
static inline NSString* keyForUrl(NSString *url){
    return  [NSString stringWithFormat:@"QXPDownLoad%u", (uint)url.hash];
}

static inline NSString* downLoadFilePathWithURLS(NSArray *urls ,NSString *url){
    
   // downLoadFilePath(fileNameWithKey(keyForUrlArray(urls),url));
    NSString *str=[QXPDefaultFilePath stringByAppendingPathComponent:fileNameWithKey(keyForUrlArray(urls), url)];
    return str;
}
static inline NSString* downLoadFilePathWithURL(NSString *url){
    
    NSString *str=[QXPDefaultFilePath stringByAppendingPathComponent:fileNameWithKey(keyForUrl(url), url)];
    return str;
}
static inline NSString* downLoadfinderPathWithURL(NSString *url){
    
    NSString *str=[QXPDefaultFilePath stringByAppendingPathComponent:finderNameWithKey(keyForUrl(url), url)];
    return str;
}



@interface QXPDownLoadManager : NSObject
/**
 *  批量下载接口
 *
 */
//开始批量下载
//+ (void)startDownloadWithURLArray:(NSArray *)urls
//                       customPath:(NSString *)customPathOrNil
//                         progress:(void (^)(float progress))progressBlock
//                         complete:(void (^)(BOOL downloadFinished, BOOL isError))completeBlock;

+ (void)startDownloadWithURLOBJ:(id)urlOBJ
                     customPath:(NSString *)customPathOrNil
                       progress:(void (^)(float progress))progressBlock
                       complete:(void (^)(BOOL downloadFinished, BOOL isError))completeBlock;

//是否正在下载
+ (BOOL) isDownloadingItemWithURLs:(NSArray*)urls;
//是否正在下载
+ (BOOL) isDownloadingItemWithURL:(NSString*)url;

//取消全部下载
+ (void) stopDownloadingItemWithURLs:(NSArray*)urls;
//取消全部下载
+ (void) stopDownloadingItemWithURL:(NSString*)url;

//查看下载的文件是否全部完整
+ (BOOL) isHaveItemsWithURLs:(NSArray*)urls;
//查看下载的文件是否全部完整
+ (BOOL) isHaveItemsWithURL:(NSString*)url;

//删除所有文件
+ (BOOL)removeItemsWithURLs:(NSArray*)urls;
//删除所有文件
+ (BOOL)removeItemsWithURL:(NSString*)url;

//如果已下载调用此方法查看进度
+ (void) setProgress:(void (^)(float progress))progressBlock URLS:(NSArray *)urls;
//如果已下载调用此方法查看进度
+ (void) setProgress:(void (^)(float progress))progressBlock URL:(NSString *)url;


/**
 *  单个下载接口,现在没有时间以后实现
 *
 */

@end
