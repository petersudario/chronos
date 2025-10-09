//
//  TimerInterfaceController.m
//  Chronos Watch App
//
//  Created by Pepo on 08/10/25.
//

#import <Foundation/Foundation.h>
#import "TimerInterfaceController.h"
#import "TimerStep.h"

@interface TimerInterfaceController()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger countdown;
@property (nonatomic, assign) NSTimeInterval stepTimeRemaining;

@end

@implementation TimerInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    if (context && [context isKindOfClass:[TimerPreset class]]) {
        self.preset = (TimerPreset *)context;
    }
    
    self.currentStepIndex = 0;
    [self startCountdown:3];
}

- (void)startCountdown:(NSInteger)seconds {
    self.countdown = seconds;
    [self updateCountdownLabel];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdownTick) userInfo:nil repeats:YES];
}

- (void)countdownTick {
    self.countdown -= 1;
    [self updateCountdownLabel];
    
    if (self.countdown <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        [self startStep:self.currentStepIndex];
    }
}

- (void)updateCountdownLabel {
    if (self.countdown > 0) {
        [self.countdownLabel setText:[NSString stringWithFormat:@"%ld", (long)self.countdown]];
    } else {
        [self.countdownLabel setText:@""];
    }
}

- (void)startStep:(NSInteger)index {
    if (index >= self.preset.steps.count) {
        [self finishPreset];
        return;
    }
    
    TimerStep *step = self.preset.steps[index];
    self.stepTimeRemaining = step.duration;
    [self.stepLabel setText:step.stepName];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(stepTick) userInfo:nil repeats:YES];
}

- (void)stepTick {
    self.stepTimeRemaining -= 1;
    
    NSInteger minutes = (NSInteger)(self.stepTimeRemaining / 60);
    NSInteger seconds = (NSInteger)(self.stepTimeRemaining) % 60;
    
    [self.countdownLabel setText:[NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds]];
    
    if (self.stepTimeRemaining <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        
        self.currentStepIndex += 1;
        [self startStep:self.currentStepIndex];
    }
}

- (void)finishPreset {
    [self.stepLabel setText:@"Concluído!"];
    [self.countdownLabel setText:@""];
}

@end
