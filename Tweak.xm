#import "Tweak.h"
#import "widgets.h"
#import <Foundation/Foundation.h>

%group reachinfo
%hook SBReachabilityBackgroundView

- (void)_setupChevron {
    if (kChevron) {

    } else {
        %orig;
    }
}

%end

%hook SBReachabilityWindow

- (void)layoutSubviews {
    if(!kEnabled) {
        %orig;
        return;
    }

    [RIView removeFromSuperview]; // thanks @Muirey03
    RIView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    CGFloat height = [[%c(SBReachabilityManager) sharedInstance] effectiveReachabilityYOffset];
    RIView.frame = CGRectMake(self.frame.origin.x, -height + H, self.frame.size.width, height);
    [self addSubview:RIView];
    //[self bringSubviewToFront:RIView];

    Widget *widget = [[NSClassFromString(kTemplate) alloc] init];
    if(widget == nil) return;
    [widget show];
}

%end
%end

#pragma mark - prefreload
void reloadPrefs () {
    prefs = [[HBPreferences alloc] initWithIdentifier:@"com.1di4r.reachinfoprefs"];

    kEnabled = [([prefs objectForKey:@"kEnabled"] ? : @(YES)) boolValue];
    kTemplate = [([prefs objectForKey:@"Template"] ? : @"bashLike") stringValue];
    kChevron = [([prefs objectForKey:@"kChevron"] ? : @(YES)) boolValue];
    H = [([prefs objectForKey:@"kHeight"] ? : @(0)) intValue];
}

void prefsChanged(
              CFNotificationCenterRef center,
              void *observer,
              CFStringRef name,
              const void *object,
              CFDictionaryRef userInfo) 
{
    reloadPrefs();
}

#pragma mark - ctor

%ctor {
    reloadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, prefsChanged, CFSTR("com.1di4r.reachinfoprefs/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    %init(reachinfo);
}
