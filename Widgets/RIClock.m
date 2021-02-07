//
//  RIClock.m
//  ReachInfo
//
//  Created by 1di4r on 7/31/20.
//

#import "RIClock.h"

@implementation RIClock

- (void)show{
    clockView = [ClockView new];
    [clockView setClockBackgroundImage:[UIImage imageNamed:([self isLightMode] ? clockFaceDarkPath : clockFacePath)].CGImage];
    [clockView setSecHandImage:[UIImage imageNamed:clockSecPath].CGImage];
    [clockView setHourHandImage:[UIImage imageNamed:([self isLightMode] ? clockHourDarkPath : clockHourPath)].CGImage];
    [clockView setMinHandImage:[UIImage imageNamed:([self isLightMode] ? clockMinDarkPath : clockMinPath)].CGImage];

    // [clockView setSecHandContinuos:YES]; // Move the second's hand continously, Off by default
    [self addSubview:clockView];
    [clockView start];
    [self setupViews];
}
- (void)setupViews{
    [clockView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [clockView.widthAnchor constraintEqualToConstant:190].active = YES;
    [clockView.heightAnchor constraintEqualToConstant:190].active = YES;
    [clockView.centerYAnchor constraintEqualToAnchor:self.superview.centerYAnchor].active = YES;
    [clockView.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;
}
- (BOOL)isLightMode{
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) return YES;
    return NO;
}

@end
