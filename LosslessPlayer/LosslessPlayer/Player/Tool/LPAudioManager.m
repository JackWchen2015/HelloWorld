//
//  LPAudioManager.m
//  LosslessPlayer
//
//  Created by Jack Chen on 2020/4/18.
//  Copyright © 2020 JackChen. All rights reserved.
//

#import "LPAudioManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface LPAudioManager()<AVAudioRecorderDelegate>
@property(nonatomic,strong)AVAudioRecorder* avRecorder;
@end
@implementation LPAudioManager


+(instancetype)sharedInstance
{
    static LPAudioManager* single=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single=[LPAudioManager new];
    });
    return single;
}
-(void)recordWithPath:(NSURL*)path
{
    NSMutableDictionary* settingDic=@{}.mutableCopy;
    [settingDic setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    [settingDic setValue:@(44100) forKey:AVSampleRateKey];
    [settingDic setValue:@(2) forKey:AVNumberOfChannelsKey];
    [settingDic setValue:@(16) forKey:AVLinearPCMBitDepthKey];
    [settingDic setValue:@(AVAudioQualityHigh) forKey:AVEncoderAudioQualityKey];
     NSError *error;
    self.avRecorder=[[AVAudioRecorder alloc] initWithURL:path settings:settingDic error:&error];
    if (error) {
        NSLog(@"Audio record error:%@",error.localizedDescription);
    }
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
    self.avRecorder.delegate=self;
    [self.avRecorder prepareToRecord];
    [self.avRecorder record];
}
-(void)stropRecord
{
    [self.avRecorder stop];
}
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"record  %@ successful %d",recorder.url,flag);
}
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error
{
    if (!error) {
        NSLog(@"recording error:%@",error.localizedDescription);
    }
}
@end
