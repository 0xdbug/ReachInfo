//
//  RIReminders.m
//  ReachInfo
//
//  Created by 1di4r on 12/9/20.
//

#import "RIReminders.h"

@implementation RIReminders

- (void)show{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:@"ReachInfo/UpdateLabel"
    object:nil];

    self.remindersLabel = [UILabel new];
    self.remindersLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.remindersLabel.text = @"Reminders";
    self.remindersLabel.adjustsFontSizeToFitWidth = YES;
    self.remindersLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    //self.remindersLabel.backgroundColor = [UIColor redColor];
    
    self.remindersView = [[UIView alloc] init];
    self.remindersView.translatesAutoresizingMaskIntoConstraints = NO;
    self.remindersView.backgroundColor = [UIColor secondarySystemBackgroundColor];
    self.remindersView.layer.cornerRadius = 5;
    [self addSubview:self.remindersLabel];
    [self addSubview:self.remindersView];
    
    self.remindersContent = [UILabel new];
    self.remindersContent.translatesAutoresizingMaskIntoConstraints = NO;
    self.remindersContent.text = [getEvents Events:@"reminders" from:30]; // made a custom method to make it cleaner
    self.remindersContent.numberOfLines = 1;
    self.remindersContent.adjustsFontSizeToFitWidth = NO;
    self.remindersContent.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    //self.remindersContent.backgroundColor = [UIColor blueColor];
    
    [self.remindersView addSubview:self.remindersContent];
    
    self.remindersDate = [UILabel new];
    self.remindersDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.remindersDate.text = reminderDateS;
    self.remindersDate.textAlignment = NSTextAlignmentRight;
    self.remindersDate.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    self.remindersDate.textColor = [UIColor systemGrayColor];
    //self.remindersDate.backgroundColor = [UIColor redColor];
    
    [self.remindersView addSubview:self.remindersDate];
    
    self.EventLabel = [UILabel new];
    self.EventLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.EventLabel.text = @"Events";
    self.EventLabel.adjustsFontSizeToFitWidth = YES;
    self.EventLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    //self.remindersLabel.backgroundColor = [UIColor redColor];
    
    
    self.EventView = [[UIView alloc] init];
    self.EventView.translatesAutoresizingMaskIntoConstraints = NO;
    self.EventView.backgroundColor = [UIColor secondarySystemBackgroundColor];
    self.EventView.layer.cornerRadius = 5;
    [self addSubview:self.EventLabel];
    [self addSubview:self.EventView];
    
    self.EventContent = [UILabel new];
    self.EventContent.translatesAutoresizingMaskIntoConstraints = NO;
    self.EventContent.text = [getEvents Events:@"events" from:30]; // we call our custom method again, this time we want events
    self.EventContent.numberOfLines = 1;
    self.EventContent.adjustsFontSizeToFitWidth = NO;
    self.EventContent.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    //self.remindersContent.backgroundColor = [UIColor blueColor];
    [self.EventView addSubview:self.EventContent];
    
    self.EventDate = [UILabel new];
    self.EventDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.EventDate.text = EventDateS;
    self.EventDate.textAlignment = NSTextAlignmentRight;
    self.EventDate.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    self.EventDate.textColor = [UIColor systemGrayColor];
    //self.remindersDate.backgroundColor = [UIColor redColor];
    [self.EventView addSubview:self.EventDate];

    [self setupViews];
    
}
- (void)updateLabel{ // yes
    self.remindersContent.text = reminderCon;
}
- (void)setupViews{ // Setting up views and constraints
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.centerYAnchor constraintEqualToAnchor:self.superview.centerYAnchor constant:-70].active = YES;
    [self.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;


    [self.remindersLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.remindersLabel.widthAnchor constraintEqualToConstant:self.bounds.size.width - 20].active = YES;
    [self.remindersLabel.heightAnchor constraintEqualToConstant:21].active = YES;
    [self.remindersLabel.centerYAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [self.remindersLabel.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;
    
    [self.remindersView.widthAnchor constraintEqualToConstant:self.bounds.size.width - 20].active = YES;
    [self.remindersView.heightAnchor constraintEqualToConstant:45].active = YES;
    [self.remindersView.centerYAnchor constraintEqualToAnchor:self.remindersLabel.bottomAnchor constant:28].active = YES;
    [self.remindersView.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;
    
    [self.remindersContent setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.remindersContent.widthAnchor constraintEqualToConstant:self.bounds.size.width - 20].active = YES;
    [self.remindersContent.centerYAnchor constraintEqualToAnchor:self.remindersView.centerYAnchor constant:0].active = YES;
    [self.remindersContent.centerXAnchor constraintEqualToAnchor:self.remindersView.centerXAnchor constant:10].active = YES;
    
    [self.remindersDate setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.remindersDate.widthAnchor constraintEqualToConstant:100].active = YES;
    [self.remindersDate.centerYAnchor constraintEqualToAnchor:self.remindersView.centerYAnchor constant:0].active = YES;
    //[self.EventDate.centerXAnchor constraintEqualToAnchor:self.EventView.trailingAnchor constant:-40].active = YES;
    [self.remindersDate.trailingAnchor constraintEqualToAnchor:self.remindersView.trailingAnchor constant:-20].active = YES;
    
    
    [self.EventLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.EventLabel.widthAnchor constraintEqualToConstant:self.bounds.size.width - 20].active = YES;
    [self.EventLabel.heightAnchor constraintEqualToConstant:21].active = YES;
    [self.EventLabel.centerYAnchor constraintEqualToAnchor:self.remindersView.bottomAnchor constant:30].active = YES;
    [self.EventLabel.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;
    
    [self.EventView.widthAnchor constraintEqualToConstant:self.bounds.size.width - 20].active = YES;
    [self.EventView.heightAnchor constraintEqualToConstant:45].active = YES;
    [self.EventView.centerYAnchor constraintEqualToAnchor:self.EventLabel.bottomAnchor constant:28].active = YES;
    [self.EventView.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;
    
    [self.EventContent setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.EventContent.widthAnchor constraintEqualToConstant:self.bounds.size.width - 20].active = YES;
    [self.EventContent.centerYAnchor constraintEqualToAnchor:self.EventView.centerYAnchor constant:0].active = YES;
    [self.EventContent.centerXAnchor constraintEqualToAnchor:self.EventView.centerXAnchor constant:10].active = YES;
    
    [self.EventDate setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.EventDate.widthAnchor constraintEqualToConstant:100].active = YES;
    [self.EventDate.centerYAnchor constraintEqualToAnchor:self.EventView.centerYAnchor constant:0].active = YES;
    //[self.EventDate.centerXAnchor constraintEqualToAnchor:self.EventView.trailingAnchor constant:-40].active = YES;
    [self.EventDate.trailingAnchor constraintEqualToAnchor:self.EventView.trailingAnchor constant:-20].active = YES;
}

- (void)dealloc{ [[NSNotificationCenter defaultCenter] removeObserver:self]; }

@end