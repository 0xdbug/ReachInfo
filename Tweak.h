#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#import "ReachInfoView.h"

@interface SBReachabilityManager : NSObject
+ (id)sharedInstance;
@property (nonatomic,readonly) BOOL reachabilityModeActive;
@property (assign,nonatomic) BOOL reachabilityEnabled;
@property (nonatomic,readonly) double reachabilityYOffset;
@end

@interface SBReachabilityWindow : UIWindow
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIView *mdView;
@property (nonatomic, strong) ReachInfoView *RIView;
@end

CGFloat height;
HBPreferences *prefs;
BOOL Enabled;
BOOL NC;
BOOL Timeout;
BOOL YOffset;
float YOffsetValue;
BOOL CR;
float CRValue;
