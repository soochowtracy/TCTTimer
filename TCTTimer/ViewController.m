//
//  ViewController.m
//  TCTTimer
//
//  Created by Tracy-One on 15/6/25.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import "ViewController.h"
#import "TCTCountdownTimer.h"

@interface ViewController ()<TCTTimerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (nonatomic, strong) TCTCountdownTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self timer];
}

- (IBAction)didPressStart:(id)sender {
    self.timer.timeInterval = 10;
    [self.timer start];
}
- (IBAction)didPressReset:(id)sender {
    [self.timer reset];
}
- (IBAction)didpressPause:(id)sender {
    [self.timer pause];
}

- (void)timer:(id<TCTTimer>)timer timeInterval:(NSTimeInterval)timeInterval refreshWithData:(id<TCTTimerRefreshData>)data{
    self.countDownLabel.text = [NSString stringWithFormat:@"%@ %@:%@:%@ %@",[data day],[data hour],[data minute],[data second],[data mSecond]];
}

- (TCTCountdownTimer *)timer{
    if (!_timer) {
        _timer = [TCTCountdownTimer countdownTimerWithAccuracy:TCTTimerAccuracyHighest timeInterval:5];
        _timer.delegate = self;
        [self.timer start];
    }
    return _timer;
}
@end
