//
//  AFSoundManager.m
//  AFSoundManager-Demo
//
//  Created by Alvaro Franco on 4/16/14.
//  Copyright (c) 2014 AlvaroFranco. All rights reserved.
//

#import "AFSoundManager.h"

@interface AFSoundManager ()

@end


@implementation AFSoundManager


+(instancetype)sharedManager {
    
    static AFSoundManager *soundManager = nil;
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
        
        

    });
    
    
    return soundManager;
}

#pragma HysteriaPlayerDelegate
- (void)hysteriaPlayerDidReachEnd{
    
    [self stop];
}
- (void)hysteriaPlayerRateChanged:(BOOL)isPlaying
{
    [self syncPlayPauseButtons];


}
- (void)syncPlayPauseButtons
{
  
    
    switch ([self.hysteriaPlayer getHysteriaPlayerStatus]) {
        case HysteriaPlayerStatusUnknown:
            //mRefresh
            break;
        case HysteriaPlayerStatusForcePause:
            break;
        case HysteriaPlayerStatusBuffering:
            //playButton
            break;
        case HysteriaPlayerStatusPlaying:
            //pauseButton
        
        default:
            break;
    }
    [self refreshBcakInfo];
}


- (void)setStatus:(AFSoundManagerStatus)status{

    _status=status;

}

- (void)configNowPlayingInfoCenter {
    
}
//NSDictionary *albumDic=@{@"name":@"11111",
//@"singer":@"22222",
//@"album":@"33333"
//设置背景信息
- (void)showBcakInfo:(NSString *)name singer:(NSString *)singer album:(NSString *)album image:(UIImage *)iamge{

    
    QXPDispatch_after(0.5, ^{
        if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
            
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
            
            [dict setObject:name forKey:MPMediaItemPropertyTitle];
            
            if (singer) {
                [dict setObject:singer forKey:MPMediaItemPropertyArtist];
                
            }
            
            if (album) {
                [dict setObject:album forKey:MPMediaItemPropertyAlbumTitle];

            }
            
            [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(self.hysteriaPlayer.getCurrentItem.duration)] forKey:MPMediaItemPropertyPlaybackDuration];//歌曲总时间设置
            
            
            [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(self.hysteriaPlayer.getCurrentItem.currentTime)] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; //音乐当前已经播放时间
            [dict setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];//进度光标的速度 （这个随 自己的播放速率调整，我默认是原速播放）
            
            MPMediaItemArtwork * mArt = [[MPMediaItemArtwork alloc] initWithImage:iamge];
            
            [dict setObject:mArt forKey:MPMediaItemPropertyArtwork];
            
            [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
        }
    });
}

- (void)refreshBcakInfo{
            [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nil;
            
    //更新播放时间
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[[MPNowPlayingInfoCenter defaultCenter] nowPlayingInfo]];
    
    
    
    
    [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(self.hysteriaPlayer.getCurrentItem.duration)] forKey:MPMediaItemPropertyPlaybackDuration];//歌曲总时间设置
    
    [dict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(self.hysteriaPlayer.getCurrentItem.currentTime)] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; //音乐当前已经播放时间
    [dict setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];//进度光标的速度 （这个随 自己的播放速率调整，我默认是原速播放）
    
    
    
    
    MPMediaItemArtwork * mArt = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"screensaver.png"]];
    [dict setObject:mArt forKey:MPMediaItemPropertyArtwork];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    
}

//Make sure we can recieve remote control events

- (BOOL)canBecomeFirstResponder {
    
    return YES;
    
}
-(void)startPlayingLocalFileWithName:(NSString *)name atPath:(NSString *)path withCompletionBlock:(progressBlock)block {
    
    /*
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    NSString *defaultPath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], name];
    NSURL *fileURL = [NSURL fileURLWithPath:defaultPath];

    if (path) {
        
        fileURL = [NSURL fileURLWithPath:path];
    }
    
    NSError *error = nil;
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:fileURL options:NSDataReadingMappedIfSafe error:nil];

    _audioPlayer = [[AVAudioPlayer alloc]initWithData:data error:&error];
    [_audioPlayer play];
    
    _type = AFSoundManagerTypeLocal;
    _status = AFSoundManagerStatusPlaying;
    [_delegate currentPlayingStatusChanged:AFSoundManagerStatusPlaying];
    
    __block int percentage = 0;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^{
        
        if ((_audioPlayer.duration - _audioPlayer.currentTime) >= 1) {
            
            percentage = (int)((_audioPlayer.currentTime * 100)/_audioPlayer.duration);
            int timeRemaining = _audioPlayer.duration - _audioPlayer.currentTime;

            if (block) {
                block(percentage, _audioPlayer.currentTime, timeRemaining, error, NO);
            }
        } else {
            
            int timeRemaining = _audioPlayer.duration - _audioPlayer.currentTime;

            if (block) {
                block(100, _audioPlayer.currentTime, timeRemaining, error, YES);
            }
            [_timer invalidate];
            _status = AFSoundManagerStatusFinished;
            [_delegate currentPlayingStatusChanged:AFSoundManagerStatusFinished];
        }
    } repeats:YES];
    */
}

