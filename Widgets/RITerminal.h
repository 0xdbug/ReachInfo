//
//  RITerminal.h
//  ReachInfo
//
//  Created by 1di4r on 7/31/20.
//  Copyright © 2020 1di4r. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cephei/HBPreferences.h>
#include <sys/sysctl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface RITerminal : UIView
-(void)show;
-(NSTimeInterval)uptime;
-(NSString *)getIPAddress;

@property (nonatomic, retain) UILabel *cmdLabel;
@property (nonatomic, retain) UILabel *upLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UILabel *battLabel;
@property (nonatomic, retain) UILabel *IPLabel;
@property (nonatomic, retain) UILabel *returnLabel;
@end

NSString *deviceName;
NSString *day;
BOOL TerminalPos;
BOOL ForceDM;
UIColor *cLabelColor;
