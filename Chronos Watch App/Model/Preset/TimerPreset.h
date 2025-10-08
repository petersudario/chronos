//
//  TimerPreset.h
//  Chronos Watch App
//
//  Created by Pepo on 07/10/25.
//

#import <Foundation/Foundation.h>
#import "TimerStep.h"

@interface TimerPreset : NSObject

@property (nonatomic, strong) NSString *presetName;
@property (nonatomic, strong, readonly) NSMutableArray<TimerStep *> *steps;

- (instancetype)initWithName:(NSString *)name;
- (void)addStep:(TimerStep *)step;
- (NSTimeInterval)totalDuration;

@end
