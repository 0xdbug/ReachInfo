//
//  getEvents.h
//  ReachInfo
//
//  Created by 1di4r on 1/27/21.
//  Copyright © 2021 1di4r. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface getEvents : NSObject
+ (NSString *)Events:(NSString *)Event from:(int)days;
@end

NSString *reminderCon;
NSString *reminderDateS;
NSString *EventDateS;
