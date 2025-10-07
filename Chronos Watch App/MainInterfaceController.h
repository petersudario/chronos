//
//  MainInterfaceController.h
//  Chronos Watch App
//
//  Created by Pepo on 06/10/25.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainInterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *timerLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *actionButton;

@end

NS_ASSUME_NONNULL_END