-(void)startStreamingRemoteAudioFromURL:(NSString *)url andBlock:(progressBlock)block {
    
    /*
    NSURL *streamingURL = [NSURL URLWithString:url];
    NSError *error = nil;
    
    _player = [[AVPlayer alloc]initWithURL:streamingURL];
    [_player play];
    
    _type = AFSoundManagerTypeRemote;
    _status = AFSoundManagerStatusPlaying;
    [_delegate currentPlayingStatusChanged:AFSoundManagerStatusPlaying];
    
    if (!error) {
    
        __block int percentage = 0;
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^{
            
            if ((CMTimeGetSeconds(_player.currentItem.duration) - CMTimeGetSeconds(_player.currentItem.currentTime)) != 0) {
                
                percentage = (int)((CMTimeGetSeconds(_player.currentItem.currentTime) * 100)/CMTimeGetSeconds(_player.currentItem.duration));
                int timeRemaining = CMTimeGetSeconds(_player.currentItem.duration) - CMTimeGetSeconds(_player.currentItem.currentTime);
                                
                if (block) {
                    block(percentage, CMTimeGetSeconds(_player.currentItem.currentTime), timeRemaining, error, NO);
                }
            } else {
                
                int timeRemaining = CMTimeGetSeconds(_player.currentItem.duration) - CMTimeGetSeconds(_player.currentItem.currentTime);

                if (block) {
                    block(100, CMTimeGetSeconds(_player.currentItem.currentTime), timeRemaining, error, YES);
                }

                [_timer invalidate];
                _status = AFSoundManagerStatusFinished;
                [_delegate currentPlayingStatusChanged:AFSoundManagerStatusFinished];
            }
        } repeats:YES];
    } else {

        if (block) {
            block(0, 0, 0, error, YES);
        }
        [_audioPlayer stop];
    }
     */
}

-(NSDictionary *)retrieveInfoForCurrentPlaying {
    
    /*
    if (_audioPlayer.url) {
        
        NSArray *parts = [_audioPlayer.url.absoluteString componentsSeparatedByString:@"/"];
        NSString *filename = [parts objectAtIndex:[parts count]-1];
        
        NSDictionary *info = @{@"name": filename, @"duration": [NSNumber numberWithInt:_audioPlayer.duration], @"elapsed time": [NSNumber numberWithInt:_audioPlayer.currentTime], @"remaining time": [NSNumber numberWithInt:(_audioPlayer.duration - _audioPlayer.currentTime)], @"volume": [NSNumber numberWithFloat:_audioPlayer.volume]};
        
        return info;
    } else {
        return nil;
    }
     */
    return nil;
}

//暂停
-(void)pause {
//    [_audioPlayer pause];
//    [_player pause];
    
    
    if ([self.hysteriaPlayer isPlaying])
    {}
        [self.hysteriaPlayer pausePlayerForcibly:YES];
        [self.hysteriaPlayer pause];
    
    
    [_timer pauseTimer];
    _status = AFSoundManagerStatusPaused;
    [_delegate currentPlayingStatusChanged:AFSoundManagerStatusPaused];
}
//继续播放
-(void)resume {
//    [_audioPlayer play];
//    [_player play];
    
    [self.hysteriaPlayer pausePlayerForcibly:NO];
    [self.hysteriaPlayer play];
    
    
    //更新播放时间
    [self refreshBcakInfo];
    
    
    

    [_timer resumeTimer];
    _status = AFSoundManagerStatusPlaying;
    [_delegate currentPlayingStatusChanged:AFSoundManagerStatusPlaying];
}

-(void)stop {
//    [_audioPlayer stop];
//    _player = nil;
    

    if ([self.hysteriaPlayer isPlaying])
    {
        
        [self.hysteriaPlayer removeQueuesAtPlayer];
        [self.hysteriaPlayer pausePlayerForcibly:YES];
        [self.hysteriaPlayer pause];
    }
    
    
    [_timer pauseTimer];
    _status = AFSoundManagerStatusStopped;
    [_delegate currentPlayingStatusChanged:AFSoundManagerStatusStopped];
    _type = AFSoundManagerTypeNone;
}

-(void)restart {
    
    [self.hysteriaPlayer seekToTime:0];
//    [_audioPlayer setCurrentTime:0];
//    
//    int32_t timeScale = _player.currentItem.asset.duration.timescale;
//    [_player seekToTime:CMTimeMake(0.000000, timeScale)];
    
    //[self.hysteriaPlayer seekToTime:CMTimeMake(0.000000, timeScale)];
    
    _status = AFSoundManagerStatusRestarted;
    [_delegate currentPlayingStatusChanged:AFSoundManagerStatusRestarted];
}

