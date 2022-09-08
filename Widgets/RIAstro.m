//
//  TheTwoAstronauts.m
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
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 192, 82)];
        dateLabel.textColor = [UIColor colorWithRed:203.0 / 255.0 green:205.0 / 255.0 blue:212.0 / 255.0 alpha:1];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.text = [NSString stringWithFormat:@"%@?", timeString];
        dateLabel.font = [UIFont fontWithName:fontName size:54];
        // [dateLabel setFont:[UIFont fontWithName:fontPath size:54]];
        // dateLabel.adjustsFontSizeToFitWidth = true;

        NSMutableAttributedString *fzDATE = [[NSMutableAttributedString alloc] initWithString:dateLabel.text];
        [fzDATE setAttributes:@{ NSFontAttributeName : [UIFont fontWithName:fontName size:17]
                                 , NSBaselineOffsetAttributeName : @30 } range:NSMakeRange(5, dateLabel.text.length - 5)];

        dateLabel.attributedText = fzDATE;
        dateLabel.center = CGPointMake(self.superview.center.x, 115);
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.layer.masksToBounds = false;

        UIImageView *firstAstronaut = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 69, 84)];
        firstAstronaut.image = [UIImage imageNamed:firstAstronautPath];
        firstAstronaut.contentMode = UIViewContentModeScaleAspectFit;
        firstAstronaut.center = CGPointMake(self.superview.center.x - 52, 55);
        UIImageView *secondAstronaut = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 83, 84)];
        secondAstronaut.image = [UIImage imageNamed:secondAstronautPath];
        secondAstronaut.contentMode = UIViewContentModeScaleAspectFit;
        secondAstronaut.center = CGPointMake(self.superview.center.x + 48, 160);

        UILabel *firstAstroLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 38)];
        firstAstroLabel.backgroundColor = [UIColor clearColor];
        firstAstroLabel.textColor = [UIColor colorWithRed:203.0 / 255.0 green:205.0 / 255.0 blue:212.0 / 255.0 alpha:1];
        firstAstroLabel.font = [UIFont fontWithName:fontName size:14];
        firstAstroLabel.text = @"Wait, it's";
        // firstAstroLabel.adjustsFontSizeToFitWidth = true;
        firstAstroLabel.center = CGPointMake(self.superview.center.x + 21, 68);
        firstAstroLabel.layer.masksToBounds = false;

        UILabel *secondAstroLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 38)];
        secondAstroLabel.backgroundColor = [UIColor clearColor];
        secondAstroLabel.textColor = [UIColor colorWithRed:203.0 / 255.0 green:205.0 / 255.0 blue:212.0 / 255.0 alpha:1];
        secondAstroLabel.font = [UIFont fontWithName:fontName size:14];
        secondAstroLabel.text = @"Always has been";
        // secondAstroLabel.adjustsFontSizeToFitWidth = true;
        secondAstroLabel.center = CGPointMake(self.superview.center.x - 30, 152);
        secondAstroLabel.layer.masksToBounds = false;


        [self addSubview:dateLabel];
        [self addSubview:firstAstronaut];
        [self addSubview:secondAstronaut];
        [self addSubview:firstAstroLabel];
        [self addSubview:secondAstroLabel];
}


@end
