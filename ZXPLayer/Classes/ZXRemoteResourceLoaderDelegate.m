//
//  ZXRemoteResourceLoaderDelegate.m
//  ZXPLayer
//
//  Created by sajiner on 2017/2/6.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "ZXRemoteResourceLoaderDelegate.h"

@implementation ZXRemoteResourceLoaderDelegate
///   当外界需要播放一段音频资源时，会跑一个请求，给这个对象，这个对象到时候，只需要根据请求信息，抛数据给外界
- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest {
    NSLog(@"%@", loadingRequest);
    return YES;
}

/// 取消请求
- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest {
    
}

@end
