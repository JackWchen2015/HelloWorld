//
//  LPAudioManager.h
//  LosslessPlayer
//
//  Created by Jack Chen on 2020/4/18.
//  Copyright © 2020 JackChen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LPAudioManager : NSObject

+(instancetype)sharedInstance;
-(void)recordWithPath:(NSURL*)path;

-(void)stropRecord;
@end

NS_ASSUME_NONNULL_END
