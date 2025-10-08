//
//  AddPresetInterfaceController.h
//  Chronos
//
//  Created by Pepo on 07/10/25.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "TimerPreset.h"
#import "StepRowController.h"

@interface AddPresetInterfaceController : WKInterfaceController

@property (nonatomic, weak) IBOutlet WKInterfaceTextField *presetNameTextField;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *emptyStateGroup;
@property (nonatomic, weak) IBOutlet WKInterfaceTable *stepsTable;

@property (nonatomic, strong) TimerPreset *currentPreset;
@property (nonatomic, copy) void (^completionBlock)(TimerPreset *);

- (IBAction)presetNameTextFieldChanged:(NSString *)value;
- (IBAction)addStepButtonTapped;
- (IBAction)saveButtonTapped;

@end

