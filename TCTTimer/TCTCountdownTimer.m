//
//  TCTCountdownTimer.m
//  TCTTimer
//
//  Created by Tracy-One on 15/6/25.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import "TCTCountdownTimer.h"
#import "TCTTimerEngine.h"
#import "TCTTimerRefreshData.h"

static inline double TCT_TimeIntervalFromAccuracy(TCTTimerAccuracy accuracy){
    switch (accuracy) {
        case TCTTimerAccuracyNormal:
            return 1;
            break;
        case TCTTimerAccuracyHigh:
            return 0.1;
            break;
        case TCTTimerAccuracyHighest:
            return 0.01;
            break;
        default:
            return 1;
            break;
    }
}

@interface TCTCountdownTimer ()

@property (nonatomic, strong) TCTTimerEngine *engine;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *pauseDate;

@property (nonatomic, strong) NSDate *referenceDate;
@property (nonatomic, strong) NSDate *presentDate;
@end

@implementation TCTCountdownTimer{
    BOOL _isCounting;
    
    struct {
        BOOL countdownTimeInterval : 1;
        BOOL didFinishCountWithTimer : 1;
    }_delegateHas;
}

#pragma mark - life circle

- (instancetype)initWithAccuracy:(TCTTimerAccuracy)accuracy{
    if (self = [super init]) {
        self.engine = [[TCTTimerEngine alloc] initWithAccuracy:TCT_TimeIntervalFromAccuracy(accuracy) target:self selector:@selector(timeRefresh)];
    }
    
    return self;
}

+ (instancetype)countdownTimerWithAccuracy:(TCTTimerAccuracy)accuracy timeInterval:(NSTimeInterval)timeInterval{
    TCTCountdownTimer * timer = [[TCTCountdownTimer alloc] initWithAccuracy:accuracy];
    timer.timeInterval = timeInterval;
    return timer;
}

#pragma mark - TCTTimer protocol
- (void)start{
    
    if (!self.startDate) {
        self.startDate = [NSDate date];
    }
    
    if (self.pauseDate) {
        NSTimeInterval timeIntervalBetweenPauseAndStart = [self.pauseDate timeIntervalSinceDate:self.startDate];
        self.startDate = [[NSDate date] dateByAddingTimeInterval:-timeIntervalBetweenPauseAndStart];
        self.pauseDate = nil;
    }
    
    _isCounting = YES;
    [self.engine start];
}

- (void)pause{
    if (_isCounting) {
        self.pauseDate = [NSDate date];
        _isCounting = NO;
        [self.engine stop];
    }
}

- (void)reset{
    self.pauseDate = nil;
    self.startDate = _isCounting ? [NSDate date] : nil;
    [self timeRefresh];
}

#pragma mark - private
- (NSTimeInterval)getTimeCounted
{
    if(!self.startDate){
        return 0;
    }
    
    NSTimeInterval countedTime = [[NSDate date] timeIntervalSinceDate:self.startDate];
    
    if(self.pauseDate != nil){
        NSTimeInterval pauseCountedTime = [[NSDate date] timeIntervalSinceDate:self.pauseDate];
        countedTime -= pauseCountedTime;
    }
    return countedTime;
}

- (NSTimeInterval)getTimeRemaining {
    
    return self.timeInterval - [self getTimeCounted];
}

- (void)timeRefresh{
    NSTimeInterval pastTimeInterval = [[NSDate date] timeIntervalSinceDate:self.startDate] ;
    
    if (!self.startDate) {
        pastTimeInterval = 0;
    }
    
    NSTimeInterval remainTimeInterval = self.timeInterval - pastTimeInterval;
    if (_isCounting && remainTimeInterval <= 0) {
        [self pause];
        self.startDate = nil;
        self.pauseDate = nil;
        if (_delegateHas.didFinishCountWithTimer) {
            [_delegate didFinishCountWithTimer:self];
        }
        return;
    }
    
    self.presentDate = [self.referenceDate dateByAddingTimeInterval:remainTimeInterval];

    TCTTimerRefreshData *refreshData = [TCTTimerRefreshData refreshDataWithDate:self.presentDate timeInterval:remainTimeInterval];
    
    if (_delegateHas.countdownTimeInterval) {
        [_delegate timer:self timeInterval:remainTimeInterval refreshWithData:refreshData];
    }
    
}

#pragma mark - accessor

- (void)setDelegate:(id<TCTTimerDelegate>)delegate{
    _delegate = delegate;
    
    _delegateHas.countdownTimeInterval = [_delegate respondsToSelector:@selector(timer:timeInterval:refreshWithData:)];
    _delegateHas.didFinishCountWithTimer = [_delegate respondsToSelector:@selector(didFinishCountWithTimer:)];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval{
    _timeInterval = timeInterval;
    [self reset];
}

- (NSDate *)referenceDate{
    if (!_referenceDate) {
        _referenceDate = [NSDate dateWithTimeIntervalSince1970:0];
    }
    return _referenceDate;
}

- (NSDate *)presentDate{
    if (!_presentDate) {
        _presentDate = [NSDate date];
    }
    
    return _presentDate;
}
@end
