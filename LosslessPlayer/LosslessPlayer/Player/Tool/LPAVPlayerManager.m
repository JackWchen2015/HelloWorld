//
//  LPAVPlayerManager.m
//  LosslessPlayer
//
//  Created by Jack Chen on 2020/4/16.
//  Copyright © 2020 JackChen. All rights reserved.
//

#import "LPAVPlayerManager.h"
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>
#import <MediaPlayer/MediaPlayer.h>
@interface LPAVPlayerManager()
@property(nonatomic,strong)AVPlayer* avPlay;
@property(nonatomic,strong)AVPlayerItem* avPlayItem;

@end
@implementation LPAVPlayerManager
+(instancetype)sharedInstance
{
    static LPAVPlayerManager* single;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single=[LPAVPlayerManager new];
    });
    return single;
}
-(void)playMusicWithPath:(NSURL*)path
{
    self.avPlayItem=[[AVPlayerItem alloc] initWithURL:path];
    self.avPlay=[AVPlayer playerWithPlayerItem:self.avPlayItem];
    [self.avPlay play];
    
    
    NSLog(@"error :%@",self.avPlay.error);
    NSLog(@"play status:%ld",self.avPlay.status);
}

-(void)play
{
    [self.avPlay play];
}

-(void)pause
{
    [self.avPlay pause];
}
-(BOOL)isPlaying
{
    return self.avPlay.rate>=1;
}
-(void)configNowPlayingInfoCenter
{
    Class playingInfoCenter=NSClassFromString(@"MPNowPlayingInfoCenter");
    
    if (playingInfoCenter) {
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        //歌曲名称
        [songInfo setObject:@"阿婆说" forKey:MPMediaItemPropertyTitle];
        //演唱者
        [songInfo setObject:@"陈一发" forKey:MPMediaItemPropertyArtist];
        //专辑名
        [songInfo setObject:@"专辑名" forKey:MPMediaItemPropertyAlbumTitle];
        //专辑缩略图
//      [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
        //音乐当前已经播放时间
        [songInfo setObject:[NSNumber numberWithDouble:[self getCurTime]] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        //进度光标的速度 （这个随 自己的播放速率调整，我默认是原速播放）
        [songInfo setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];
        //歌曲总时间设置
        [songInfo setObject:[NSNumber numberWithDouble:[self getDuration]] forKey:MPMediaItemPropertyPlaybackDuration];
        //设置锁屏状态下屏幕显示音乐信息
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
    }
}
-(void)playAtTime:(NSTimeInterval)time{
    [self.avPlay pause];
    [self.avPlay seekToTime:CMTimeMakeWithSeconds(time, self.avPlay.currentTime.timescale) completionHandler:^(BOOL finished) {
        [self.avPlay play];
    }];
}

-(CGFloat)getCurTime
{
    return CMTimeGetSeconds(self.avPlay.currentTime);
}
-(CGFloat)getDuration
{
    return CMTimeGetSeconds(self.avPlayItem.duration);
}
@end
