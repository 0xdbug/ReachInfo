#include "RIPreferencesSubListController.h"

@implementation RIPreferencesSubListController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = false;
        self.navigationController.navigationItem.largeTitleDisplayMode =
        UINavigationItemLargeTitleDisplayModeNever;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    if (@available(iOS 11, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = false;
        self.navigationController.navigationItem.largeTitleDisplayMode =
        UINavigationItemLargeTitleDisplayModeNever;
    }
}
- (instancetype) init {
    self = [super init];
    if (self) {
        UIImage *image = [UIImage imageNamed:iconPath];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
        
        HBAppearanceSettings * appearanceSettings =
        [[HBAppearanceSettings alloc] init];
        appearanceSettings.tableViewCellSeparatorColor = [UIColor clearColor];
        appearanceSettings.tintColor = TINT_COLOR;
        appearanceSettings.navigationBarBackgroundColor = NAVBG_COLOR;
        self.hb_appearanceSettings = appearanceSettings;
    }
    return self;
}
- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"prefsSub" target:self];
    }
    return _specifiers;
}

@end
