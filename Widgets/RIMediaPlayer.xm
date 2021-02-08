//
//  RIMediaPlayer.xm
//  ReachInfo
//
//  Created by 1di4r on 12/9/20.
//

#import "RIMediaPlayer.h"

UIImage *artWorkImage;

@implementation RIMediaPlayer

- (void)show{
    if (MediaBG) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBackground:) name:@"updateBackgroundNotification"
    object:nil];
    [[%c(SBMediaController) sharedInstance] setNowPlayingInfo:[[%c(SBMediaController) sharedInstance] _nowPlayingInfo]];
    self.backgroundColor = nil;
    if (artWorkImage && MediaBG) self.backgroundColor = [self averageColor:artWorkImage withAlpha:1];
    if (@available(iOS 14.2, *)){
        self.MRUNowPlayingViewController = [%c(MRUNowPlayingViewController) coversheetViewController];
        self.MRUNowPlayingViewController.view.frame = CGRectMake(0, [UIDevice.currentDevice isNotched] ? 30 : 0, self.superview.frame.size.width, [UIDevice.currentDevice isNotched] ? self.superview.frame.size.height -30 : self.superview.frame.size.height);
        self.MRUNowPlayingViewController.view.stylingProvider = [[%c(MRUVisualStylingProvider) alloc] init];
        // self.MRUNowPlayingViewController.view.controlsView.timeControlsView.hidden = true;
        [self addSubview: self.MRUNowPlayingViewController.view];
    }else{
        self.MediaControlsPanelViewController = [%c(MediaControlsPanelViewController) panelViewControllerForCoverSheet];
        self.MediaControlsPanelViewController.view.frame = CGRectMake(0, [UIDevice.currentDevice isNotched] ? 30 : 0, self.superview.frame.size.width, [UIDevice.currentDevice isNotched] ? self.superview.frame.size.height -30 : self.superview.frame.size.height);
        [self.MediaControlsPanelViewController setStyle: 0];
        [self addSubview: self.MediaControlsPanelViewController.view];
    }
}

- (UIColor *)averageColor:(UIImage *)image withAlpha:(CGFloat)alphaValue {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), image.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0) {
        CGFloat alpha = alphaValue;
        if (alphaValue == 1) alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }
    else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}

- (void)updateBackground:(NSNotification *) notification{
    if ([[notification name] isEqualToString:@"updateBackgroundNotification"]){
        NSLog (@"[ReachInfo] Successfully received the notification!");
        self.backgroundColor = [self averageColor:artWorkImage withAlpha:1];
    }
}

- (void)dealloc {
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    artWorkImage = nil;
}

@end


%hook SBMediaController
- (void)setNowPlayingInfo:(id)arg1 {
    %orig;
    if (MediaBG){
        MRMediaRemoteGetNowPlayingInfo(dispatch_get_main_queue(), ^(CFDictionaryRef information) {
            NSDictionary *dict = (__bridge NSDictionary *)information;

            if (dict && dict[(__bridge NSString *)kMRMediaRemoteNowPlayingInfoArtworkData]) {
                artWorkImage = [UIImage imageWithData:[dict objectForKey:(__bridge NSString*)kMRMediaRemoteNowPlayingInfoArtworkData]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateBackgroundNotification" 
                object:self];
                NSLog(@"[ReachInfo] %@", arg1);
            }
        });
    }
}
%end

void reloadMediaPrefs() {
    HBPreferences *MediaPrefs = [[HBPreferences alloc] initWithIdentifier:@"com.1di4r.reachinfoprefs"];
    MediaBG = [([MediaPrefs objectForKey:@"kMediaBG"] ? : @(YES)) boolValue];
}

void MediaPrefsChanged(
    CFNotificationCenterRef center,
    void *observer,
    CFStringRef name,
    const void *object,
    CFDictionaryRef userInfo) {
        reloadMediaPrefs();
    }

%ctor {
    reloadMediaPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, MediaPrefsChanged, CFSTR("com.1di4r.reachinfoprefs/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
