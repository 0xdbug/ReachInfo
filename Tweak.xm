#import "Tweak.h"

%group reachinfo

%hook SBReachabilityWindow

%property (nonatomic, retain) ReachInfoView *RIView;
%property (nonatomic, retain) UIView *mdView;

-(id)initWithWallpaperVariant:(long long)arg1 { // initializing the tweak
    if (!Enabled) return %orig;

    self = %orig;
    height = [[%c(SBReachabilityManager) sharedInstance] reachabilityYOffset];
    self.userInteractionEnabled = YES;
    self.RIView = [[ReachInfoView alloc] initWithFrame:CGRectMake(self.frame.origin.x,
                                              -height, self.frame.size.width, height)];

    if (!self.RIView.superview) {
		[self addSubview:self.RIView];
		[self bringSubviewToFront:self.RIView];

	}
    return self;
}

-(id)hitTest:(CGPoint)arg1 withEvent:(id)arg2 { // passing touches to our widget (Thanks Nepeta)
    if (!Enabled) return %orig;
    UIView *candidate = %orig;
    
    if (arg1.y <= 0) {
        candidate = [self.RIView.widget hitTest:[self.RIView.widget convertPoint:arg1 fromView:self] withEvent:arg2];

        if (self.mdView) {
            candidate = self.mdView;
            self.mdView = nil;
        } else {
            self.mdView = candidate;
        }
    }
    NSLog(@"[ReachInfo] %@", candidate);
    return candidate;
}

%end

%hook SBReachabilityBackgroundView

- (void)_setupChevron { // removes grabber
    if (!Enabled) %orig;
}
-(double)_displayCornerRadius{
    if (Enabled && CR) return CRValue;
    return %orig;
}

%end

%hook SBReachabilityManager

-(double)reachabilityYOffset { // expanding reachability
    if (Enabled && YOffset) return (%orig + YOffsetValue);
    return (%orig + 40);
}

- (_Bool)gestureRecognizerShouldBegin:(id)arg1 { // disabling Reachability swipe down
    if (Enabled && (![arg1 isKindOfClass:%c(SBScreenEdgePanGestureRecognizer)] && ![arg1 isKindOfClass:%c(SBReachabilityGestureRecognizer)])) return false;
    return %orig;
}

-(void)_setKeepAliveTimer { // do not deactivate reachability after certain amount of time
    if (Enabled && Timeout){

    }else{
        %orig;
    }
}

%end

%hook SBCoverSheetPrimarySlidingViewController
-(void)handleReachabilityModeActivated { // should disable swipe down for notification center on the widgets
    if (Enabled && !NC){

    }else{
        %orig;
    }
}

%end

%end

// too bugy for release
// %hook SBReachabilitySettings
// -(void)setYOffsetFactor:(double)arg1{
//     arg1 = -arg1;
//     NSLog(@"[ReachInfo] %f", arg1);
//     %orig;
// }

// -(double)yOffset{
//     double daYOffset = %orig;
//     NSLog(@"[ReachInfo] yOffset: %f", daYOffset);
//     return %orig;
// }


// %end

void reloadPrefs () {
    prefs = [[HBPreferences alloc] initWithIdentifier:@"com.1di4r.reachinfoprefs"];
    Enabled = [([prefs objectForKey:@"kEnabled"] ? : @(YES)) boolValue];
    Widget = [([prefs objectForKey:@"Widget"] ? : 0) intValue];

    Shuffle = [([prefs objectForKey:@"kShuffle"] ? : @(NO)) boolValue];
    NC = [([prefs objectForKey:@"kNC"] ? : @(NO)) boolValue];
    Timeout = [([prefs objectForKey:@"kTimeout"] ? : @(YES)) boolValue];

    YOffset = [([prefs objectForKey:@"kYOffset"] ? : @(YES)) boolValue];
    YOffsetValue = [([prefs objectForKey:@"kYOffsetValue"] ? : 0) floatValue];

    CR = [([prefs objectForKey:@"kCR"] ? : @(NO)) boolValue];
    CRValue = [([prefs objectForKey:@"kCRValue"] ? : 0) floatValue];
}

void prefsChanged(
              CFNotificationCenterRef center,
              void *observer,
              CFStringRef name,
              const void *object,
              CFDictionaryRef userInfo) {
                reloadPrefs();
    }

%ctor {
    reloadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, prefsChanged, CFSTR("com.1di4r.reachinfoprefs/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    %init(reachinfo);

}
