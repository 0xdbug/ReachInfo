//
//  getEvents.m
//  ReachInfo
//
//  Created by 1di4r on 1/27/21.
//  Copyright © 2021 1di4r. All rights reserved.
//

#import "getEvents.h"

@implementation getEvents

+(NSString *)Events:(NSString *)Event from:(int)days{
    
    EKEventStore *store = [[EKEventStore alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *todayComp = [[NSDateComponents alloc] init];
    todayComp.day = -1;
    NSDate *today = [calendar dateByAddingComponents:todayComp toDate:[NSDate date] options:0];

    NSDateComponents *daysFromNowComp = [[NSDateComponents alloc] init];
    daysFromNowComp.day = days;
    NSDate *daysFromNow = [calendar dateByAddingComponents:daysFromNowComp toDate:[NSDate date] options:0];

    NSPredicate *calendarPredicate = [store predicateForEventsWithStartDate:today endDate:daysFromNow calendars:nil];

    NSArray *events = [store eventsMatchingPredicate:calendarPredicate];
    NSPredicate *reminderPredicate = [store predicateForIncompleteRemindersWithDueDateStarting:today ending:daysFromNow calendars:nil];

    if ([Event isEqualToString:@"events"]){ // if we wanted events
        if ([events count]) {
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES] ;
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedEvents = [events sortedArrayUsingDescriptors:sortDescriptors];

            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"MMM, d";
            EventDateS = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[sortedEvents[0] startDate]]];            
            return [NSString stringWithFormat:@"%@", [sortedEvents[0] title]];
            
        }
        EventDateS = @" ";
        return @"No Upcoming Events";

    }else if ([Event isEqualToString:@"reminders"]){ // if we wanted reminders
        [store fetchRemindersMatchingPredicate:reminderPredicate completion:^(NSArray* reminders) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if ([reminders count]) {

                    // sort the reminders array so we get the nearest one from the current date
                    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dueDate" ascending:YES] ;
                    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
                    NSArray *sortedReminders = [reminders sortedArrayUsingDescriptors:sortDescriptors];

                    NSCalendar *cal = [NSCalendar currentCalendar];
                    NSDate *remDate = [cal dateFromComponents:[sortedReminders[0] dueDateComponents]];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    formatter.dateFormat = @"E, d MMM";

                    reminderDateS = [NSString stringWithFormat:@"%@", [formatter stringFromDate:remDate]];
                    if ([cal isDateInToday:remDate]) reminderDateS = @"Today";
                    if ([cal isDateInTomorrow:remDate]) reminderDateS = @"Tomorrow";

                    reminderCon = [NSString stringWithFormat:@"%@", [sortedReminders[0] title]];
                    dispatch_async(dispatch_get_main_queue(),^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReachInfo/UpdateLabel" 
                        object:self];     
                    });            
                } else{
                    reminderCon = @"No Upcoming Reminders";
                    reminderDateS = @" ";
                    dispatch_async(dispatch_get_main_queue(),^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReachInfo/UpdateLabel" 
                        object:self];
                    });
                }
            }];
        }];
        return reminderCon;
    }else{ // this will never happen.....probably
        return @"Error or something idk DM me @1di4r";
    }
    
}


@end
