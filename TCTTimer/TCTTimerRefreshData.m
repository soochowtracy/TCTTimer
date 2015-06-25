//
//  TCTTimerRefreshData.m
//  TCTTimer
//
//  Created by Tracy-One on 15/6/25.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import "TCTTimerRefreshData.h"

static NSString *kDefaultTimeFormat = @"HH-mm-ss-SS";
static NSInteger kSecondPerDay = 60 * 60 * 24;

@interface TCTTimerRefreshData ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, assign) NSDate *date;

@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *hour;
@property (nonatomic, copy) NSString *minute;
@property (nonatomic, copy) NSString *second;
@property (nonatomic, copy) NSString *mSecond;
@end

@implementation TCTTimerRefreshData

- (instancetype)initWithDate:(NSDate *)date timeInterval:(NSTimeInterval)timeInterval{
    if (self= [super init]) {
        self.date = date;
        self.timeInterval = timeInterval;
        [self setUp];
    }
    
    return self;
}

+ (instancetype)refreshDataWithDate:(NSDate *)date timeInterval:(NSTimeInterval)timeInterval{
    TCTTimerRefreshData *temp = [[TCTTimerRefreshData alloc] initWithDate:date timeInterval:timeInterval];
    
    return temp;
}

#pragma mark - private

- (void)setUp{
    NSString *formatDate = [self.dateFormatter stringFromDate:self.date];
    NSArray *refreshDatas = [formatDate componentsSeparatedByString:@"-"];
    if (refreshDatas.count < 4) {
        return;
    }
   
    self.day = @((NSInteger)self.timeInterval / kSecondPerDay).stringValue;
    self.hour =refreshDatas[0];
    self.minute = refreshDatas[1];
    self.second =refreshDatas[2];
    self.mSecond =refreshDatas[3];
}

#pragma mark - accessor
- (NSDateFormatter*)dateFormatter{
    
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
        [_dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        _dateFormatter.dateFormat = kDefaultTimeFormat;
    }
    return _dateFormatter;
}

@end
