//
//  QXPDownLoadManager.m
//  YouPlayNew
//
//  Created by 邱玲 on 14-9-1.
//  Copyright (c) 2014年 邱新鹏. All rights reserved.
//

#import "QXPDownLoadManager.h"

typedef  void (^groupProgressBlock)(float progress);
typedef  void (^groupCompleteBlock)(BOOL downloadFinished, BOOL isError);

@interface LoadHandler:NSObject
@property(nonatomic, strong)groupProgressBlock progressBlock;
@property(nonatomic, strong)groupCompleteBlock completeBlock;

@end
@implementation LoadHandler
@end


@interface QXPDownLoadManager ()<TCBlobDownloaderDelegate>
@property(nonatomic, strong)NSMutableDictionary *queues;
@property(nonatomic, strong)NSMutableDictionary *finshCountDict;
@property(nonatomic, strong)NSMutableDictionary *progressDict;
@property(nonatomic, strong)NSMutableDictionary *downloadHandlers;



@end




@implementation QXPDownLoadManager
+ (instancetype) instance
{
	static id instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[[self class] alloc] init];
	});
	return instance;
}
- (instancetype)init{

    if ((self=[super init])) {
        self.queues=[NSMutableDictionary new];
        self.finshCountDict=[NSMutableDictionary new];
        self.progressDict=[NSMutableDictionary new];
        self.downloadHandlers=[NSMutableDictionary new];
    }
    return self;
}

//是否正在下载
+ (BOOL) isDownloadingItemWithURLs:(NSArray*)urls{

    return [[QXPDownLoadManager instance].queues objectForKey:keyForUrlArray(urls)]!=nil;
}
//是否正在下载
+ (BOOL) isDownloadingItemWithURL:(NSString*)url{

    return [[QXPDownLoadManager instance].queues objectForKey:keyForUrl(url)]!=nil;
}
//取消全部下载
+ (void) stopDownloadingItemWithURLs:(NSArray*)urls{
    [[QXPDownLoadManager instance] completeWith:keyForUrlArray(urls) isError:YES];
}
//取消全部下载
+ (void) stopDownloadingItemWithURL:(NSString*)url{
    [[QXPDownLoadManager instance] completeWith:keyForUrl(url) isError:YES];
}


//查看下载的文件是否全部完整
+ (BOOL) isHaveItemsWithURLs:(NSArray*)urls{
    
    BOOL isOK=YES;
    for (NSString *rul in urls) {
        NSString *path=downLoadFilePathWithURLS(urls, rul);
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            isOK=NO;
            return isOK;
        }
    }
    return isOK;
}
//查看下载的文件是否全部完整
+ (BOOL) isHaveItemsWithURL:(NSString*)url{
    BOOL isOK=YES;
    NSString *path=downLoadFilePathWithURL(url);
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        isOK=NO;
        return isOK;
    }
    return isOK;
}

