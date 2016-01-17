//
//  QXPSoundManager.m
//  BaLaBaLa
//
//  Created by Mr.Qiu on 15/2/4.
//  Copyright (c) 2015年 Mr.Qiu. All rights reserved.
//

#import "QXPSoundManager.h"

const char QXPPlayerHandlerTagKey;

@implementation NSObject (QXPPlayerHandler)

- (NSString *)tagWithHandlerTagKey{
    
    NSString *tegStr = objc_getAssociatedObject(self, &QXPPlayerHandlerTagKey);
    if(tegStr == nil){
        
        tegStr=[NSString stringWithFormat:@"%@_%d_%d",NSStringFromClass([self class]),rand(),rand()];
        objc_setAssociatedObject(self, &QXPPlayerHandlerTagKey, tegStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return tegStr;
}
@end

@implementation QXPPlayerHandler
- (void)remove{
    self.playID=nil;
    self.playURL=nil;
    self.handler=nil;
    self.changedBlock=nil;
}
@end

@implementation QXPSoundManager
+(instancetype)sharedManager {
    
    static QXPSoundManager *soundManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        soundManager = [[self alloc]init];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:QXPRecorderFilePath ]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:QXPRecorderFilePath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:nil];
        }
        soundManager.hysteriaPlayer=[HysteriaPlayer sharedInstance];
        [soundManager.hysteriaPlayer addDelegate:soundManager];
        [soundManager setAudioSession];
        
        soundManager.handlers=[NSMutableDictionary dictionary];
        
        
        [soundManager.hysteriaPlayer addDelegate:soundManager];


    });
    return soundManager;
}
#pragma hysteriaPlayer Delegate
- (void)hysteriaPlayerRateChanged:(BOOL)isPlaying{

    for (QXPPlayerHandler *obj in [self.handlers allValues]) {
        if (obj.changedBlock) {
            obj.changedBlock(isPlaying);
        }
    }
}
-(void)startPlayingWithUrlString:(NSString *)path  progressBlock:(QXPSoundProgressBlock)progressBlock finshBlock:(QXPSoundFinshBlock)finshBlock{

    if (!path) {
        finshBlock([NSError errorWithDomain:@"播放地址不能位空" code:6000 userInfo:nil]);
        return;
    }
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    __weak __typeof(self) wself = self;
    
    NSURL *palyURL=nil;
    if ([path rangeOfString:@"http"].length>0 || [path rangeOfString:@"HTTP"].length>0) {
        palyURL=[NSURL URLWithString:path];
        
        if (!palyURL) {
            return;
        }
        
        [self.hysteriaPlayer registerHandlerReadyToPlay:^(HysteriaPlayerReadyToPlay identifier) {
            switch (identifier) {
                case HysteriaPlayerReadyToPlayPlayer:
                    // It will be called when Player is ready to play at the first time.
                    
                    // If you have any UI changes related to Player, should update here.
                    break;
                    
                case HysteriaPlayerReadyToPlayCurrentItem:
                    // It will be called when current PlayerItem is ready to play.
                    
                    // HysteriaPlayer will automatic play it, if you don't like this behavior,
                    // You can pausePlayerForcibly:YES to stop it.
                    break;
                default:
                    break;
            }
        }];
       
        [self.hysteriaPlayer removeAllItems];
        [self.hysteriaPlayer asyncSetupSourceGetter:^(NSUInteger index) {
            [wself.hysteriaPlayer setupPlayerItemWithUrl:palyURL Order:index];

        } ItemsCount:1];
        [self.hysteriaPlayer fetchAndPlayPlayerItem:0];
        [self.hysteriaPlayer setPlayerRepeatMode:HysteriaPlayerRepeatModeOff];
        
        
        [self.hysteriaPlayer pausePlayerForcibly:NO];
        [self.hysteriaPlayer play];


        
        self.type = AFSoundManagerTypeRemote;
        self.status = AFSoundManagerStatusPlaying;
        [self.delegate currentPlayingStatusChanged:AFSoundManagerStatusPlaying];
        
    }else{
        
        
        palyURL=[NSURL fileURLWithPath:path];
        
        if (!palyURL) {
            return;
        }
          [self.hysteriaPlayer removeAllItems];
        [self.hysteriaPlayer asyncSetupSourceGetter:^(NSUInteger index) {
            [wself.hysteriaPlayer setupPlayerItemWithUrl:palyURL Order:index];
            
        } ItemsCount:1];
        [self.hysteriaPlayer fetchAndPlayPlayerItem:0];
        [self.hysteriaPlayer setPlayerRepeatMode:HysteriaPlayerRepeatModeOff];
        
        
        [self.hysteriaPlayer pausePlayerForcibly:NO];
        [self.hysteriaPlayer play];
        
        self.type = AFSoundManagerTypeLocal;
        self.status = AFSoundManagerStatusPlaying;
        [self.delegate currentPlayingStatusChanged:AFSoundManagerStatusPlaying];
    }
   

    NSError *error = nil;
    
    if (!error) {
        
        __block int percentage = 0;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^{
            
            
            if ((CMTimeGetSeconds(wself.hysteriaPlayer.getCurrentItem.duration) - CMTimeGetSeconds(wself.hysteriaPlayer.getCurrentItem.currentTime)) != 0) {
                
                percentage = (int)((CMTimeGetSeconds(wself.hysteriaPlayer.getCurrentItem.currentTime) * 100)/CMTimeGetSeconds(wself.hysteriaPlayer.getCurrentItem.duration));
                int timeRemaining = CMTimeGetSeconds(wself.hysteriaPlayer.getCurrentItem.duration) - CMTimeGetSeconds(wself.hysteriaPlayer.getCurrentItem.currentTime);
                CGFloat elapsedTime=CMTimeGetSeconds(wself.hysteriaPlayer.getCurrentItem.currentTime);
                
                NSString *startTimeStr=[NSString timeFormatted2:elapsedTime];
                
                NSString *endTimeStr=[NSString stringWithFormat:@"-%@",[NSString timeFormatted2:timeRemaining]];
                
                
                //NSLog(@"startTimeStr:%@",startTimeStr);
                //NSLog(@"endTimeStr:%@",endTimeStr);

                if (progressBlock) {
                    progressBlock(startTimeStr,endTimeStr,percentage);
                }
            } else {
                
     
                if (progressBlock) {
                    progressBlock(@"00:00",@"00:00",100);
                }
                
                [wself.playingOBJ willPlayingStop];

                [wself.timer invalidate];
                wself.status = AFSoundManagerStatusFinished;
                [wself.delegate currentPlayingStatusChanged:AFSoundManagerStatusFinished];
                

                
                if (finshBlock) {
                    finshBlock(nil);
                }
            }
        } repeats:YES];
    } else {
        
        if (finshBlock) {
            finshBlock(error);
        }
        [self stop];
    }
    
    
}
-(void)setAudioSession{
    
    //AudioSessionInitialize用于控制打断 ，后面会说
    
    AudioSessionInitialize (
                            
                            NULL,                          // ‘NULL’ to use the default (main) run loop
                            
                            NULL,                          // ‘NULL’ to use the default run loop mode
                            
                            ASAudioSessionInterruptionListener,  // a reference to your interruption callback
                            
                            NULL                       // data to pass to your interruption listener callback
                            
                            );
    
    //这种方式后台，可以连续播放非网络请求歌曲，遇到网络请求歌曲就废,需要后台申请task
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *setCategoryError = nil;
    
    BOOL success = [session setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    
    if (!success)
        
    {
        
        /* handle the error condition */
        
        return;
        
    }
    
    NSError *activationError = nil;
    
    success = [session setActive:YES error:&activationError];
    
    if (!success)
        
    {
        
        /* handle the error condition */
        
        return;
        
    }
    
}
static void ASAudioSessionInterruptionListener(void *inClientData, UInt32 inInterruptionState)

{
    
    [[QXPSoundManager sharedManager] handleInterruptionChangeToState:inInterruptionState];
    
}
- (void)handleInterruptionChangeToState:(UInt32)notification

{
    
    AudioQueuePropertyID inInterruptionState=notification;
    
    
    
    if (inInterruptionState == kAudioSessionBeginInterruption)
        
    {
        
        NSLog(@"begin interruption——->");
        
        [self pause];
        
    }
    
    else if (inInterruptionState == kAudioSessionEndInterruption)
        
    {
        
        NSLog(@"end interruption——->");
        
        [self pause];

        //[self resume];
        
        
    }
    
}

//所有录音使用方法
-(void)startRecordingWihtID:(NSString *)recorderID andBlock:(void (^) (NSString *timeRemaining , NSTimeInterval currentTime))block shouldStopAtSecond:(NSTimeInterval)second{
    
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    NSString *filePath=RecorderFilePath(recorderID);
    if ([[self class] haveItemWihtID:recorderID]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    [self forceOutputToDefaultDevice];
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                     [NSNumber numberWithFloat: 8000],AVSampleRateKey, //采样率
                                     [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                     [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                                     [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
                                     [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,//大端还是小端 是内存的组织方式
                                     [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,//采样信号是整数还是浮点数
                                     [NSNumber numberWithInt: AVAudioQualityHigh],AVEncoderAudioQualityKey,//音频编码质量
                                     nil];
    //字面理解为峰值的幂，从其网络上搜索后得到上面的答案，但其结果并不是分贝，而是一个从0－1的波动值，
    //float peakPower = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
    //float averagePower = pow(10, (0.05 * [recorder averagePowerForChannel:0]));
    
    self.recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:RecorderFilePath(recorderID)] settings:settings error:nil];
    [self.recorder peakPowerForChannel:0];
    [self.recorder prepareToRecord];
    self.recorder.meteringEnabled=YES;
    
    if (second == 0 || !second) {
        [self.recorder record];
    } else {
        [self.recorder recordForDuration:second];
    }
    
    __weak __typeof(self) wself = self;
    self.recorderTimer=[NSTimer scheduledTimerWithTimeInterval:1 block:^{
        
        NSString *tempStr=[NSString timeFormatted2:wself.recorder.currentTime];
        
        if (block) {
            block(tempStr,wself.recorder.currentTime);
        }
        
    } repeats:YES];
    
}
//所有录音使用方法
-(void)startRecordingWihtID:(NSString *)recorderID recordOBJ:(id<QXPSoundRecordDelegate>)recordOBJ andBlock:(void (^) (NSString *timeRemaining , NSTimeInterval currentTime))block houldStopAtSecond:(NSTimeInterval)second{
    
    
    
    if ([self.recorder isRecording]){
        [self stopAndSaveRecording];
        [self deleteRecording];
    }
    [self stop];
    
    self.recordOBJ=recordOBJ;
    [self.recordOBJ willRecordStart];
    [self startRecordingWihtID:recorderID andBlock:block shouldStopAtSecond:second];
    
}
//所有录音使用方法
//-(void)startRecordingWihtID:(NSString *)recorderID recordOBJ:(id<QXPSoundRecordDelegate>)recordOBJ andBlock:(void (^) (NSString *timeRemaining))block houldStopAtSecond:(NSTimeInterval)second{
//    
//    
//
//    if ([self.recorder isRecording]){
//        [self stopAndSaveRecording];
//       [self deleteRecording];
//    }
//    [self stop];
//    
//    self.recordOBJ=recordOBJ;
//    [self.recordOBJ willRecordStart];
//    [self startRecordingWihtID:recorderID andBlock:block shouldStopAtSecond:second];
//    
//}
- (void)addPlayerHandler:(id)delegate type:(playerPlayType)type changedBlick:(void (^)(BOOL isPlaying))block{

    [self removePlayerHandler:delegate];
    QXPPlayerHandler *temp=[QXPPlayerHandler new];
    temp.playID=[delegate tagWithHandlerTagKey];
    temp.type=type;
    temp.handler=delegate;
    temp.changedBlock=block;
    [self.handlers setObject:temp forKey:temp.playID];
    temp=nil;
    

}
- (void)removePlayerHandler:(id)delegate{


    if ([self.handlers.allKeys containsObject:[delegate tagWithHandlerTagKey]]) {
        
        QXPPlayerHandler *temp=[self.handlers objectForKey:[delegate tagWithHandlerTagKey]];
        [temp remove];
        [self.handlers removeObjectForKey:delegate];
        temp=nil;
    }
}

-(void)startPlayingWithUrlString:(NSString *)path playingOBJ:(id<QXPSoundPlayingDelegate>)playingOBJ progressBlock:(QXPSoundProgressBlock)progressBlock finshBlock:(QXPSoundFinshBlock)finshBlock{

    if ([self.recorder isRecording]){
        [self stopAndSaveRecording];
        [self deleteRecording];
    }
    [self stop];
    
    self.playingOBJ=playingOBJ;
    [self.playingOBJ willPlayingStart];
    [self startPlayingWithUrlString:path progressBlock:progressBlock finshBlock:finshBlock];
    
}

+ (BOOL)haveItemWihtID:(NSString *)recorderID{
    
    return [[NSFileManager defaultManager] fileExistsAtPath:RecorderFilePath(recorderID)];
    
}
- (void)syncPlayPauseButtons
{
    
    
    switch ([self.hysteriaPlayer getHysteriaPlayerStatus]) {
        case HysteriaPlayerStatusUnknown:
            //mRefresh
            break;
        case HysteriaPlayerStatusForcePause:
            //[self pause];
            break;
        case HysteriaPlayerStatusBuffering:
            //playButton
            break;
        case HysteriaPlayerStatusPlaying:
            //pauseButton
            
        default:
            break;
    }
}
- (void)stop{
    
    if ([self.recorder isRecording]){
        [self stopAndSaveRecording];
        [self.recordOBJ willRecordStop];

    }

    if (self.status!=AFSoundManagerStatusFinished) {
        [self.playingOBJ willPlayingStop];

    }
    
    self.playingOBJ=nil;
    [self.playingOBJ willPlayingStop];

    [super stop];

}
- (void)pause{

    [self.playingOBJ willPlayingPause];
    [super pause];
}
-(void)resume{
    [self.playingOBJ willPlayingStart];

    [super resume];
}
@end
