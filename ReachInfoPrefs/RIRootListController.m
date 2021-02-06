#include "RIRootListController.h"

@implementation RIRootListController

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
-(void)layoutSubviews{
    [[UIStackView alloc] setSpacing: 10];
    AppearanceSelectionTableCell * appearanceStackView =
        [[AppearanceSelectionTableCell alloc] init];

        appearanceStackView.containerStackView.spacing = 10;
}

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    }
    
    return _specifiers;
}
// - (void)respring {
//     pid_t pid;
//     const char* args[] = {"sbreload", NULL};
//     posix_spawn(&pid, "/usr/bin/sbreload", NULL, NULL, (char* const*)args, NULL);
    
//     //[HBRespringController respringAndReturnTo:[NSURL URLWithString:@"prefs:root=ReachInfo"]];
// }

@end
