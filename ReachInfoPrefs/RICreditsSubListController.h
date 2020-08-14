#import <Preferences/PSListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <CepheiPrefs/HBListController.h>
#import <CepheiPrefs/HBAboutListController.h>
#import <CepheiPrefs/HBTwitterCell.h>
#import <Cephei/HBPreferences.h>

@interface RICreditsSubListController : HBListController

@end

#define iconPath @"/Library/PreferenceBundles/ReachInfoPrefs.bundle/icon.png"

#define TINT_COLOR                                                            \
    [UIColor colorWithRed:48.0 / 255.0                                          \
                    green:50.0 / 255.0                                          \
                     blue:66 / 255.0                                          \
                    alpha:1.0];
#define NAVBG_COLOR                                                            \
    [UIColor colorWithRed:45.0 / 255.0                                          \
                    green:49.0 / 255.0                                          \
                     blue:66.0 / 255.0                                          \
                    alpha:1.0];
#define TTL_COLOR                                                            \
    [UIColor colorWithRed:130.0 / 255.0                                          \
                    green:130.0 / 255.0                                          \
                     blue:135.0 / 255.0                                          \
                    alpha:1.0];