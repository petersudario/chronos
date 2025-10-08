//
//  TimerStep.h
//  Chronos Watch App
//
//  Created by Pepo on 07/10/25.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, StepType) {
    StepTypeWork,
    StepTypePause
};

@interface TimerStep : NSObject

@property (nonatomic, assign) StepType type;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong) NSString *stepName;

- (instancetype)initWithName:(NSString *)name type:(StepType)type duration:(NSTimeInterval)duration;

@end
