//
//  TCTTimerRefreshData.h
//  TCTTimer
//
//  Created by Tracy-One on 15/6/25.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCTTimer.h"
@interface TCTTimerRefreshData : NSObject<TCTTimerRefreshData>

+ (instancetype)refreshDataWithDate:(NSDate *)date timeInterval:(NSTimeInterval)timeInterval;

@end
