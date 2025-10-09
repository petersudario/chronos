//
//  AddPresetInterfaceController.m
//  Chronos
//
//  Created by Pepo on 07/10/25.
//

#import "AddPresetInterfaceController.h"

@implementation AddPresetInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    if (context && [context isKindOfClass:[NSDictionary class]]) {
        self.completionBlock = context[@"completion"];
    }
    
    self.currentPreset = [[TimerPreset alloc] initWithName:@""];
    [self configureView];
}

- (IBAction)presetNameTextFieldChanged:(NSString *)value {
    self.currentPreset.presetName = value;
}

- (void)configureView {
    if (self.currentPreset.steps.count == 0) {
        [self.stepsTable setHidden:YES];
        [self.emptyStateGroup setHidden:NO];

    } else {
        [self.stepsTable setHidden:NO];
        [self.emptyStateGroup setHidden:YES];
        
        [self.stepsTable setNumberOfRows:self.currentPreset.steps.count withRowType:@"StepRow"];
        
        for (NSInteger i = 0; i < self.currentPreset.steps.count; i++) {
            StepRowController *row = [self.stepsTable rowControllerAtIndex:i];
            TimerStep *step = self.currentPreset.steps[i];
            
            [row.stepNameLabel setText:step.stepName];
            
            NSTimeInterval totalSeconds = step.duration;
            int hours = (int)(totalSeconds / 3600);
            int minutes = (int)((totalSeconds / 60) - (hours * 60));
            int seconds = (int)(totalSeconds - (minutes * 60) - (hours * 3600));
            NSString *durationString = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
            
            [row.stepDurationLabel setText:durationString];
        }
    }
}

- (IBAction)addStepButtonTapped {
    NSLog(@"[PRESET] Botão '+' de adicionar etapa tocado.");
    
    void (^stepCreationCompletionBlock)(TimerStep *) = ^(TimerStep *newStep) {
        if (newStep) {
            NSLog(@"[PRESET] Nova etapa recebida: %@ (%f segundos)", newStep.stepName, newStep.duration);
            [self.currentPreset addStep:newStep];
            [self configureView];
        }
    };
    
    NSDictionary *context = @{@"completion": stepCreationCompletionBlock};
    [self presentControllerWithName:@"AddStepScreen" context:context];
}

- (IBAction)saveButtonTapped {
    NSLog(@"[PRESET] Botão 'Salvar' tocado.");
    
    if (self.currentPreset.presetName.length == 0) {
        NSLog(@"[ERRO] Nome do preset está vazio!");
        [self dismissController];
        return;
    }
    
    if (self.currentPreset.steps.count == 0) {
        NSLog(@"[ERRO] Nenhuma etapa adicionada!");
        [self dismissController];
        return;
    }
    
    if (self.completionBlock) {
        NSLog(@"[PRESET] Enviando preset '%@' com %lu etapas.", self.currentPreset.presetName, (unsigned long)self.currentPreset.steps.count);
        self.completionBlock(self.currentPreset);
    }
    
    [self dismissController];
}

@end
