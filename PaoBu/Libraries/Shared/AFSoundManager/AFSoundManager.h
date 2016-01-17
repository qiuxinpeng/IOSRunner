//
//  AFSoundManager.h
//  AFSoundManager-Demo
//
//  Created by Alvaro Franco on 4/16/14.
//  Copyright (c) 2014 AlvaroFranco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <objc/runtime.h>

#import "AFAudioRouter.h"
#import "HysteriaPlayer.h"


#define QXPRecorderFilePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:@"QXPRecorder"]

#define fileNameWithID(recorderID ) [NSString stringWithFormat:@"%u.wav",(int)recorderID.hash]

#define RecorderFilePath(recorderID) [QXPRecorderFilePath stringByAppendingFormat:@"/%@",fileNameWithID(recorderID)]

typedef NS_ENUM (int, AFSoundManagerStatus) {
    AFSoundManagerStatusPlaying =1,
    AFSoundManagerStatusPaused=2,
    AFSoundManagerStatusStopped=3,
    AFSoundManagerStatusRestarted=4,
    AFSoundManagerStatusFinished=5
};


typedef NS_ENUM(int, AFSoundManagerType) {
    AFSoundManagerTypeLocal,
    AFSoundManagerTypeRemote,
    AFSoundManagerTypeNone
};


@class AFSoundManager;

@protocol AFSoundManagerDelegate

-(void)currentPlayingStatusChanged:(AFSoundManagerStatus)status;

@end

@interface AFSoundManager : NSObject<HysteriaPlayerDelegate>

typedef void (^progressBlock)(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished);

+(instancetype)sharedManager;
@property (nonatomic, assign) id<AFSoundManagerDelegate> delegate;

//@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
//@property (nonatomic, strong) AVPlayer *player;
//@property (nonatomic, strong) AVQueuePlayer *queuePlayer;

@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (nonatomic, strong) HysteriaPlayer *hysteriaPlayer;


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *recorderTimer;
@property (nonatomic) AFSoundManagerType type;
@property (nonatomic, strong) UIImage *artwork;

@property (nonatomic) AFSoundManagerStatus status;

-(void)startPlayingLocalFileWithName:(NSString *)name atPath:(NSString *)path withCompletionBlock:(progressBlock)block;
-(void)startStreamingRemoteAudioFromURL:(NSString *)url andBlock:(progressBlock)block;

-(void)pause;
-(void)resume;
-(void)stop;
-(void)restart;

-(BOOL)status:(AFSoundManagerStatus)status;

-(void)changeVolumeToValue:(CGFloat)volume;
-(void)changeSpeedToRate:(CGFloat)rate;
-(void)moveToSecond:(int)second;
-(void)moveToSection:(CGFloat)section;
-(NSDictionary *)retrieveInfoForCurrentPlaying;

-(void)startRecordingAudioWithFileName:(NSString *)name andExtension:(NSString *)extension shouldStopAtSecond:(NSTimeInterval)second;
-(void)pauseRecording;
-(void)resumeRecording;
-(void)stopAndSaveRecording;
-(void)deleteRecording;
-(NSInteger)timeRecorded;

-(BOOL)areHeadphonesConnected;
-(void)forceOutputToDefaultDevice;
-(void)forceOutputToBuiltInSpeakers;

//- (void)beginReceivingRemoteControlEvents;
//- (void)endReceivingRemoteControlEvents;
- (void)configNowPlayingInfoCenter;
//NSDictionary *albumDic=@{@"name":@"11111",
//@"singer":@"22222",
//@"album":@"33333"
//设置背景信息
- (void)showBcakInfo:(NSString *)name singer:(NSString *)singer album:(NSString *)album image:(UIImage *)iamge;
- (void)refreshBcakInfo;

@end

@interface NSTimer (Blocks)

+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;
+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

@end

@interface NSTimer (Control)

-(void)pauseTimer;
-(void)resumeTimer;

@end