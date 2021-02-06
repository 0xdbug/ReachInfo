//
//  RIReminders.m
//  ReachInfo
//
//  Created by 1di4r on 12/9/20.
//

#import "RIReminders.h"

@implementation RIReminders
-(void)show{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:@"ReachInfo/UpdateLabel"
    object:nil];

    _remindersLabel = [UILabel new];
    _remindersLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _remindersLabel.text = @"Reminders";
    _remindersLabel.adjustsFontSizeToFitWidth = YES;
    _remindersLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    //_remindersLabel.backgroundColor = [UIColor redColor];
    
    
    _remindersView = [[UIView alloc] init];
    _remindersView.translatesAutoresizingMaskIntoConstraints = NO;
    _remindersView.backgroundColor = [UIColor secondarySystemBackgroundColor];
    _remindersView.layer.cornerRadius = 5;
    
    [self addSubview:_remindersLabel];
    [self addSubview:_remindersView];
    
    _remindersContent = [UILabel new];
    _remindersContent.translatesAutoresizingMaskIntoConstraints = NO;
    _remindersContent.text = [getEvents Events:@"reminders" from:30]; // made a custom method to make it cleaner
    _remindersContent.numberOfLines = 1;
    _remindersContent.adjustsFontSizeToFitWidth = NO;
    _remindersContent.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    //_remindersContent.backgroundColor = [UIColor blueColor];
    
    [_remindersView addSubview:_remindersContent];
    
    _remindersDate = [UILabel new];
    _remindersDate.translatesAutoresizingMaskIntoConstraints = NO;
    _remindersDate.text = reminderDateS;
    _remindersDate.textAlignment = NSTextAlignmentRight;
    _remindersDate.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    _remindersDate.textColor = [UIColor systemGrayColor];
    //_remindersDate.backgroundColor = [UIColor redColor];
    
    [_remindersView addSubview:_remindersDate];
    
    _EventLabel = [UILabel new];
    _EventLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _EventLabel.text = @"Events";
    _EventLabel.adjustsFontSizeToFitWidth = YES;
    _EventLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    //_remindersLabel.backgroundColor = [UIColor redColor];
    
    
    _EventView = [[UIView alloc] init];
    _EventView.translatesAutoresizingMaskIntoConstraints = NO;
    _EventView.backgroundColor = [UIColor secondarySystemBackgroundColor];
    _EventView.layer.cornerRadius = 5;
    
    [self addSubview:_EventLabel];
    [self addSubview:_EventView];
    
    _EventContent = [UILabel new];
    _EventContent.translatesAutoresizingMaskIntoConstraints = NO;
    _EventContent.text = [getEvents Events:@"events" from:30]; // we call our custom method again, this time we want events
    _EventContent.numberOfLines = 1;
    _EventContent.adjustsFontSizeToFitWidth = NO;
    _EventContent.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    //_remindersContent.backgroundColor = [UIColor blueColor];
    
    [_EventView addSubview:_EventContent];
    
    _EventDate = [UILabel new];
    _EventDate.translatesAutoresizingMaskIntoConstraints = NO;
    _EventDate.text = EventDateS;
    _EventDate.textAlignment = NSTextAlignmentRight;
    _EventDate.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    _EventDate.textColor = [UIColor systemGrayColor];
    //_remindersDate.backgroundColor = [UIColor redColor];
    
    [_EventView addSubview:_EventDate];
    [self setupViews];
    
}
-(void)updateLabel{ // yes
    _remindersContent.text = reminderCon;
}
-(void)setupViews{ // Setting up views and constraints
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.centerYAnchor constraintEqualToAnchor:self.superview.centerYAnchor constant:-70].active = YES;
    [self.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;


    [_remindersLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_remindersLabel.widthAnchor constraintEqualToConstant:self.bounds.size.width - 20].active = YES;
    [_remindersLabel.heightAnchor constraintEqualToConstant:21].active = YES;
    [_remindersLabel.centerYAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    [_remindersLabel.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;
    
    [_remindersView.widthAnchor constraintEqualToConstant:self.bounds.size.width - 20].active = YES;
    [_remindersView.heightAnchor constraintEqualToConstant:45].active = YES;
    [_remindersView.centerYAnchor constraintEqualToAnchor:_remindersLabel.bottomAnchor constant:28].active = YES;
    [_remindersView.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;
    
    [_remindersContent setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_remindersContent.widthAnchor constraintEqualToConstant:self.bounds.size.width - 20].active = YES;
    [_remindersContent.centerYAnchor constraintEqualToAnchor:_remindersView.centerYAnchor constant:0].active = YES;
    [_remindersContent.centerXAnchor constraintEqualToAnchor:_remindersView.centerXAnchor constant:10].active = YES;
    
    [_remindersDate setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_remindersDate.widthAnchor constraintEqualToConstant:100].active = YES;
    [_remindersDate.centerYAnchor constraintEqualToAnchor:_remindersView.centerYAnchor constant:0].active = YES;
    //[_EventDate.centerXAnchor constraintEqualToAnchor:_EventView.trailingAnchor constant:-40].active = YES;
    [_remindersDate.trailingAnchor constraintEqualToAnchor:_remindersView.trailingAnchor constant:-20].active = YES;
    
    
    [_EventLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_EventLabel.widthAnchor constraintEqualToConstant:self.bounds.size.width - 20].active = YES;
    [_EventLabel.heightAnchor constraintEqualToConstant:21].active = YES;
    [_EventLabel.centerYAnchor constraintEqualToAnchor:_remindersView.bottomAnchor constant:30].active = YES;
    [_EventLabel.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;
    
    [_EventView.widthAnchor constraintEqualToConstant:self.bounds.size.width - 20].active = YES;
    [_EventView.heightAnchor constraintEqualToConstant:45].active = YES;
    [_EventView.centerYAnchor constraintEqualToAnchor:_EventLabel.bottomAnchor constant:28].active = YES;
    [_EventView.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor].active = YES;
    
    [_EventContent setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_EventContent.widthAnchor constraintEqualToConstant:self.bounds.size.width - 20].active = YES;
    [_EventContent.centerYAnchor constraintEqualToAnchor:_EventView.centerYAnchor constant:0].active = YES;
    [_EventContent.centerXAnchor constraintEqualToAnchor:_EventView.centerXAnchor constant:10].active = YES;
    
    [_EventDate setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_EventDate.widthAnchor constraintEqualToConstant:100].active = YES;
    [_EventDate.centerYAnchor constraintEqualToAnchor:_EventView.centerYAnchor constant:0].active = YES;
    //[_EventDate.centerXAnchor constraintEqualToAnchor:_EventView.trailingAnchor constant:-40].active = YES;
    [_EventDate.trailingAnchor constraintEqualToAnchor:_EventView.trailingAnchor constant:-20].active = YES;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end