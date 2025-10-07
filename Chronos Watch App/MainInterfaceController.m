//
//  MainInterfaceController.m
//  Chronos Watch App
//
//  Created by Pepo on 06/10/25.
//

#import "MainInterfaceController.h"

@interface MainInterfaceController()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger remainingSeconds;
@property (nonatomic, assign) BOOL isRunning;
@end

@implementation MainInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self.timerLabel setText:@"25:00"];
    
    self.isRunning = NO;
    self.remainingSeconds = 25 * 60;
    [self updateLabel];
}

- (IBAction)actionButtonTapped {
    if (self.isRunning) {
        [self stopTimer];
    } else {
        [self startTimer];
    }
}

#pragma mark - Timer Control

- (void)startTimer {
    self.isRunning = YES;
    [self.actionButton setTitle:@"Parar"];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(updateTimer)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stopTimer {
    self.isRunning = NO;
    [self.actionButton setTitle:@"Iniciar"];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)updateTimer {
    if (self.remainingSeconds > 0) {
        self.remainingSeconds--;
        [self updateLabel];
    } else {
        [self stopTimer];
        [self notifyFinished];
    }
}

- (void)updateLabel {
    NSInteger minutes = self.remainingSeconds / 60;
    NSInteger seconds = self.remainingSeconds % 60;
    NSString *text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    [self.timerLabel setText:text];
}

#pragma mark - Notificação

- (void)notifyFinished {
    WKInterfaceDevice *device = [WKInterfaceDevice currentDevice];
    [device playHaptic:WKHapticTypeSuccess];
    
    [self.timerLabel setText:@"Fim"];
    [self.actionButton setTitle:@"Reiniciar"];
    
    self.remainingSeconds = 25 * 60;
}

@end
