#import <UIKit/UIKit.h>
#import <PeterDev/libpddokdo.h>
#import "WeatherDataView.h"

@interface RIWeather: UIView
@property (nonatomic, retain) WeatherDataView *weatherView;
@property (nonatomic, retain) UIImageView *conditionsImageView;
@property (nonatomic, retain) UILabel *locationLabel;
@property (nonatomic, retain) UILabel *infoLabel;
@end
