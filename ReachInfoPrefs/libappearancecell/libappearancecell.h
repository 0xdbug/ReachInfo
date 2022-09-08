#import <Preferences/PSSpecifier.h>

@interface AppearanceSelectionTableCell : PSTableCell
@property(nonatomic, retain) UIScrollView *containerScrollView;
@property(nonatomic, retain) UIStackView *containerStackView;
@property(nonatomic, retain) NSArray *options;

- (void)updateForType:(int)type;
@end
