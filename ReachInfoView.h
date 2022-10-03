#import <UIKit/UIKit.h>

@interface ReachInfoView: UIView
-(UIView *)invalidWidget;
@property(nonatomic, retain) id widget;
@end

#define DARK_BG                                                                \
    [UIColor colorWithRed:0.0 / 255.0                                          \
                    green:0.0 / 255.0                                          \
                     blue:0.0 / 255.0                                          \
                    alpha:1.0];

int Widget;
BOOL Shuffle;
BOOL ForceDM;
