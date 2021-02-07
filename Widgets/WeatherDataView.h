//
//  WeatherDataView.h
//  ReachInfo
//
//  Created by 1di4r on 1/26/21.
//  Copyright © 2021 1di4r. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PeterDev/libpddokdo.h>

@interface WeatherDataView : UIView
-(void)dataView;
@property (nonatomic, retain) UILabel *lowTempLabel;
@property (nonatomic, retain) UILabel *highTempLabel;
@property (nonatomic, retain) UILabel *lowTempValue;
@property (nonatomic, retain) UILabel *highTempValue;
@property (nonatomic, retain) UILabel *sunriseLabel;
@property (nonatomic, retain) UILabel *sunsetLabel;

@property (nonatomic, retain) UIImageView *sunriseView;
@property (nonatomic, retain) UIImageView *sunsetView;
@end
