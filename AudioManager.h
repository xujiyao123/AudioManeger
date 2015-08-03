//
//  AudioManager.h
//  CityGuide
//
//  Created by 徐继垚 on 15/7/15.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "NSTimer+Block.h"

typedef NS_ENUM(int, AudioPlayerPlayState) {
    AudioPlayerIsPlaying = 1,
    AudioPlayerIsStop = 0,
    AudioPlayerIsPause = 2,
    AudioPlayerIsGoOn = 3,
};


@protocol AududioDelegate;
@interface AudioManager : NSObject

@property (nonatomic ,retain)AVPlayer * player;

@property (nonatomic ,assign)BOOL beginToPlay;
@property (nonatomic ,assign)int AudioPlayerPlayState;

@property (nonatomic ,assign)BOOL isPlay;

@property (nonatomic ,retain)NSTimer * timer;

@property (nonatomic ,assign) id <AududioDelegate>delegate;


+ (AudioManager *)sharedManager;

- (void)playWithProgress:(void(^)(float value))block;

- (void)pause;

- (void)goon;

- (void)changeValueWithProgress:(float)value;

@end
@protocol AududioDelegate <NSObject>


@optional

- (void)audioManager:(AudioManager *)manager BeginToPlayToProgress:(float)progress currentTime:(int)currentTime durationTime:(int)durationTime;

- (void)audioMangaer:(AudioManager *)manager PlayIsEnd:(AVPlayer *)player;

- (void)audioMangaer:(AudioManager *)manager PlayIsPause:(AVPlayer *)player;

- (void)audioMangaer:(AudioManager *)manager PlayIsGoOn:(AVPlayer *)player;

@end



