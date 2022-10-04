//
//  RITerminal.m
//  ReachInfo
//
//  Created by 1di4r on 7/31/20.
//  Copyright © 2020 1di4r. All rights reserved.
//

#import "RITerminal.h"

@implementation RITerminal

- (NSTimeInterval)uptime{
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);

    struct timeval now;
    struct timezone tz;
    gettimeofday(&now, &tz);

    double uptime = -1;

    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0)
    {
        uptime = now.tv_sec - boottime.tv_sec;
        uptime += (double)(now.tv_usec - boottime.tv_usec) / 1000000.0;
    }
    return uptime;

}

- (NSString *) getIPAddress {
    NSString *address = @"Wi-Fi Not Connected";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];

                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;

}

-(void)configColors {
    if (ForceDM) {
        cLabelColor = [UIColor whiteColor];
    }else {
        cLabelColor = [UIColor labelColor];
    }
}

-(void)show{
    [self configColors];

    self.cmdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 18)];
    self.cmdLabel.backgroundColor = [UIColor clearColor];
    self.cmdLabel.textColor = cLabelColor;
    self.cmdLabel.font = [UIFont fontWithName:@"Menlo" size:14];
    deviceName = [[UIDevice currentDevice] name];
    self.cmdLabel.text = [NSString stringWithFormat:@"%@@host:~$ now", deviceName];
    self.cmdLabel.adjustsFontSizeToFitWidth = true;
    // self.cmdLabel.center = CGPointMake(self.superview.center.x + 20, 49);
    self.cmdLabel.layer.shadowColor = [[UIColor labelColor] CGColor];
    self.cmdLabel.layer.shadowRadius = 2.0;
    self.cmdLabel.layer.shadowOpacity = 0.8;
    self.cmdLabel.layer.shadowOffset = CGSizeMake(0, 0);
    self.cmdLabel.layer.masksToBounds = false;
    int dF = self.cmdLabel.font.pointSize;
    [self.cmdLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.cmdLabel];

    int upTimeI = ([self uptime]) / (60 * 60 * 24);
    self.upLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 18)];
    self.upLabel.textColor = cLabelColor;
    self.upLabel.backgroundColor = [UIColor clearColor];
    day = @"Day";
    if (upTimeI > 1) day = @"Days";
    self.upLabel.text = [NSString stringWithFormat:@"[UPTIME] %d %@", upTimeI, day];
    self.upLabel.font = [UIFont fontWithName:@"Menlo" size:dF];
    self.upLabel.adjustsFontSizeToFitWidth = true;
    // self.upLabel.center = CGPointMake(self.superview.center.x + 20, 69);
    NSMutableAttributedString *clUp = [[NSMutableAttributedString alloc] initWithString:self.upLabel.text];
    [clUp addAttribute:NSForegroundColorAttributeName
                 value:[UIColor systemPinkColor]
                 range:NSMakeRange(8, self.upLabel.text.length - 8)];

    NSShadow *upShadow = [[NSShadow alloc] init];
    upShadow.shadowColor = [UIColor systemPinkColor];
    upShadow.shadowOffset = CGSizeMake(0, 0);
    upShadow.shadowBlurRadius = 0.7;
    [clUp addAttribute:NSShadowAttributeName
                 value:upShadow
                 range:NSMakeRange(8, self.upLabel.text.length - 8)];


    self.upLabel.attributedText = clUp;
    self.upLabel.layer.shadowColor = [[UIColor labelColor] CGColor];
    self.upLabel.layer.shadowRadius = 0.5;
    self.upLabel.layer.shadowOpacity = 0.6;
    self.upLabel.layer.shadowOffset = CGSizeMake(0, 0);
    self.upLabel.layer.masksToBounds = false;
    [self.upLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.upLabel];

    NSDate *time = [NSDate date];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSString *timeString = [timeFormatter stringFromDate:time];
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 18)];
    self.timeLabel.textColor = cLabelColor;
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.text = [NSString stringWithFormat:@"[TIME] %@  ", timeString];
    self.timeLabel.font = [UIFont fontWithName:@"Menlo" size:dF];
    self.timeLabel.adjustsFontSizeToFitWidth = true;
    // self.timeLabel.center = CGPointMake(self.superview.center.x + 20, 89);
    NSMutableAttributedString *clTime = [[NSMutableAttributedString alloc] initWithString:self.timeLabel.text];
    [clTime addAttribute:NSForegroundColorAttributeName
                   value:[UIColor greenColor]
                   range:NSMakeRange(6, self.timeLabel.text.length - 6)];

    NSShadow *timeShadow = [[NSShadow alloc] init];
    timeShadow.shadowColor = [UIColor greenColor];
    timeShadow.shadowOffset = CGSizeMake(0, 0);
    timeShadow.shadowBlurRadius = 0.7;
    [clTime addAttribute:NSShadowAttributeName
                   value:timeShadow
                   range:NSMakeRange(6, self.timeLabel.text.length - 6)];


    self.timeLabel.attributedText = clTime;
    self.timeLabel.layer.shadowColor = [[UIColor labelColor] CGColor];
    self.timeLabel.layer.shadowRadius = 0.5;
    self.timeLabel.layer.shadowOpacity = 0.6;
    self.timeLabel.layer.shadowOffset = CGSizeMake(0, 0);
    self.timeLabel.layer.masksToBounds = false;
    [self.timeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.timeLabel];

    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"E, MMMM d"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 18)];
    self.dateLabel.textColor = cLabelColor;
    self.dateLabel.backgroundColor = [UIColor clearColor];
    self.dateLabel.text = [NSString stringWithFormat:@"[DATE] %@", dateString];
    self.dateLabel.font = [UIFont fontWithName:@"Menlo" size:dF];
    self.dateLabel.adjustsFontSizeToFitWidth = true;
    // self.dateLabel.center = CGPointMake(self.superview.center.x + 20, 109);
    NSMutableAttributedString *clDate = [[NSMutableAttributedString alloc] initWithString:self.dateLabel.text];
    [clDate addAttribute:NSForegroundColorAttributeName
                   value:[UIColor purpleColor]
                   range:NSMakeRange(6, self.dateLabel.text.length - 6)];

    NSShadow *dateShadow = [[NSShadow alloc] init];
    dateShadow.shadowColor = [UIColor purpleColor];
    dateShadow.shadowOffset = CGSizeMake(0, 0);
    dateShadow.shadowBlurRadius = 0.7;
    [clDate addAttribute:NSShadowAttributeName
                   value:dateShadow
                   range:NSMakeRange(6, self.dateLabel.text.length - 6)];

    self.dateLabel.attributedText = clDate;
    self.dateLabel.layer.shadowColor = [[UIColor labelColor] CGColor];
    self.dateLabel.layer.shadowRadius = 0.5;
    self.dateLabel.layer.shadowOpacity = 0.6;
    self.dateLabel.layer.shadowOffset = CGSizeMake(0, 0);
    self.dateLabel.layer.masksToBounds = false;
    [self.dateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.dateLabel];


    int currentBattery = [[UIDevice currentDevice] batteryLevel] *100;
    int hashCount = currentBattery / 10;
    int dotCount = 10 - hashCount;
    NSMutableString *Hashs = [NSMutableString stringWithCapacity:11];
    NSMutableString *Dots = [NSMutableString stringWithCapacity:11];

    for (int a = 0; a < hashCount; a++) {
        [Hashs appendFormat:@"#"];
    }
    for (int b = 0; b < dotCount; b++) {
        [Dots appendFormat:@"."];
    }
    NSString *deviceBatteryInHash = [NSString stringWithFormat:@"%@%@", Hashs, Dots];
    self.battLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 18)];
    self.battLabel.backgroundColor = [UIColor clearColor];
    self.battLabel.text = [NSString stringWithFormat:@"[BATT] [%@] %d%%", deviceBatteryInHash, currentBattery];
    self.battLabel.textColor = cLabelColor;
    self.battLabel.font = [UIFont fontWithName:@"Menlo" size:dF];
    self.battLabel.adjustsFontSizeToFitWidth = true;
    // self.battLabel.center = CGPointMake(self.superview.center.x + 20, 129);
    NSMutableAttributedString *clBatt = [[NSMutableAttributedString alloc] initWithString:self.battLabel.text];
    [clBatt addAttribute:NSForegroundColorAttributeName
                   value:[UIColor redColor]
                   range:NSMakeRange(6, self.battLabel.text.length - 6)];

    NSShadow *battShadow = [[NSShadow alloc] init];
    [dateShadow setShadowColor:[UIColor redColor]];
    [dateShadow setShadowOffset:CGSizeMake(0, 0)];
    [dateShadow setShadowBlurRadius:0.7];
    [clBatt addAttribute:NSShadowAttributeName
                   value:battShadow
                   range:NSMakeRange(6, self.battLabel.text.length - 6)];


    self.battLabel.attributedText = clBatt;
    self.battLabel.layer.shadowColor = [[UIColor labelColor] CGColor];
    self.battLabel.layer.shadowRadius = 0.5;
    self.battLabel.layer.shadowOpacity = 0.6;
    self.battLabel.layer.shadowOffset = CGSizeMake(0, 0);
    self.battLabel.layer.masksToBounds = false;
    [self.battLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.battLabel];

    NSString *IPAdrr = [self getIPAddress];
    self.IPLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 18)];
    self.IPLabel.textColor = cLabelColor;
    self.IPLabel.backgroundColor = [UIColor clearColor];
    self.IPLabel.text = [NSString stringWithFormat:@"[IP-Adrr] %@", IPAdrr];
    self.IPLabel.font = [UIFont fontWithName:@"Menlo" size:dF];
    self.IPLabel.adjustsFontSizeToFitWidth = true;
    // self.IPLabel.center = CGPointMake(self.superview.center.x + 20, 149);
    NSMutableAttributedString *clIP = [[NSMutableAttributedString alloc] initWithString:self.IPLabel.text];
    [clIP addAttribute:NSForegroundColorAttributeName
                 value:[UIColor systemTealColor]
                 range:NSMakeRange(9, self.IPLabel.text.length - 9)];

    NSShadow *IPShadow = [[NSShadow alloc] init];
    IPShadow.shadowColor = [UIColor systemTealColor];
    IPShadow.shadowOffset = CGSizeMake(0, 0);
    IPShadow.shadowBlurRadius = 0.7;
    [clIP addAttribute:NSShadowAttributeName
                 value:IPShadow
                 range:NSMakeRange(9, self.IPLabel.text.length - 9)];


    self.IPLabel.attributedText = clIP;
    self.IPLabel.layer.shadowColor = [[UIColor labelColor] CGColor];
    self.IPLabel.layer.shadowRadius = 0.5;
    self.IPLabel.layer.shadowOpacity = 0.6;
    self.IPLabel.layer.shadowOffset = CGSizeMake(0, 0);
    self.IPLabel.layer.masksToBounds = false;
    [self.IPLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.IPLabel];

    self.returnLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 18)];
    self.returnLabel.backgroundColor = [UIColor clearColor];
    self.returnLabel.textColor = cLabelColor;
    self.returnLabel.font = [UIFont fontWithName:@"Menlo" size:14];
    deviceName = [[UIDevice currentDevice] name];
    self.returnLabel.text = [NSString stringWithFormat:@"%@@host:~$", deviceName];
    self.returnLabel.adjustsFontSizeToFitWidth = true;
    // self.returnLabel.center = CGPointMake(self.superview.center.x + 20, 169);
    self.returnLabel.layer.shadowColor = [[UIColor labelColor] CGColor];
    self.returnLabel.layer.shadowRadius = 2.0;
    self.returnLabel.layer.shadowOpacity = 0.8;
    self.returnLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.returnLabel.numberOfLines = 0;
    self.returnLabel.layer.shadowOffset = CGSizeMake(0, 0);
    self.returnLabel.layer.masksToBounds = false;
    [self.returnLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.returnLabel];

    [self setupViews];
}

