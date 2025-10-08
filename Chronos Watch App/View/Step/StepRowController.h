//
//  StepRowController.h
//  Chronos
//
//  Created by Pepo on 07/10/25.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface StepRowController : NSObject

@property (nonatomic, weak) IBOutlet WKInterfaceLabel *stepNameLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *stepDurationLabel;

@end
