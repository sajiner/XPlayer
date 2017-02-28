//
//  NSURL+ZXExtension.m
//  ZXPLayer
//
//  Created by sajiner on 2017/2/14.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "NSURL+ZXExtension.h"

@implementation NSURL (ZXExtension)

- (NSURL *)steamingURL {
    NSURLComponents *components = [NSURLComponents componentsWithString:self.absoluteString];
    components.scheme = @"sreaming";
    return components.URL;
}

@end