- (void)setupViews{
        // X
    if (TerminalPos) {
        [self.cmdLabel.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor constant:-20].active = YES;
        [self.upLabel.leadingAnchor constraintEqualToAnchor:self.cmdLabel.leadingAnchor constant:0].active = YES;
        [self.timeLabel.leadingAnchor constraintEqualToAnchor:self.upLabel.leadingAnchor constant:0].active = YES;
        [self.dateLabel.leadingAnchor constraintEqualToAnchor:self.timeLabel.leadingAnchor constant:0].active = YES;
        [self.battLabel.leadingAnchor constraintEqualToAnchor:self.dateLabel.leadingAnchor constant:0].active = YES;
        [self.IPLabel.leadingAnchor constraintEqualToAnchor:self.battLabel.leadingAnchor constant:0].active = YES;
        [self.returnLabel.leadingAnchor constraintEqualToAnchor:self.IPLabel.leadingAnchor constant:0].active = YES;
    }
    // Y
    [self.cmdLabel.centerYAnchor constraintEqualToAnchor:self.superview.centerYAnchor constant:-70].active = YES;
    [self.upLabel.centerYAnchor constraintEqualToAnchor:self.cmdLabel.centerYAnchor constant:24].active = YES;
    [self.timeLabel.centerYAnchor constraintEqualToAnchor:self.upLabel.centerYAnchor constant:24].active = YES;
    [self.dateLabel.centerYAnchor constraintEqualToAnchor:self.timeLabel.centerYAnchor constant:24].active = YES;
    [self.battLabel.centerYAnchor constraintEqualToAnchor:self.dateLabel.centerYAnchor constant:24].active = YES;
    [self.IPLabel.centerYAnchor constraintEqualToAnchor:self.battLabel.centerYAnchor constant:24].active = YES;
    [self.returnLabel.centerYAnchor constraintEqualToAnchor:self.IPLabel.centerYAnchor constant:24].active = YES;

}
@end
// // why not just put it in tweak.xm?
// void reloadTerminalPrefs() {
//     HBPreferences *TerminalPrefs = [[HBPreferences alloc] initWithIdentifier:@"com.1di4r.reachinfoprefs"];
//     TerminalPos = [([TerminalPrefs objectForKey:@"kTerminalPos"] ? : @(YES)) boolValue];
// }

// void TerminalPrefsChanged(
//     CFNotificationCenterRef center,
//     void *observer,
//     CFStringRef name,
//     const void *object,
//     CFDictionaryRef userInfo) {
//         reloadTerminalPrefs();
//     }

// %ctor {
//     reloadTerminalPrefs();
//     CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, TerminalPrefsChanged, CFSTR("com.1di4r.reachinfoprefs/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);
// }
