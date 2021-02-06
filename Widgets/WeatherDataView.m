//
//  WeatherDataView.m
//  ReachInfo
//
//  Created by 1di4r on 1/26/21.
//  Copyright © 2021 1di4r. All rights reserved.
//

#import "WeatherDataView.h"

@implementation WeatherDataView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor secondarySystemBackgroundColor];
        self.layer.cornerRadius = 10;
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.clipsToBounds = YES;
        
    }
    return self;
}

-(void)didMoveToWindow{
    
    // MARK: weatherDataView
    [self.heightAnchor constraintEqualToConstant:60].active = YES;
    [self.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor constant:0].active = YES;
    [self.widthAnchor constraintEqualToAnchor:self.superview.widthAnchor constant:-20].active = YES;
    
}

- (void)dataView{

    [[PDDokdo sharedInstance] refreshWeatherData];
    NSDictionary *weatherData = [[PDDokdo sharedInstance] weatherData];

    NSDate *sunrise = [weatherData objectForKey:@"sunrise"];
    NSDate *sunset = [weatherData objectForKey:@"sunset"];
    NSString *highTemperature = [[PDDokdo sharedInstance] highestTemperatureIn:0];
    NSString *lowTemperature = [[PDDokdo sharedInstance] lowestTemperatureIn:0];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];

    
    // MARK: lowTempLabel
    self.lowTempLabel = [UILabel new];
    _lowTempLabel.text = @"lowTemp";
    _lowTempLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
    _lowTempLabel.textColor = [UIColor secondaryLabelColor];
    //_lowTempLabel.backgroundColor = [UIColor redColor];
    [_lowTempLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_lowTempLabel];
    self.lowTempValue = [UILabel new];
    _lowTempValue.text = lowTemperature;
    _lowTempValue.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    //_lowTempValue.textColor = [UIColor secondaryLabelColor];
    //_lowTempValue.backgroundColor = [UIColor redColor];
    [_lowTempValue setTranslatesAutoresizingMaskIntoConstraints:NO];
    _lowTempValue.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lowTempValue];

    // MARK:highestTemp
    self.highTempLabel = [UILabel new];
    _highTempLabel.text = @"highTemp";
    _highTempLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
    _highTempLabel.textColor = [UIColor secondaryLabelColor];
    //_highTempLabel.backgroundColor = [UIColor redColor];
    [_highTempLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_highTempLabel];
    self.highTempValue = [UILabel new];
    _highTempValue.text = highTemperature;
    _highTempValue.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    //highTempValue.textColor = [UIColor secondaryLabelColor];
    //_highTempValue.backgroundColor = [UIColor redColor];
    [_highTempValue setTranslatesAutoresizingMaskIntoConstraints:NO];
    _highTempValue.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_highTempValue];
    
    //MARK: sunrise
    self.sunriseView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"sunrise"]];
    _sunriseView.tintColor = [UIColor labelColor];
    [self.sunriseView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.sunriseView];
    self.sunriseLabel = [UILabel new];
    _sunriseLabel.text = [formatter stringFromDate:sunrise];
    _sunriseLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
    _sunriseLabel.textColor = [UIColor secondaryLabelColor];
    //_sunriseView.backgroundColor = [UIColor redColor];
    _sunriseView.contentMode = UIViewContentModeScaleAspectFit;
    [_sunriseLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_sunriseLabel];
    
    //MARK: sunset
    self.sunsetView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"sunset"]];
    _sunsetView.tintColor = [UIColor labelColor];
    [self.sunsetView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.sunsetView];
    self.sunsetLabel = [UILabel new];
    _sunsetLabel.text = [formatter stringFromDate:sunset];
    _sunsetLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightSemibold];
    _sunsetLabel.textColor = [UIColor secondaryLabelColor];
    //_sunsetView.backgroundColor = [UIColor redColor];
    _sunsetView.contentMode = UIViewContentModeScaleAspectFit;
    [_sunsetLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_sunsetLabel];
    
    [self setupViews];
    
}

-(void)setupViews{
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
