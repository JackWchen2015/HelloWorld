//
//  AppDelegate.m
//  LosslessPlayer
//
//  Created by Jack Chen on 2020/4/14.
//  Copyright © 2020 JackChen. All rights reserved.
//

#import "AppDelegate.h"
#import "LPAVPlayerManager.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface AppDelegate ()
{
    UIBackgroundTaskIdentifier bgTaskIdentifier;
}
@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interruptionNotificationHandler:) name:AVAudioSessionInterruptionNotification object:nil];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    AVAudioSession* session=[AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [application beginReceivingRemoteControlEvents];
    [self remoteControlEventHandler];
    
    [[LPAVPlayerManager sharedInstance] configNowPlayingInfoCenter];
}

- (void)beginTask
{
    bgTaskIdentifier= [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        //如果在系统规定时间3分钟内任务还没有完成，在时间到之前会调用到这个方法
        [self endBack];
    }];
}
//结束后台运行，让app挂起
- (void)endBack
{
    //切记endBackgroundTask要和beginBackgroundTaskWithExpirationHandler成对出现
    [[UIApplication sharedApplication] endBackgroundTask:bgTaskIdentifier];
    bgTaskIdentifier = UIBackgroundTaskInvalid;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self beginTask];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [application endReceivingRemoteControlEvents];
}
//中断处理
- (void)interruptionNotificationHandler:(NSNotification*)notification
{
    NSDictionary *interuptionDict = notification.userInfo;
    NSString *type = [NSString stringWithFormat:@"%@", [interuptionDict valueForKey:AVAudioSessionInterruptionTypeKey]];
    NSUInteger interuptionType = [type integerValue];
    
    BOOL isPlaying=[[LPAVPlayerManager sharedInstance] isPlaying];
    if (interuptionType == AVAudioSessionInterruptionTypeBegan) {
        //获取中断前音乐是否在播放
        NSLog(@"AVAudioSessionInterruptionTypeBegan");
        if(isPlaying)
        {
            //停止播放的事件
            [[LPAVPlayerManager sharedInstance] pause];
            isPlaying=NO;
        }
    }else if (interuptionType == AVAudioSessionInterruptionTypeEnded) {
        NSLog(@"AVAudioSessionInterruptionTypeEnded");
        
        if (!isPlaying) {
            [[LPAVPlayerManager sharedInstance] play];
        }
    }
}
- (void)remoteControlEventHandler
{
    MPRemoteCommandCenter* remoteCmd=[MPRemoteCommandCenter sharedCommandCenter];
    remoteCmd.playCommand.enabled = YES;
    [remoteCmd.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [[LPAVPlayerManager sharedInstance] play];
        [[LPAVPlayerManager sharedInstance] configNowPlayingInfoCenter];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    [remoteCmd.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        [[LPAVPlayerManager sharedInstance] pause];
        [[LPAVPlayerManager sharedInstance] configNowPlayingInfoCenter];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    if (@available(iOS 9.1,*)) {
        remoteCmd.changePlaybackPositionCommand.enabled=YES;
        [remoteCmd.changePlaybackPositionCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
            MPChangePlaybackPositionCommandEvent* eventNew=(MPChangePlaybackPositionCommandEvent*)event;
            [[LPAVPlayerManager sharedInstance] playAtTime:eventNew.positionTime];
            return MPRemoteCommandHandlerStatusSuccess;
        }];
    }
}
@end
