//
//  AudioManager.h
//  CityGuide
//
//  Created by 徐继垚 on 15/7/15.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@protocol AududioDelegate;
@interface AudioManager : NSObject

@property (nonatomic ,retain)AVPlayer * player;

@property (nonatomic ,assign)BOOL beginToPlay;
@property (nonatomic ,assign)BOOL isPlay;

@property (nonatomic ,retain)NSTimer * timer;

@property (nonatomic ,assign) id <AududioDelegate>delegate;


+ (AudioManager *)sharedManager;

- (void)playWithProgress:(void(^)(float value))block;

- (void)pause;

- (void)goon;

@end
@protocol AududioDelegate <NSObject>

- (void)playIsEnd;

@end
@interface NSTimer (Blocks)

+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

@end


