//
//  TheTwoastronauts.m
//  ReachInfo
//
//  Created by 1di4r on 7/31/20.
//  Copyright © 2020 1di4r. All rights reserved.
//

#import "RIAstro.h"

@implementation RIAstro

-(void)show{

if ([[NSFileManager defaultManager] fileExistsAtPath:fontPath]) {
            NSData *fontData = [NSData dataWithContentsOfFile:fontPath];
            NSLog(@"Font path: %@", fontPath);
            CFErrorRef error;
            CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
            CGFontRef font = CGFontCreateWithDataProvider(provider);
            if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
                CFStringRef errorDescription = CFErrorCopyDescription(error);
                NSLog(@"Failed to load font: %@", errorDescription);
                CFRelease(errorDescription);
            }
            fontName = (NSString *)CFBridgingRelease(CGFontCopyPostScriptName(font));

            CFRelease(font);
            CFRelease(provider);
        }

        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm"];
        NSString *timeString = [dateFormatter stringFromDate:date];
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 90)];
        self.dateLabel.textColor = [UIColor colorWithRed:203.0 / 255.0 green:205.0 / 255.0 blue:212.0 / 255.0 alpha:1];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        self.dateLabel.text = [NSString stringWithFormat:@"%@?", timeString];
        self.dateLabel.font = [UIFont fontWithName:fontName size:62];
        // [self.dateLabel setFont:[UIFont fontWithName:fontPath size:54]];
        // self.dateLabel.adjustsFontSizeToFitWidth = true;

        NSMutableAttributedString *fzDATE = [[NSMutableAttributedString alloc] initWithString:self.dateLabel.text];
        [fzDATE setAttributes:@{ NSFontAttributeName : [UIFont fontWithName:fontName size:17]
                                 , NSBaselineOffsetAttributeName : @30 } range:NSMakeRange(5, self.dateLabel.text.length - 5)];

        self.dateLabel.attributedText = fzDATE;
        // self.dateLabel.center = CGPointMake(self.superview.center.x, 115);
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        self.dateLabel.layer.masksToBounds = false;
        [self addSubview:self.dateLabel];

        self.astro1Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 108, 46)];
        self.astro1Label.backgroundColor = [UIColor clearColor];
        self.astro1Label.textColor = [UIColor colorWithRed:203.0 / 255.0 green:205.0 / 255.0 blue:212.0 / 255.0 alpha:1];
        self.astro1Label.font = [UIFont fontWithName:fontName size:15];
        self.astro1Label.text = @"Wait, it's";
        // self.astro1Label.adjustsFontSizeToFitWidth = true;
        // self.astro1Label.center = CGPointMake(self.superview.center.x + 21, 68);
        self.astro1Label.translatesAutoresizingMaskIntoConstraints = false;
        self.astro1Label.layer.masksToBounds = false;

        self.astro2Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 148, 46)];
        self.astro2Label.backgroundColor = [UIColor clearColor];
        self.astro2Label.textColor = [UIColor colorWithRed:203.0 / 255.0 green:205.0 / 255.0 blue:212.0 / 255.0 alpha:1];
        self.astro2Label.font = [UIFont fontWithName:fontName size:15];
        self.astro2Label.text = @"Always has been";
        // self.astro2Label.adjustsFontSizeToFitWidth = true;
        // self.astro2Label.center = CGPointMake(self.superview.center.x - 30, 152);
        self.astro2Label.translatesAutoresizingMaskIntoConstraints = false;
        self.astro2Label.layer.masksToBounds = false;
        [self addSubview:self.astro1Label];
        [self addSubview:self.astro2Label];


        self.astro1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 69, 84)];
        self.astro1.image = [UIImage imageNamed:astro1Path];
        self.astro1.contentMode = UIViewContentModeScaleAspectFit;
        // self.astro1.center = CGPointMake(self.superview.center.x - 52, 55);
        self.astro1.translatesAutoresizingMaskIntoConstraints = false;
        self.astro2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 83, 84)];
        self.astro2.image = [UIImage imageNamed:astro2Path];
        self.astro2.contentMode = UIViewContentModeScaleAspectFit;
        // self.astro2.center = CGPointMake(self.superview.center.x + 48, 160);
        self.astro2.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:self.astro1];
        [self addSubview:self.astro2];


        [self setupViews];
}

- (void)setupViews {
// self.dateLabel
// self.astro1
// self.astro2
// self.astro1Label
// self.astro2Label

    [self.dateLabel.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor constant:0].active = YES;
    [self.dateLabel.centerYAnchor constraintEqualToAnchor:self.superview.centerYAnchor constant:0].active = YES;

    [self.astro1Label.centerXAnchor constraintEqualToAnchor:self.dateLabel.centerXAnchor constant:11].active = YES;
    [self.astro1Label.centerYAnchor constraintEqualToAnchor:self.dateLabel.centerYAnchor constant:-43].active = YES;

    [self.astro2Label.centerXAnchor constraintEqualToAnchor:self.dateLabel.centerXAnchor constant:-37].active = YES;
    [self.astro2Label.centerYAnchor constraintEqualToAnchor:self.dateLabel.centerYAnchor constant:38].active = YES;

    [self.astro1.centerXAnchor constraintEqualToAnchor:self.dateLabel.centerXAnchor constant:-52].active = YES;
    [self.astro1.centerYAnchor constraintEqualToAnchor:self.dateLabel.centerYAnchor constant:-64].active = YES;
    [self.astro1.widthAnchor constraintEqualToConstant:73].active = YES;
    [self.astro1.heightAnchor constraintEqualToConstant:90].active = YES;

    [self.astro2.centerXAnchor constraintEqualToAnchor:self.dateLabel.centerXAnchor constant:+50].active = YES;
    [self.astro2.centerYAnchor constraintEqualToAnchor:self.dateLabel.centerYAnchor constant:45].active = YES;
    [self.astro2.widthAnchor constraintEqualToConstant:77].active = YES;
    [self.astro2.heightAnchor constraintEqualToConstant:94].active = YES;

}

@end
