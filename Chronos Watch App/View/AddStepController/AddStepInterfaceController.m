//
//  AddStepInterfaceController.m
//  Chronos
//
//  Created by Pepo on 07/10/25.
//


#import "AddStepInterfaceController.h"

@interface AddStepInterfaceController ()
@property (nonatomic, assign) NSInteger selectedTypeIndex;
@property (nonatomic, assign) NSInteger selectedHour;
@property (nonatomic, assign) NSInteger selectedMinute;
@property (nonatomic, assign) NSInteger selectedSecond;
@property (nonatomic, copy) void (^completionBlock)(TimerStep *);

@end

@implementation AddStepInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    if (context && [context isKindOfClass:[NSDictionary class]]) {
        self.completionBlock = context[@"completion"];
    }
    
    // Log CRÍTICO: O "envelope" foi recebido corretamente?
    NSLog(@"[TELA ETAPA] 2. Tela de Etapa carregada. O bloco de completude é: %@", self.completionBlock ? @"VÁLIDO" : @"NULO");
    
    self.selectedTypeIndex = 0;
    self.selectedHour = 0;
    self.selectedMinute = 0;
    self.selectedSecond = 0;
    
    WKPickerItem *workItem = [[WKPickerItem alloc] init];
    workItem.title = @"Tarefa";
    
    WKPickerItem *pauseItem = [[WKPickerItem alloc] init];
    pauseItem.title = @"Pausa";
    
    [self.stepTypePicker setItems:@[workItem, pauseItem]];
    
    NSMutableArray<WKPickerItem *> *hourItems = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i <= 23; i++) {
            WKPickerItem *item = [[WKPickerItem alloc] init];
            item.title = [NSString stringWithFormat:@"%02ldh", (long)i];
            [hourItems addObject:item];
        }
        [self.hoursPicker setItems:hourItems];
        
        NSMutableArray<WKPickerItem *> *minuteItems = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i <= 59; i++) {
            WKPickerItem *item = [[WKPickerItem alloc] init];
            item.title = [NSString stringWithFormat:@"%02ldm", (long)i];
            [minuteItems addObject:item];
        }
        [self.minutesPicker setItems:minuteItems];
        
        NSMutableArray<WKPickerItem *> *secondItems = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i <= 59; i++) {
            WKPickerItem *item = [[WKPickerItem alloc] init];
            item.title = [NSString stringWithFormat:@"%02lds", (long)i];
            [secondItems addObject:item];
        }
        [self.secondsPicker setItems:secondItems];
}

- (IBAction)stepTypePickerChanged:(NSInteger)value {
    self.selectedTypeIndex = value;
}

- (IBAction)hoursPickerChanged:(NSInteger)value {
    self.selectedHour = value;
}

- (IBAction)minutesPickerChanged:(NSInteger)value {
    self.selectedMinute = value;
}

- (IBAction)secondsPickerChanged:(NSInteger)value {
    self.selectedSecond = value;
}

- (IBAction)saveButtonTapped {
    NSLog(@"[TELA ETAPA] 3. Botão 'Salvar Etapa' foi tocado.");
    NSLog(@"[TELA ETAPA] 4. Valores selecionados: Tipo=%ld, H=%ld, M=%ld, S=%ld", (long)self.selectedTypeIndex, (long)self.selectedHour, (long)self.selectedMinute, (long)self.selectedSecond);

    StepType type = (self.selectedTypeIndex == 0) ? StepTypeWork : StepTypePause;
    NSString *name = (type == StepTypeWork)? @"Tarefa" : @"Pausa";
    NSTimeInterval duration = (self.selectedHour * 3600) + (self.selectedMinute * 60) + self.selectedSecond;
    TimerStep *newStep = [[TimerStep alloc] initWithName:name type:type duration:duration];
    
    if (self.completionBlock) {
        NSLog(@"[TELA ETAPA] 5. Bloco de completude é VÁLIDO. Enviando a etapa de volta...");
        self.completionBlock(newStep);
    } else {
        NSLog(@"[TELA ETAPA] ERRO CRÍTICO: O bloco de completude é NULO. Não há como enviar a etapa de volta.");
    }
    
    [self dismissController];
}

@end
