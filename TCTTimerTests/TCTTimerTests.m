//
//  TCTTimerTests.m
//  TCTTimerTests
//
//  Created by Tracy-One on 15/6/25.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TCTCountdownTimer.h"

@interface TCTTimerTests : XCTestCase<TCTTimerDelegate>

@property (nonatomic, strong)TCTCountdownTimer *timer;

@property (nonatomic, strong) XCTestExpectation *timerExpectation;
@end

@implementation TCTTimerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.timer = [TCTCountdownTimer countdownTimerWithAccuracy:TCTTimerAccuracyHighest timeInterval:5];
    self.timer.delegate = self;
    
    self.timerExpectation = [self expectationWithDescription:@"timerExpectation"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)timer:(id<TCTTimer>)timer timeInterval:(NSTimeInterval)timeInterval refreshWithData:(id<TCTTimerRefreshData>)data{
    XCTAssertLessThanOrEqual([data.second integerValue], 5);
    XCTAssertGreaterThanOrEqual([data.second integerValue], 0);
    
    if (timeInterval < 1) {
        [self.timerExpectation fulfill];
    }
}

- (void)testTimer{
    
    [self measureBlock:^{
        [self.timer start];
    }];
    [self waitForExpectationsWithTimeout:4 handler:^(NSError *error) {
        [self.timer pause];
    }];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
