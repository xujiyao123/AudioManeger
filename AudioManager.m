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
+ (AudioManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AudioManager alloc]init];
        NSLog(@"播放引擎开启成功");
    });
  
    return manager;
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AudioPlayEnd" object:nil];
    
    
}
- (void)playWithProgress:(void (^)(float))block
{
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playEnd:) name:@"AudioPlayEnd" object:nil];

            self.player = [[AVPlayer alloc]initWithURL:[NSURL URLWithString:@"http://www.dyedu.cn/UserFiles/Blog/jmxixi/UploadFiles/2011071902061296.mp3"]];

    [self.player play];
    NSLog(@"开始播放");
    self.isPlay = YES;
    self.beginToPlay = YES;
  self.timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^{
      float value = CMTimeGetSeconds(manager.player.currentItem.currentTime)/CMTimeGetSeconds(manager.player.currentItem.duration);
      block(value);
      int currentTime = CMTimeGetSeconds(manager.player.currentItem.currentTime);
      int durationTime = CMTimeGetSeconds(manager.player.currentItem.duration);
      if (currentTime == durationTime) {
          
          
          [[NSNotificationCenter defaultCenter]postNotificationName:@"AudioPlayEnd" object:nil];
          
          
        //  [self.delegate playIsEnd];
          
          
         [self.delegate performSelector:@selector(playIsEnd) withObject:nil];
          
          [self.timer invalidate];
      }
  } repeats:YES];
    
}
- (void)playEnd:(NSNotification *)result
{
//    self.player = nil;
    self.beginToPlay = NO;
    NSLog(@"播放完毕");

}
- (void)pause
{
    [self.player pause];
    NSLog(@"播放暂停");
    self.isPlay = NO;
}
- (void)goon
{
    [self.player play];
    NSLog(@"继续播放");
    self.isPlay = YES;
}
@end
@implementation NSTimer (Blocks)
+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats {
    
    void (^block)() = [inBlock copy];
    id ret = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(executeSimpleBlock:) userInfo:block repeats:inRepeats];
    
    return ret;
}
+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats {
    
    void (^block)() = [inBlock copy];
    id ret = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(executeSimpleBlock:) userInfo:block repeats:inRepeats];
    
    return ret;
}
+(void)executeSimpleBlock:(NSTimer *)inTimer {
    
    if ([inTimer userInfo]) {
        void (^block)() = (void (^)())[inTimer userInfo];
        block();
    }
}

@end

