//
//  TimerPreset.m
//  Chronos Watch App
//
//  Created by Pepo on 07/10/25.
//

#import "TimerStep.h"

@implementation TimerStep

- (instancetype)initWithName:(NSString *)name type:(StepType)type duration:(NSTimeInterval)duration {
    self = [super init];
    if (self) {
        _stepName = name;
        _type = type;
        _duration = duration;
    }
    return self;
}

@end
