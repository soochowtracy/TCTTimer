//
//  TCTTimerEngine.h
//  TCTTimer
//
//  Created by Tracy-One on 15/6/25.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCTTimerEngine : NSObject

- (instancetype)initWithAccuracy:(double)accuracy target:(id)target selector:(SEL)selector NS_DESIGNATED_INITIALIZER;

- (void)start;

- (void)stop;

@end
