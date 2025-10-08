//
//  TimerPreset.m
//  Chronos Watch App
//
//  Created by Pepo on 07/10/25.
//

#import "TimerPreset.h"

// extension do timer preset
@interface TimerPreset ()
@property (nonatomic, strong, readwrite) NSMutableArray<TimerStep *> *steps;
@end

@implementation TimerPreset

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _presetName = name;
        _steps = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addStep:(TimerStep *)step {
    [self.steps addObject:step];
}

- (NSTimeInterval)totalDuration {
    NSTimeInterval total = 0;
    for (TimerStep *step in self.steps) {
        total += step.duration;
    }
    return total;
}

@end
