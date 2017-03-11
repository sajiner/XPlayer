//
//  ZXRemotePlayer.m
//  ZXPLayer
//
//  Created by sajiner on 2017/2/6.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "ZXRemotePlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "ZXRemoteResourceLoaderDelegate.h"
#import "NSURL+ZXExtension.h"

@interface ZXRemotePlayer ()

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, strong) ZXRemoteResourceLoaderDelegate *resourceLoaderDelegate;

@property (nonatomic, strong, readonly) NSURL *url;

@end

@implementation ZXRemotePlayer

#pragma mark - 单例
static ZXRemotePlayer *_instance;
+ (instancetype)shareInstance {
    if (!_instance) {
        _instance = [[ZXRemotePlayer alloc] init];
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [super allocWithZone:zone];
        });
    }
    return _instance;
}

#pragma mark - 播放的一些方法
- (void)playWithUrl:(NSURL *)url isCache:(BOOL)isCache {
    // 创建一个播放器对象
    // 如果我们使用这样的方法, 去播放远程音频
    // 这个方法, 已经帮我们封装了三个步骤
    // 1. 资源的请求
    // 2. 资源的组织
    // 3. 给播放器, 资源的播放
    // 如果资源加载比较慢, 有可能, 会造成调用了play方法, 但是当前并没有播放音频
    
    _url = url;
    if (isCache) {
        url = [url steamingURL];
    }
    // 1. 资源的请求
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    // 关于网络音频的请求, 是通过这个对象, 调用代理的相关方法, 进行加载的
    // 拦截加载的请求, 只需要, 重新修改它的代理方法就可以
    self.resourceLoaderDelegate = [ZXRemoteResourceLoaderDelegate new];
    [asset.resourceLoader setDelegate:self.resourceLoaderDelegate queue:dispatch_get_main_queue()];
    // 2. 资源的组织
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    // 当资源的组织者, 告诉我们资源准备好了之后, 我们再播放
    // AVPlayerItemStatus status
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    // 3. 资源的播放
    self.player = [AVPlayer playerWithPlayerItem:item];

}

- (void)pause {
    [self.player pause];
}

- (void)stop {
    [self.player pause];
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    self.player = nil;

}

- (void)resume {
    [self.player play];
}

- (void)seekWithProgress:(float)progress {
    ///  当前音频资源的总时长
    CMTime totalTime = self.player.currentItem.duration;
    NSTimeInterval totalTimeSec = CMTimeGetSeconds(totalTime);
    
    /// 要跳到的时长
    NSTimeInterval seekSec = totalTimeSec * progress;
    CMTime seekTime = CMTimeMake(seekSec, 1);
    
    [self.player seekToTime:seekTime completionHandler:^(BOOL finished) {
        if (finished) {
            NSLog(@"确定加载这个时间点的音频资源");
        } else {
            NSLog(@"取消加载这个时间点的音频资源");
        }
    }];
}

- (void)seekWithTimeDiffer:(NSTimeInterval)timeDiffer {
    ///  当前音频资源的总时长
    CMTime totalTime = self.player.currentItem.duration;
    NSTimeInterval totalTimeSec = CMTimeGetSeconds(totalTime);
    /// 当前音频，已经播放的时长
    CMTime playedTime = self.player.currentItem.currentTime;
    NSTimeInterval playedTimeSec = CMTimeGetSeconds(playedTime);
    playedTimeSec += timeDiffer;
    [self seekWithProgress:playedTimeSec / totalTimeSec];
}

- (void)setRate:(float)rate {
    [self.player setRate:rate];
}

- (void)setMuted:(BOOL)muted {
    self.player.muted = muted;
}

- (void)setVolume:(float)volume {
    if (volume < 0 || volume > 1) {
        return;
    }
    if (volume > 0) {
        [self setMuted:NO];
    }
    self.player.volume = volume;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        NSLog(@"status === %ld", (long)status);
        if (status == AVPlayerItemStatusReadyToPlay) {
            [self.player play];
        } else {
            
        }
    }
}

@end
