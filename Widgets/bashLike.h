//
//  bashLike.h
//  ReachInfo
//
//  Created by 1di4r on 7/31/20.
//  Copyright © 2020 1di4r. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <sys/sysctl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface bashLike : UIView
-(void)show;
-(NSTimeInterval)uptime;
-(NSString *)getIPAddress;
@end

NSString *deviceName;
