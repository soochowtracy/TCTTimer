//
//  TCTTimer.h
//  TCTTimer
//
//  Created by Tracy-One on 15/6/25.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TCTTimerRefreshData, TCTTimer;

typedef  void(^TCTTimerRefreshDataCallBack)(NSTimeInterval timeInterval, id<TCTTimerRefreshData> data);

typedef NS_ENUM(NSUInteger, TCTTimerAccuracy) {
    TCTTimerAccuracyNormal      =0,
    TCTTimerAccuracyHigh,
    TCTTimerAccuracyHighest
};

@protocol TCTTimerDelegate <NSObject>

@optional
- (void)timer:(id<TCTTimer>)timer timeInterval:(NSTimeInterval)timeInterval refreshWithData:(id<TCTTimerRefreshData>)data ;

- (void)didFinishCountWithTimer:(id<TCTTimer>)timer;
@end


@protocol TCTTimer <NSObject>

- (void)start;
- (void)pause;
- (void)reset;

@end

@protocol TCTTimerRefreshData <NSObject>
@property (nonatomic, copy, readonly) NSString *day;
@property (nonatomic, copy, readonly) NSString *hour;
@property (nonatomic, copy, readonly) NSString *minute;
@property (nonatomic, copy, readonly) NSString *second;
@property (nonatomic, copy, readonly) NSString *mSecond;
@end