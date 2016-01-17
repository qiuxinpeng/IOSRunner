//
//  QXPSoundManager.h
//  BaLaBaLa
//
//  Created by Mr.Qiu on 15/2/4.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "AFSoundManager.h"

@interface NSObject (QXPPlayerHandler)
- (NSString *)tagWithHandlerTagKey;
@end


typedef  void (^playerRateChangedBlock)(BOOL isPlaying);
//typedef  void (^groupCompleteBlock)(BOOL downloadFinished, BOOL isError);

@interface QXPPlayerHandler:NSObject
@property(nonatomic, strong)NSString * playID;
@property(nonatomic, strong)NSString * playURL;
@property(nonatomic, strong)id handler;
@property(nonatomic, assign)playerPlayType type;
@property(nonatomic, strong)playerRateChangedBlock changedBlock;
//@property(nonatomic, strong)groupCompleteBlock completeBlock;
- (void)remove;
@end




//所有要录音要实现的delegate
@protocol QXPSoundRecordDelegate <NSObject>

@required//必须要实现的方法
- (void)willRecordPause;//暂停
- (void)willRecordStop;//停止
- (void)willRecordStart;//开始
- (SoundManagerStyle)recordSoundStyle;
@end

//所有播放要实现的delegate
@protocol QXPSoundPlayingDelegate <NSObject>
@required//必须要实现的方法
- (void)willPlayingPause;//暂停
- (void)willPlayingStop;//停止
- (void)willPlayingStart;//开始
- (SoundManagerStyle)playSoundStyle;
@end


@interface QXPSoundManager : AFSoundManager<HysteriaPlayerDelegate>

typedef void (^QXPSoundProgressBlock)(NSString *startTime,NSString *endTime,int percentage);
typedef void (^QXPSoundFinshBlock)(NSError *error);



@property (nonatomic, strong) id<QXPSoundRecordDelegate > continueRecordOBJ;//要继续录音对象
@property (nonatomic, strong) id<QXPSoundPlayingDelegate> continuePlayingOBJ;//要继续播放对象

@property (nonatomic, strong) id<QXPSoundRecordDelegate > recordOBJ;//录音对象
@property (nonatomic, strong) id<QXPSoundPlayingDelegate> playingOBJ;//播放对象

@property(nonatomic, strong)NSMutableDictionary *handlers;


- (void)addPlayerHandler:(id)delegate type:(playerPlayType)type changedBlick:(void (^)(BOOL isPlaying))block;
- (void)removePlayerHandler:(id)delegate;


-(void)startPlayingWithUrlString:(NSString *)path playingOBJ:(id<QXPSoundPlayingDelegate>)playingOBJ progressBlock:(QXPSoundProgressBlock)progressBlock finshBlock:(QXPSoundFinshBlock)finshBlock;

-(void)startPlayingWithUrlString:(NSString *)path  progressBlock:(QXPSoundProgressBlock)progressBlock finshBlock:(QXPSoundFinshBlock)finshBlock;
//所有录音使用方法
-(void)startRecordingWihtID:(NSString *)recorderID recordOBJ:(id<QXPSoundRecordDelegate>)recordOBJ andBlock:(void (^) (NSString *timeRemaining , NSTimeInterval currentTime))block houldStopAtSecond:(NSTimeInterval)second;






@end
