//
//  TimerInterfaceController.h
//  Chronos
//
//  Created by Pepo on 08/10/25.
//


#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "TimerPreset.h"

@interface TimerInterfaceController : WKInterfaceController

@property (nonatomic, weak) IBOutlet WKInterfaceLabel *countdownLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *stepLabel;

@property (nonatomic, strong) TimerPreset *preset;
@property (nonatomic, assign) NSInteger currentStepIndex;

@end
