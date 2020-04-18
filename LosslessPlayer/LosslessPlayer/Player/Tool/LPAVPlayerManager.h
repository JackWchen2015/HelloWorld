//
//  LPAVPlayerManager.h
//  LosslessPlayer
//
//  Created by Jack Chen on 2020/4/16.
//  Copyright © 2020 JackChen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPAVPlayerManager : NSObject
+(instancetype)sharedInstance;
-(void)playMusicWithPath:(NSURL*)path;

-(void)play;
-(void)pause;
-(BOOL)isPlaying;

-(void)configNowPlayingInfoCenter;
-(void)playAtTime:(NSTimeInterval)time;
@end

NS_ASSUME_NONNULL_END
