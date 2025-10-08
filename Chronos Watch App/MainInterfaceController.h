//
//  MainInterfaceController.h
//  Chronos Watch App
//
//  Created by Pepo on 06/10/25.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "TimerPreset.h"

@interface MainInterfaceController : WKInterfaceController

@property (nonatomic, weak) IBOutlet WKInterfaceGroup *emptyStateGroup;
@property (nonatomic, weak) IBOutlet WKInterfaceTable *presetsTable;
@property (nonatomic, strong) NSMutableArray<TimerPreset *> *presets;

- (IBAction)addButtonTapped;


@end

