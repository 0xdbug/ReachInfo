//
//  Clock.m
//  ReachInfo
//
//  Created by 1di4r on 7/31/20.
//  Copyright © 2020 1di4r. All rights reserved.
//

#import "Clock.h"

@implementation Clock

+(void)show{

        clockView = [[ClockView alloc] initWithFrame:CGRectMake(0, 0, 162, 162)];
        [clockView setClockBackgroundImage:[UIImage imageNamed:clockFacePath].CGImage];
        [clockView setSecHandImage:[UIImage imageNamed:clockSecPath].CGImage];
        [clockView setHourHandImage:[UIImage imageNamed:clockHourPath].CGImage];
        [clockView setMinHandImage:[UIImage imageNamed:clockMinPath].CGImage];

        // [clockView setSecHandContinuos:YES]; // Move the second's hand continously, Off by default
        clockView.center = CGPointMake(RIView.center.x, 110);
        [RIView addSubview:clockView];
        [clockView start];
}

@end