+ (BOOL)removeItemsWithURLs:(NSArray*)urls{

    for (NSString *rul in urls) {
        NSString *path=downLoadFilePathWithURLS(urls, rul);
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    return YES;
}
//删除所有文件
+ (BOOL)removeItemsWithURL:(NSString*)url{

    NSString *path=downLoadFilePathWithURL(url);
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    return YES;
}

//如果已下载调用此方法查看进度
+ (void) setProgress:(void (^)(float progress))progressBlock URLS:(NSArray *)urls{

    NSString *key=keyForUrlArray(urls);
    LoadHandler *handler=[QXPDownLoadManager instance].downloadHandlers[key];
    if (!handler) {
        progressBlock(1);
    }else{
        handler.progressBlock=progressBlock;
    }
}
//如果已下载调用此方法查看进度
+ (void) setProgress:(void (^)(float progress))progressBlock URL:(NSString *)url{
    NSString *key=keyForUrl(url);
    LoadHandler *handler=[QXPDownLoadManager instance].downloadHandlers[key];
    if (!handler) {
        progressBlock(1);
    }else{
        handler.progressBlock=progressBlock;
    }
    
}

+ (void)startDownloadWithURLArray:(NSArray *)urls
                       customPath:(NSString *)customPathOrNil
                         progress:(void (^)(float progress))progressBlock
                         complete:(void (^)(BOOL downloadFinished, BOOL isError))completeBlock{
    
    
//    if (!urls || urls.count==0) {
//        return;
//    }
//    
//    NSString *key=keyForUrlArray(urls);
//    NSOperationQueue *tempQueue=[[NSOperationQueue alloc] init];
//    [tempQueue setMaxConcurrentOperationCount:5];
//    //线程库
//    [[QXPDownLoadManager instance].queues setObject:tempQueue forKey:key];
//    
//    //完成计数
//    [[QXPDownLoadManager instance].finshCountDict setObject:@0 forKey:key];
//    
//    
//    NSMutableArray *progressArr=[NSMutableArray array];
//    
//    for (int i=0; i<urls.count; i++) {
//        NSString *url=urls[i];
//        QXPBlobDownload *downloader = [[QXPBlobDownload alloc] initWithURL:[NSURL URLWithString:url] downloadPath:customPathOrNil?customPathOrNil:QXPDefaultFilePath delegate:[QXPDownLoadManager instance]];
//        downloader.keyTag=key;
//        downloader.groupCount=(int)urls.count;
//        downloader.groupIndex=i;
//        downloader.fileName=fileNameWithKey(key, url);
//        [tempQueue addOperation:downloader];
//        
//        [progressArr addObject:@(downloader.progress)];
//    }
//    
//    
//    
//    //百分比
//    [[QXPDownLoadManager instance].progressDict setObject:progressArr forKey:key];
//    
//    
//    //回调
//    LoadHandler *handler=[LoadHandler new];
//    handler.progressBlock=progressBlock;
//    handler.completeBlock=completeBlock;
//    [[QXPDownLoadManager instance].downloadHandlers setObject:handler forKey:key];
    [self startDownloadWithURLOBJ:urls customPath:customPathOrNil progress:progressBlock complete:completeBlock];


}
+ (void)startDownloadWithURL:(NSString *)url
                  customPath:(NSString *)customPathOrNil
                    progress:(void (^)(float progress))progressBlock
                    complete:(void (^)(BOOL downloadFinished, BOOL isError))completeBlock{
    [self startDownloadWithURLOBJ:url customPath:customPathOrNil progress:progressBlock complete:completeBlock];
    
    
    
}
+ (void)startDownloadWithURLOBJ:(id)urlOBJ
                     customPath:(NSString *)customPathOrNil
                       progress:(void (^)(float progress))progressBlock
                       complete:(void (^)(BOOL downloadFinished, BOOL isError))completeBlock{
    
    
    if ([urlOBJ isKindOfClass:NSString.class] || [urlOBJ isKindOfClass:NSArray.class] ) {
        
    }else if(!urlOBJ){
        return;
    }else{
        return;
    }
    
    NSString *key=nil;
    QXPBlobDownloadType type=QXPBlobDownloadTypeURL;
    NSOperationQueue *tempQueue=nil;
    
    if ([urlOBJ isKindOfClass:NSString.class]) {
        
        NSString *tempURL=urlOBJ;
        key=keyForUrl(urlOBJ);
        type=QXPBlobDownloadTypeURL;
        tempQueue=[[NSOperationQueue alloc] init];
        [tempQueue setMaxConcurrentOperationCount:1];
        //线程库
        [[QXPDownLoadManager instance].queues setObject:tempQueue forKey:key];
        
        //完成计数
        [[QXPDownLoadManager instance].finshCountDict setObject:@0 forKey:key];
        
        NSMutableArray *progressArr=[NSMutableArray array];

        
        QXPBlobDownload *downloader = [[QXPBlobDownload alloc] initWithURL:[NSURL URLWithString:tempURL] downloadPath:customPathOrNil?customPathOrNil:QXPDefaultFilePath delegate:[QXPDownLoadManager instance]];
        downloader.keyTag=key;
        downloader.groupCount=1;
        downloader.groupIndex=0;
        downloader.fileName=fileNameWithKey(key, tempURL);
        downloader.type=type;
        [tempQueue addOperation:downloader];
        
        [progressArr addObject:@(downloader.progress)];
        
        
        //百分比
        [[QXPDownLoadManager instance].progressDict setObject:progressArr forKey:key];
        
        //回调
        LoadHandler *handler=[LoadHandler new];
        handler.progressBlock=progressBlock;
        handler.completeBlock=completeBlock;
        [[QXPDownLoadManager instance].downloadHandlers setObject:handler forKey:key];
        

    }else if ([urlOBJ isKindOfClass:NSArray.class]){
    
        NSArray *tempArr=(NSArray *)urlOBJ;
        if (tempArr.count==0) {
            return;
        }
        key=keyForUrlArray(tempArr);
        type=QXPBlobDownloadTypeURLArray;
        tempQueue=[[NSOperationQueue alloc] init];
        [tempQueue setMaxConcurrentOperationCount:5];
        //线程库
        [[QXPDownLoadManager instance].queues setObject:tempQueue forKey:key];
        
        //完成计数
        [[QXPDownLoadManager instance].finshCountDict setObject:@0 forKey:key];
        
        
        NSMutableArray *progressArr=[NSMutableArray array];
        
        for (int i=0; i<tempArr.count; i++) {
            NSString *url=tempArr[i];
            QXPBlobDownload *downloader = [[QXPBlobDownload alloc] initWithURL:[NSURL URLWithString:url] downloadPath:customPathOrNil?customPathOrNil:QXPDefaultFilePath delegate:[QXPDownLoadManager instance]];
            downloader.keyTag=key;
            downloader.groupCount=(int)tempArr.count;
            downloader.groupIndex=i;
            downloader.fileName=fileNameWithKey(key, url);
            downloader.type=type;
            [tempQueue addOperation:downloader];
            
            [progressArr addObject:@(downloader.progress)];
        }
        
        
        //百分比
        [[QXPDownLoadManager instance].progressDict setObject:progressArr forKey:key];
        
        //回调
        LoadHandler *handler=[LoadHandler new];
        handler.progressBlock=progressBlock;
        handler.completeBlock=completeBlock;
        [[QXPDownLoadManager instance].downloadHandlers setObject:handler forKey:key];

    }
    
}

- (void)download:(QXPBlobDownload *)blobDownload
  didReceiveData:(uint64_t)receivedLength
         onTotal:(uint64_t)totalLength
        progress:(float)progress{
    
    NSMutableArray *progressArr=self.progressDict[blobDownload.keyTag];
    progressArr[blobDownload.groupIndex]=@(progress);
    
    LoadHandler *handler=self.downloadHandlers[blobDownload.keyTag];
    float tempProgress=0;
    for (NSNumber *nu in self.progressDict[blobDownload.keyTag]) {
        tempProgress+=[nu floatValue];
    }
    tempProgress=tempProgress/blobDownload.groupCount;
    handler.progressBlock(tempProgress);
    
}

- (void)download:(QXPBlobDownload *)blobDownload
didStopWithError:(NSError *)error{
    [self completeWith:blobDownload.keyTag isError:YES];
    
}


- (void)download:(QXPBlobDownload *)blobDownload
didFinishWithSuccess:(BOOL)downloadFinished
          atPath:(NSString *)pathToFile{
    
    int count=[self.finshCountDict[blobDownload.keyTag] intValue];
    int tempCount=count+1;
    [self.finshCountDict setObject:@(tempCount) forKey:blobDownload.keyTag];
    
    if ([self.finshCountDict[blobDownload.keyTag] intValue]==blobDownload.groupCount) {
        
        [self completeWith:blobDownload.keyTag isError:NO];
        
    }
    
}

- (void)completeWith:(NSString *)key isError:(BOOL)err{
    
    
    LoadHandler *handler=self.downloadHandlers[key];
    handler.completeBlock(YES,err);
    
    //取消所有线程
    NSOperationQueue *queue=self.queues[key];
    if (err) {
        for (TCBlobDownloader *loader in queue.operations) {
            [loader cancelDownloadAndRemoveFile:YES];
        }
    }
    [queue cancelAllOperations];
    
    
    //移除线程队列
    [self.queues removeObjectForKey:key];
    
    
    //移除完成count
    [self.finshCountDict removeObjectForKey:key];
    
    
    //移除完成progress
    [self.progressDict removeObjectForKey:key];
    
    
    //移除完成回掉
    [self.downloadHandlers removeObjectForKey:key];

    

}
@end
