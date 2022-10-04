//
//  WeatherDataView.m
//  ReachInfo
//
//  Created by 1di4r on 1/26/21.
//  Copyright © 2021 1di4r. All rights reserved.
//

#import "WeatherDataView.h"
FOUNDATION_EXPORT NSLocaleKey const NSLocaleTemperatureUnit;

@implementation WeatherDataView

-(void)configColors {
    if (ForceDM) {
        cLabelColor = [UIColor whiteColor];
        cSecondaryLabelColor = [UIColor colorWithRed: 0.92 green: 0.92 blue: 0.96 alpha: 0.6];
        cSecondaryBG = [UIColor colorWithRed: 0.11 green: 0.11 blue: 0.12 alpha: 1.00];
    }else {
        cLabelColor = [UIColor labelColor];
        cSecondaryLabelColor = [UIColor secondaryLabelColor];
        cSecondaryBG =[UIColor secondarySystemBackgroundColor];
    }
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configColors];
        self.backgroundColor = cSecondaryBG;
        self.layer.cornerRadius = 10;
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.clipsToBounds = YES;

    }
    return self;
}

- (void)didMoveToWindow{

    // MARK: weatherDataView
    [self.heightAnchor constraintEqualToConstant:60].active = YES;
    [self.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor constant:0].active = YES;
    [self.widthAnchor constraintEqualToAnchor:self.superview.widthAnchor constant:-20].active = YES;

}

- (void)dataView{

    [[PDDokdo sharedInstance] refreshWeatherData];
    NSDictionary *weatherData = [[PDDokdo sharedInstance] weatherData];

    NSString *tempUnit = [[[NSLocale currentLocale] objectForKey:NSLocaleTemperatureUnit] stringValue];
    NSDictionary *units = @{@"Celsius" : @0, @"Fahrenheit" : @1};

    NSDate *sunrise = [weatherData objectForKey:@"sunrise"];
    NSDate *sunset = [weatherData objectForKey:@"sunset"];

    NSString *highTemperature = [[PDDokdo sharedInstance] highestTemperatureIn:[[units objectForKey: tempUnit] intValue]];
    NSString *lowTemperature = [[PDDokdo sharedInstance] lowestTemperatureIn:[[units objectForKey: tempUnit] intValue]];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];


    // MARK: lowTempLabel
    self.lowTempLabel = [UILabel new];
    self.lowTempLabel.text = @"lowTemp";
    self.lowTempLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
    self.lowTempLabel.textColor = cSecondaryLabelColor;
    //self.lowTempLabel.backgroundColor = [UIColor redColor];
    [self.lowTempLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.lowTempLabel];
    self.lowTempValue = [UILabel new];
    self.lowTempValue.text = lowTemperature;
    self.lowTempValue.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    self.lowTempValue.textColor = cLabelColor;
    //self.lowTempValue.backgroundColor = [UIColor redColor];
    [self.lowTempValue setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.lowTempValue.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.lowTempValue];

    // MARK:highestTemp
    self.highTempLabel = [UILabel new];
    self.highTempLabel.text = @"highTemp";
    self.highTempLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
    self.highTempLabel.textColor = cSecondaryLabelColor;
    //self.highTempLabel.backgroundColor = [UIColor redColor];
    [self.highTempLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.highTempLabel];
    self.highTempValue = [UILabel new];
    self.highTempValue.text = highTemperature;
    self.highTempValue.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    self.highTempValue.textColor = cLabelColor;
    //self.highTempValue.backgroundColor = [UIColor redColor];
    [self.highTempValue setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.highTempValue.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.highTempValue];

    //MARK: sunrise
    self.sunriseView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"sunrise"]];
    self.sunriseView.tintColor = cLabelColor;
    [self.sunriseView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.sunriseView];
    self.sunriseLabel = [UILabel new];
    self.sunriseLabel.text = [formatter stringFromDate:sunrise];
    self.sunriseLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
    self.sunriseLabel.textColor = cSecondaryLabelColor;
    //self.sunriseView.backgroundColor = [UIColor redColor];
    self.sunriseView.contentMode = UIViewContentModeScaleAspectFit;
    [self.sunriseLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.sunriseLabel];

    //MARK: sunset
    self.sunsetView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"sunset"]];
    self.sunsetView.tintColor = cLabelColor;
    [self.sunsetView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.sunsetView];
    self.sunsetLabel = [UILabel new];
    self.sunsetLabel.text = [formatter stringFromDate:sunset];
    self.sunsetLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
    self.sunsetLabel.textColor = cSecondaryLabelColor;
    //self.sunsetView.backgroundColor = [UIColor redColor];
    self.sunsetView.contentMode = UIViewContentModeScaleAspectFit;
    [self.sunsetLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.sunsetLabel];

    [self setupViews];

}

- (void)setupViews{
    // MARK: highTempLabel
    [self.highTempLabel.centerYAnchor constraintEqualToAnchor:self.bottomAnchor constant:-13].active = YES;
    [self.highTempLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:15].active = YES;

    [self.highTempValue.centerYAnchor constraintEqualToAnchor:self.highTempLabel.topAnchor constant:-15].active = YES;
    [self.highTempValue.centerXAnchor constraintEqualToAnchor:self.highTempLabel.centerXAnchor constant:0].active = YES;
    //[self.highTempValue.widthAnchor constraintEqualToConstant:50].active = YES;

    // MARK: lowTempLabel
    [self.lowTempLabel.centerYAnchor constraintEqualToAnchor:self.bottomAnchor constant:-13].active = YES;
    [self.lowTempLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor constant:-50].active = YES;
    //[self.lowTempLabel.leadingAnchor constraintEqualToAnchor:self.highTempLabel.trailingAnchor constant:10].active = YES;

    [self.lowTempValue.centerYAnchor constraintEqualToAnchor:self.lowTempLabel.topAnchor constant:-15].active = YES;
    [self.lowTempValue.centerXAnchor constraintEqualToAnchor:self.lowTempLabel.centerXAnchor constant:0].active = YES;

    // MARK: sunrise
    [self.sunriseLabel.centerYAnchor constraintEqualToAnchor:self.bottomAnchor constant:-13].active = YES;
    [self.sunriseLabel.trailingAnchor constraintEqualToAnchor:self.sunsetLabel.leadingAnchor constant:-50].active = YES;

    [self.sunriseView.centerYAnchor constraintEqualToAnchor:self.sunriseLabel.topAnchor constant:-15].active = YES;
    [self.sunriseView.centerXAnchor constraintEqualToAnchor:self.sunriseLabel.centerXAnchor constant:0].active = YES;
    [self.sunriseView.widthAnchor constraintEqualToConstant:50].active = YES;

    // MARK: sunset
    [self.sunsetLabel.centerYAnchor constraintEqualToAnchor:self.bottomAnchor constant:-13].active = YES;
    [self.sunsetLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20].active = YES;

    [self.sunsetView.centerYAnchor constraintEqualToAnchor:self.sunsetLabel.topAnchor constant:-15].active = YES;
    [self.sunsetView.centerXAnchor constraintEqualToAnchor:self.sunsetLabel.centerXAnchor constant:0].active = YES;
    [self.sunsetView.widthAnchor constraintEqualToConstant:50].active = YES;

}

@end
