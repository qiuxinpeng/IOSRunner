//
//  QXPPhotoBrowser.h
//  PhotoBrowserDemo
//
//  Created by Mr.Qiu on 15/4/7.
//
//

#import "MWPhotoBrowser.h"

@interface QXPPhotoBrowser : MWPhotoBrowser
@property(nonatomic,strong)NSArray *photos;
@property(nonatomic, strong)void(^selectBlock)(NSInteger index,id obj);
@end
