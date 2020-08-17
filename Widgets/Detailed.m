//
//  Detailed.m
//  ReachInfo
//
//  Created by 1di4r on 7/31/20.
//  Copyright © 2020 1di4r. All rights reserved.
//

#import "Detailed.h"


@implementation Detailed : Widget

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

    UILabel *MEMLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RIView.frame.size.width, 28)];
    MEMLabel.backgroundColor = [UIColor clearColor];
    MEMLabel.textColor = [UIColor colorWithRed:203/255.0 green:205/255.0 blue:212/255.0 alpha:0.93];
    MEMLabel.font = [UIFont fontWithName:fontName size:19];
    MEMLabel.text = [NSString stringWithFormat:@"Memory (RAM)"];
    MEMLabel.adjustsFontSizeToFitWidth = true;
    MEMLabel.center = CGPointMake(RIView.center.x + 16, 35);
    
    NSString *totalMemory = [NSString stringWithFormat:@"%f", [SSMemoryInfo totalMemory]];
    UILabel *MTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RIView.frame.size.width, 29)];
    MTotalLabel.backgroundColor = [UIColor clearColor];
    MTotalLabel.textColor = [UIColor systemTealColor];
    MTotalLabel.font = [UIFont fontWithName:fontName size:29];
    MTotalLabel.text = [NSString stringWithFormat:@"•Total: %@ MB", [totalMemory substringToIndex:[totalMemory length] - 4]];
    MTotalLabel.center = CGPointMake(RIView.center.x + 16, 65);
    NSMutableAttributedString *clTT = [[NSMutableAttributedString alloc] initWithString:MTotalLabel.text];
    [clTT addAttribute:NSForegroundColorAttributeName
        value:[UIColor colorWithRed:203/255.0 green:205/255.0 blue:212/255.0 alpha:0.93]
        range:NSMakeRange(1, MTotalLabel.text.length - 1)];
    [clTT addAttributes:@{ NSFontAttributeName : [UIFont fontWithName:fontName size:14]
        , NSBaselineOffsetAttributeName : @6 } range:NSMakeRange(1, MTotalLabel.text.length - 1)];

    MTotalLabel.attributedText = clTT;

    NSString *activeMemoryRaw = [NSString stringWithFormat:@"%f", [SSMemoryInfo activeMemory:NO]];
    NSString *activeMemoryPercent = [NSString stringWithFormat:@"%f", [SSMemoryInfo activeMemory:YES]];
    UILabel *MActiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RIView.frame.size.width, 29)];
    MActiveLabel.backgroundColor = [UIColor clearColor];
    MActiveLabel.textColor = [UIColor systemTealColor];
    MActiveLabel.font = [UIFont fontWithName:fontName size:29];
    MActiveLabel.text = [NSString stringWithFormat:@"•Active: %@%% %@ MB", [activeMemoryPercent substringToIndex:[activeMemoryPercent length] - 5], [activeMemoryRaw substringToIndex:[activeMemoryRaw length] - 4]];
    MActiveLabel.center = CGPointMake(RIView.center.x + 16, 81);
    NSMutableAttributedString *clAM = [[NSMutableAttributedString alloc] initWithString:MActiveLabel.text];
    [clAM addAttribute:NSForegroundColorAttributeName
        value:[UIColor colorWithRed:203/255.0 green:205/255.0 blue:212/255.0 alpha:0.93]
        range:NSMakeRange(1, MActiveLabel.text.length - 1)];
    [clAM addAttributes:@{ NSFontAttributeName : [UIFont fontWithName:fontName size:14]
        , NSBaselineOffsetAttributeName : @6 } range:NSMakeRange(1, MActiveLabel.text.length - 1)];

    MActiveLabel.attributedText = clAM;


    NSString *freeMemoryRaw = [NSString stringWithFormat:@"%f", [SSMemoryInfo freeMemory:NO]];
    NSString *freeMemoryPercent = [NSString stringWithFormat:@"%f", [SSMemoryInfo freeMemory:YES]];
    UILabel *MFreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RIView.frame.size.width, 29)];
    MFreeLabel.backgroundColor = [UIColor clearColor];
    MFreeLabel.textColor = [UIColor systemTealColor];
    MFreeLabel.font = [UIFont fontWithName:fontName size:29];
    MFreeLabel.text = [NSString stringWithFormat:@"•Free: %@%% %@ MB", [freeMemoryPercent substringToIndex:[freeMemoryPercent length] - 5], [freeMemoryRaw substringToIndex:[freeMemoryRaw length] - 4]];
    MFreeLabel.center = CGPointMake(RIView.center.x + 16, 97);
    NSMutableAttributedString *clFM = [[NSMutableAttributedString alloc] initWithString:MFreeLabel.text];
    [clFM addAttribute:NSForegroundColorAttributeName
        value:[UIColor colorWithRed:203/255.0 green:205/255.0 blue:212/255.0 alpha:0.93]
        range:NSMakeRange(1, MFreeLabel.text.length - 1)];
    [clFM addAttributes:@{ NSFontAttributeName : [UIFont fontWithName:fontName size:14]
        , NSBaselineOffsetAttributeName : @6 } range:NSMakeRange(1, MFreeLabel.text.length - 1)];

    MFreeLabel.attributedText = clFM;

