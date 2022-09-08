#import "ReachInfoView.h"

@implementation ReachInfoView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) { // display widget when ReachInfoView gets initialized
        NSArray *widgetsArray = @[@"RIMediaPlayer", @"RIClock", @"RITerminal", @"RIAstro", @"RIWeather", @"RIReminders"];
        NSString *selectedWidget = widgetsArray[Widget];

        if (@available(iOS 13.0, *)) self.backgroundColor = [UIColor systemBackgroundColor];
        if (Shuffle){
            NSUInteger randomIndex = arc4random_uniform(widgetsArray.count);
            selectedWidget = widgetsArray[randomIndex];
            // not sure whats the difference between CFNotificationCenter and NSNotificationCenter. but lets go with this for now
            CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.1di4r.reachinfoprefs/ReloadPrefs"), NULL, NULL, true);
        }
        self.widget = [[NSClassFromString(selectedWidget) alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        if (self.widget != nil){
            [self addSubview: self.widget];
            [self.widget show];
        }else{
            [self addSubview:[self invalidWidget]];
        }
    }
    return self;
}

- (UILabel *)invalidWidget{ // in case the widget is invaild (removed?) or if i ever made a developer API or somthn
    UILabel *invalidLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    invalidLabel.textAlignment = NSTextAlignmentCenter;
    invalidLabel.text = @"Invalid Widget";
    invalidLabel.font = [UIFont boldSystemFontOfSize:20];
    return invalidLabel;
}

@end