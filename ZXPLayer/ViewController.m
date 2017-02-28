//
//  ViewController.m
//  ZXPLayer
//
//  Created by sajiner on 2017/2/6.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "ViewController.h"
#import "ZXRemotePlayer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *text;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)play:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"http://audio.xmcdn.com/group23/M04/63/C5/wKgJNFg2qdLCziiYAGQxcTOSBEw402.m4a"];
    [[ZXRemotePlayer shareInstance] playWithUrl:url isCache:YES];
}

- (IBAction)pause:(UIButton *)sender {
    [[ZXRemotePlayer shareInstance] pause];
}

- (IBAction)stop:(UIButton *)sender {
    [[ZXRemotePlayer shareInstance] stop];
}

- (IBAction)resume:(UIButton *)sender {
    [[ZXRemotePlayer shareInstance] resume];
}

- (IBAction)kuaiJin:(UIButton *)sender {
    [[ZXRemotePlayer shareInstance] seekWithTimeDiffer:4];
}

- (IBAction)rate:(UIButton *)sender {
    [[ZXRemotePlayer shareInstance] setRate:2];
}

- (IBAction)muted:(UIButton *)sender {
    sender.selected = !sender.selected;
    [[ZXRemotePlayer shareInstance] setMuted:sender.selected];
}

- (IBAction)progress:(UISlider *)sender {
    [[ZXRemotePlayer shareInstance] seekWithProgress:sender.value];
}

- (IBAction)volume:(UISlider *)sender {
    [[ZXRemotePlayer shareInstance] setVolume:sender.value];
}
@end