#pragma mark Storage

    UILabel *STLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RIView.frame.size.width, 28)];
    STLabel.backgroundColor = [UIColor clearColor];
    STLabel.textColor = [UIColor colorWithRed:203/255.0 green:205/255.0 blue:212/255.0 alpha:0.93];
    STLabel.font = [UIFont fontWithName:fontName size:19];
    STLabel.text = [NSString stringWithFormat:@"Storage"];
    STLabel.adjustsFontSizeToFitWidth = true;
    STLabel.center = CGPointMake(RIView.center.x + 16, 121);

    UILabel *STotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RIView.frame.size.width, 29)];
    STotalLabel.backgroundColor = [UIColor clearColor];
    STotalLabel.textColor = [UIColor systemTealColor];
    STotalLabel.font = [UIFont fontWithName:fontName size:29];
    STotalLabel.text = [NSString stringWithFormat:@"•Total: %@", [SSDiskInfo diskSpace]];
    STotalLabel.center = CGPointMake(RIView.center.x + 16, 151);
    NSMutableAttributedString *clTS = [[NSMutableAttributedString alloc] initWithString:STotalLabel.text];
    [clTS addAttribute:NSForegroundColorAttributeName
        value:[UIColor colorWithRed:203/255.0 green:205/255.0 blue:212/255.0 alpha:0.93]
        range:NSMakeRange(1, STotalLabel.text.length - 1)];
    [clTS addAttributes:@{ NSFontAttributeName : [UIFont fontWithName:fontName size:14]
        , NSBaselineOffsetAttributeName : @6 } range:NSMakeRange(1, STotalLabel.text.length - 1)];

    STotalLabel.attributedText = clTS;

    UILabel *SUsedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, RIView.frame.size.width, 29)];
    SUsedLabel.backgroundColor = [UIColor clearColor];
    SUsedLabel.textColor = [UIColor systemTealColor];
    SUsedLabel.font = [UIFont fontWithName:fontName size:29];
    SUsedLabel.text = [NSString stringWithFormat:@"•Used: %@", [SSDiskInfo usedDiskSpace:YES]];
    SUsedLabel.center = CGPointMake(RIView.center.x + 16, 167);
    NSMutableAttributedString *clUS = [[NSMutableAttributedString alloc] initWithString:SUsedLabel.text];
    [clUS addAttribute:NSForegroundColorAttributeName
        value:[UIColor colorWithRed:203/255.0 green:205/255.0 blue:212/255.0 alpha:0.93]
        range:NSMakeRange(1, SUsedLabel.text.length - 1)];
    [clUS addAttributes:@{ NSFontAttributeName : [UIFont fontWithName:fontName size:14]
        , NSBaselineOffsetAttributeName : @6 } range:NSMakeRange(1, SUsedLabel.text.length - 1)];

    SUsedLabel.attributedText = clUS;

    UIProgressView *progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    float usedDiskSpace = [[SSDiskInfo usedDiskSpace:YES] floatValue] / 100;
    progressBar.progress = usedDiskSpace;
    progressBar.tintColor = [UIColor systemTealColor];
    progressBar.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.1];
    progressBar.layer.cornerRadius = 2;
    progressBar.clipsToBounds = true;
    progressBar.layer.masksToBounds = true;
    progressBar.frame = CGRectMake(0, 0, 200, 0);
    progressBar.center = CGPointMake(RIView.center.x - 52, 183);


    [RIView addSubview:MEMLabel];
    [RIView addSubview:MTotalLabel];
    [RIView addSubview:MActiveLabel];
    [RIView addSubview:MFreeLabel];
    [RIView addSubview:STLabel];
    [RIView addSubview:STotalLabel];
    [RIView addSubview:SUsedLabel];
    [RIView addSubview:progressBar];



}

@end
