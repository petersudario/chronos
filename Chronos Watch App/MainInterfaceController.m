//
//  MainInterfaceController.m
//  Chronos Watch App
//
//  Created by Pepo on 06/10/25.
//

#import "MainInterfaceController.h"
#import "PresetRowController.h"

@implementation MainInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.presets = [[NSMutableArray alloc] init];
    
    [self configureView];
}

- (void)willActivate {
    [super willActivate];
    [self configureView];
}

- (void)configureView {
    if (self.presets.count == 0) {
        [self.presetsTable setHidden:YES];
        [self.emptyStateGroup setHidden:NO];
    } else {
        [self.presetsTable setHidden:NO];
        [self.emptyStateGroup setHidden:YES];
        
        [self.presetsTable setNumberOfRows:self.presets.count withRowType:@"PresetRow"];
        
        for (NSInteger i = 0; i < self.presets.count; i++) {
            PresetRowController *row = [self.presetsTable rowControllerAtIndex:i];
            TimerPreset *preset = self.presets[i];
            [row.presetNameLabel setText:preset.presetName];
        }
    }
}

- (IBAction)addButtonTapped {
    void (^presetCreationCompletionBlock)(TimerPreset *) = ^(TimerPreset *savedPreset) {
        NSLog(@"3. Bloco de completude RECEBIDO na tela principal!");
        
        if (savedPreset) {
            NSLog(@"4. Preset recebido com nome: %@", savedPreset.presetName);
            [self.presets addObject:savedPreset];
            [self configureView];
        }
    };
    
    NSDictionary *context = @{@"completion": presetCreationCompletionBlock};
    [self presentControllerWithName:@"AddPresetScreen" context:context];
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    TimerPreset *selectedPreset = self.presets[rowIndex];
    [self pushControllerWithName:@"TimerInterfaceController" context:selectedPreset];
}

@end
