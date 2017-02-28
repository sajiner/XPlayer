//
//  ZXRemotePlayer.h
//  ZXPLayer
//
//  Created by sajiner on 2017/2/6.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXRemotePlayer : NSObject

+ (instancetype)shareInstance;

- (void)playWithUrl: (NSURL *)url isCache: (BOOL)isCache;

- (void)pause;
- (void)stop;
- (void)resume;

- (void)seekWithTimeDiffer:(NSTimeInterval)timeDiffer;
- (void)seekWithProgress:(float)progress;

- (void)setRate:(float)rate;

- (void)setMuted:(BOOL)muted;

- (void)setVolume:(float)volume;

@end
