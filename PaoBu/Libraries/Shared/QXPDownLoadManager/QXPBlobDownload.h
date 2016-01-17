//
//  QXPBlobDownload.h
//  BaLaBaLa
//
//  Created by Mr.Qiu on 15/1/23.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "TCBlobDownloader.h"


typedef NS_ENUM(NSInteger, QXPBlobDownloadType) {
    QXPBlobDownloadTypeURL = 0,// 单个
    QXPBlobDownloadTypeURLArray = 1,// 多个
};

@interface QXPBlobDownload : TCBlobDownloader
// @since 1.2  邱新鹏
@property(nonatomic, strong)NSString *keyTag;
@property(nonatomic)int groupCount;
@property(nonatomic)int groupIndex;
@property(nonatomic)QXPBlobDownloadType type;
@end
