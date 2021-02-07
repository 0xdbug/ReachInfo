#import "RIWeather.h"

@implementation RIWeather

- (void)show{

    [[PDDokdo sharedInstance] refreshWeatherData];
    NSDictionary *weatherData = [[PDDokdo sharedInstance] weatherData];
    
    NSString *temperature = [weatherData objectForKey:@"temperature"];
    NSString *condition = [weatherData objectForKey:@"conditions"];
    NSString *location = [weatherData objectForKey:@"location"];
    UIImage *conditionsImage = [weatherData objectForKey:@"conditionsImage"];
    
    // MARK: conditionsImageView
    self.conditionsImageView = [[UIImageView alloc] initWithImage:conditionsImage];
    [self.conditionsImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.conditionsImageView];
    
    // MARK: info Lables
    self.locationLabel = [UILabel new];
    self.locationLabel.text = location;
    self.locationLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    self.locationLabel.textColor = [UIColor secondaryLabelColor];
    //self.locationLabel.backgroundColor = [UIColor redColor];
    [self.locationLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.locationLabel];
    
    self.infoLabel = [UILabel new];
    self.infoLabel.text = [NSString stringWithFormat:@"%@, %@", condition, temperature];
    self.infoLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    //self.infoLabel.textColor = [UIColor secondaryLabelColor];
    //self.infoLabel.backgroundColor = [UIColor redColor];
    [self.infoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.infoLabel];
    
    // MARK: weatherDataView
    self.weatherView = [WeatherDataView new];
    [self addSubview:self.weatherView];
    [self.weatherView dataView];

    [self setupViews];
}

- (void)setupViews{
    
    // MARK: images
    [self.conditionsImageView.centerYAnchor constraintEqualToAnchor:self.superview.centerYAnchor constant:-70].active = YES;
    [self.conditionsImageView.centerXAnchor constraintEqualToAnchor:self.rightAnchor constant:-50].active = YES;
    [self.conditionsImageView.widthAnchor constraintEqualToConstant:69].active = YES;
    self.conditionsImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.conditionsImageView.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    self.conditionsImageView.layer.shadowOpacity = 0.5f;
    self.conditionsImageView.layer.shadowRadius = 4.0f;

    // ha ha 69, the funny number
    [self.conditionsImageView.heightAnchor constraintEqualToConstant:69].active = YES;
    
    // MARK: Labels
    [self.locationLabel.centerYAnchor constraintEqualToAnchor:self.conditionsImageView.centerYAnchor constant:0].active = YES;
    [self.locationLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:12].active = YES;
    [self.infoLabel.centerYAnchor constraintEqualToAnchor:self.locationLabel.bottomAnchor constant:13].active = YES;
    [self.infoLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:12.4].active = YES;

    [self.weatherView.centerYAnchor constraintEqualToAnchor:self.infoLabel.bottomAnchor constant:40].active = YES;
    
}

@end