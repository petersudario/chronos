//
//  AddStepInterfaceController.h
//  Chronos
//
//  Created by Pepo on 07/10/25.
//


#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "TimerStep.h" // Precisamos saber o que é um TimerStep

@interface AddStepInterfaceController : WKInterfaceController

@property (nonatomic, weak) IBOutlet WKInterfacePicker *stepTypePicker;
@property (nonatomic, weak) IBOutlet WKInterfacePicker *hoursPicker;
@property (nonatomic, weak) IBOutlet WKInterfacePicker *minutesPicker;
@property (nonatomic, weak) IBOutlet WKInterfacePicker *secondsPicker;

- (IBAction)saveButtonTapped;

@end