-(void)moveToSecond:(int)second {
//    [_audioPlayer setCurrentTime:second];
//    
//    int32_t timeScale = _player.currentItem.asset.duration.timescale;
//    [_player seekToTime:CMTimeMakeWithSeconds((Float64)second, timeScale) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    
    
    [self.hysteriaPlayer seekToTime:second];

}

-(void)moveToSection:(CGFloat)section {
//    int audioPlayerSection = _audioPlayer.duration * section;
//    [_audioPlayer setCurrentTime:audioPlayerSection];
//    
//    int32_t timeScale = _player.currentItem.asset.duration.timescale;
//    Float64 playerSection = CMTimeGetSeconds(_player.currentItem.duration) * section;
//    [_player seekToTime:CMTimeMakeWithSeconds(playerSection, timeScale) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];

    
    double allTime=CMTimeGetSeconds(self.hysteriaPlayer.getCurrentItem.duration);
    [self.hysteriaPlayer seekToTime:allTime*section];

}

-(void)changeSpeedToRate:(CGFloat)rate {
//    _audioPlayer.rate = rate;
//    _player.rate = rate;
}

-(void)changeVolumeToValue:(CGFloat)volume {
//    _audioPlayer.volume = volume;
//    _player.volume = volume;
}

-(void)startRecordingAudioWithFileName:(NSString *)name andExtension:(NSString *)extension shouldStopAtSecond:(NSTimeInterval)second {
    
    _recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.%@", [NSHomeDirectory() stringByAppendingString:@"/Documents"], name, extension]] settings:nil error:nil];
    
    if (second == 0 && !second) {
        [_recorder record];
    } else {
        [_recorder recordForDuration:second];
    }
}

-(void)pauseRecording {
    
    if ([_recorder isRecording]) {
        [_recorder pause];
        [self.recorderTimer pauseTimer];

    }
}

-(void)resumeRecording {
    
    if (![_recorder isRecording]) {
        [_recorder record];
        [self.recorderTimer pauseTimer];

    }
}

-(void)stopAndSaveRecording {
    [_recorder stop];
    [self.recorderTimer pauseTimer];
}

-(void)deleteRecording {
    [_recorder deleteRecording];
    [self.recorderTimer pauseTimer];

}

-(NSInteger)timeRecorded {
    return [_recorder currentTime];
}

-(void)currentPlayingStatusChanged:(AFSoundManagerStatus)status {
    status = (AFSoundManagerStatus)_status;
    NSLog(@"wut");
}

-(BOOL)status:(AFSoundManagerStatus)status {
    
    if (status == _status) {
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)areHeadphonesConnected {
    
    AVAudioSessionRouteDescription *route = [[AVAudioSession sharedInstance]currentRoute];
        
    BOOL headphonesLocated = NO;
    
    for (AVAudioSessionPortDescription *portDescription in route.outputs) {
        
        headphonesLocated |= ([portDescription.portType isEqualToString:AVAudioSessionPortHeadphones]);
    }
    
    return headphonesLocated;
}

-(void)forceOutputToDefaultDevice {
    
    [AFAudioRouter initAudioSessionRouting];
    [AFAudioRouter switchToDefaultHardware];
}

-(void)forceOutputToBuiltInSpeakers {
    
    [AFAudioRouter initAudioSessionRouting];
    [AFAudioRouter forceOutputToBuiltInSpeakers];
}

@end

@implementation NSTimer (Blocks)

+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats {
    
    void (^block)() = [inBlock copy];
    id ret = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(executeSimpleBlock:) userInfo:block repeats:inRepeats];
    
    return ret;
}

+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats {
    
    void (^block)() = [inBlock copy];
    id ret = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(executeSimpleBlock:) userInfo:block repeats:inRepeats];
    
    return ret;
}

+(void)executeSimpleBlock:(NSTimer *)inTimer {
    
    if ([inTimer userInfo]) {
        void (^block)() = (void (^)())[inTimer userInfo];
        block();
    }
}

@end

@implementation NSTimer (Control)

static NSString *const NSTimerPauseDate = @"NSTimerPauseDate";
static NSString *const NSTimerPreviousFireDate = @"NSTimerPreviousFireDate";

-(void)pauseTimer {
    
    objc_setAssociatedObject(self, (__bridge const void *)(NSTimerPauseDate), [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void *)(NSTimerPreviousFireDate), self.fireDate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.fireDate = [NSDate distantFuture];
}

-(void)resumeTimer {
    
    NSDate *pauseDate = objc_getAssociatedObject(self, (__bridge const void *)NSTimerPauseDate);
    NSDate *previousFireDate = objc_getAssociatedObject(self, (__bridge const void *)NSTimerPreviousFireDate);
    
    const NSTimeInterval pauseTime = -[pauseDate timeIntervalSinceNow];
    self.fireDate = [NSDate dateWithTimeInterval:pauseTime sinceDate:previousFireDate];
}

@end
