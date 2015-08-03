//
//  AudioManager.m
//  CityGuide
//
//  Created by 徐继垚 on 15/7/15.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import "AudioManager.h"


@implementation AudioManager
static AudioManager * manager = nil;
#pragma mark - manager
+ (AudioManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AudioManager alloc]init];
        NSLog(@"播放引擎开启成功");
        
        manager.AudioPlayerPlayState = 0;
    });
  
    return manager;
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AudioPlayEnd" object:nil];
    
    
}
#pragma mark - player
- (void)playWithProgress:(void (^)(float))block
{
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playEnd:) name:@"AudioPlayEnd" object:nil];

    self.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"http://lx.cdn.baidupcs.com/file/07df0a836495235cb3ccd0e3e33fc957?bkt=p2-qd-149&xcode=46e4a7382e50e365ee95ec053f0f24973678bb3669cfb00af77424e07ee197d9&fid=22269524-250528-514880789550500&time=1438493608&sign=FDTAXERLBH-DCb740ccc5511e5e8fedcff06b081203-FzALqRZuKZrpj90FO8TK6W6%2FtHE%3D&to=cb&fm=Nan,B,U,nc&sta_dx=4&sta_cs=127&sta_ft=mp3&sta_ct=5&fm2=Nanjing,B,U,nc&newver=1&newfm=1&secfm=1&flow_ver=3&sl=81789007&expires=8h&rt=sh&r=367207127&mlogid=3225560571&vuk=1211834583&vbdid=2455715783&fin=%E5%8D%81%E8%90%AC%E5%AC%89%E7%9A%AE.mp3"]];

    [self.player play];
    
    NSLog(@"开始播放");
    self.isPlay = YES;
    self.beginToPlay = YES;
    self.AudioPlayerPlayState = 1;
   

    __block float percentage = 0;

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 block:^{
        
        
        if ((CMTimeGetSeconds(_player.currentItem.duration) - CMTimeGetSeconds(_player.currentItem.currentTime)) != 0) {
            
            int currentTime = CMTimeGetSeconds(self.player.currentItem.currentTime);
            int durationTime = CMTimeGetSeconds(self.player.currentItem.duration);
            
            percentage = (float)(CMTimeGetSeconds(_player.currentItem.currentTime)/CMTimeGetSeconds(_player.currentItem.duration));
        //    int timeRemaining = CMTimeGetSeconds(_player.currentItem.duration) - CMTimeGetSeconds(_player.currentItem.currentTime);
            
        //    float value = CMTimeGetSeconds(self.player.currentItem.currentTime)/CMTimeGetSeconds(self.player.currentItem.duration);
            
            [self.delegate audioManager:manager BeginToPlayToProgress:percentage currentTime:currentTime durationTime:durationTime];
            
            if (block) {
                block(percentage);
            }
        } else {
            
       //     int timeRemaining = CMTimeGetSeconds(_player.currentItem.duration) - CMTimeGetSeconds(_player.currentItem.currentTime);
            
            if (block) {
                block(1);
            }
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"AudioPlayEnd" object:nil];
            [self.delegate audioMangaer:manager PlayIsEnd:self.player];
            
            [self.timer invalidate];
        }
//
//      block(value);
//
//
//
//    
//        
//        
//      if (currentTime == durationTime) {
//          
//          
//             }
  } repeats:YES];
    
}
- (void)playEnd:(NSNotification *)result
{
//    self.player = nil;
    self.beginToPlay = NO;
    self.AudioPlayerPlayState = 0;
        NSLog(@"播放完毕");

}
- (void)pause
{
    
    [self.player pause];
   // NSLog(@"播放暂停");
    self.isPlay = NO;
    self.AudioPlayerPlayState = AudioPlayerIsPause;
    NSLog(@"%d" , _AudioPlayerPlayState);
    [self.delegate audioMangaer:manager PlayIsPause:self.player];
}
- (void)goon
{
    [self.player play];
    //NSLog(@"继续播放");
    self.isPlay = YES;
    self.AudioPlayerPlayState = 1;
    
    [self.delegate audioMangaer:manager PlayIsGoOn:self.player];
}
- (void)changeValueWithProgress:(float)value
{
    int32_t timer = manager.player.currentItem.asset.duration.timescale;
    
    Float64 timeValue = CMTimeGetSeconds(manager.player.currentItem.duration) * value;
    [manager.player seekToTime:CMTimeMakeWithSeconds(timeValue, timer) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];

}
@end


