//
//  TCTCountdownTimer.h
//  TCTTimer
//
//  Created by Tracy-One on 15/6/25.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCTTimer.h"

@interface TCTCountdownTimer : NSObject<TCTTimer>

- (instancetype)initWithAccuracy:(TCTTimerAccuracy)accuracy  NS_DESIGNATED_INITIALIZER;
+ (instancetype)countdownTimerWithAccuracy:(TCTTimerAccuracy)accuracy timeInterval:(NSTimeInterval)timeInterval;

@property (nonatomic, weak) id<TCTTimerDelegate>delegate;

@property (nonatomic, assign) NSTimeInterval timeInterval;


@end
