//
//  NSTimer+Block.h
//  CityGuide
//
//  Created by 徐继垚 on 15/7/30.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Block)
+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;


@end
