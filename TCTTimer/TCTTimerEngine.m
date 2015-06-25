//
//  TCTTimerEngine.m
//  TCTTimer
//
//  Created by Tracy-One on 15/6/25.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import "TCTTimerEngine.h"

@interface TCTTimerEngine ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) double accuracy;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@end

@implementation TCTTimerEngine

#pragma mark - life circle
- (instancetype)initWithAccuracy:(double)accuracy target:(id)target selector:(SEL)selector{
    if (self = [super init]) {
        self.accuracy = accuracy;
        self.target = target;
        self.selector = selector;
    }
    
    return self;
}

#pragma mark - public

- (void)start{
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.timer = [NSTimer timerWithTimeInterval:self.accuracy target:self.target selector:self.selector userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [self.timer fire];
}

- (void)stop{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
