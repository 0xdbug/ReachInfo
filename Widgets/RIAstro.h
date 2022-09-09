//
//  TheTwoAstronauts.h
//  ReachInfo
//
//  Created by 1di4r on 7/31/20.
//  Copyright © 2020 1di4r. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface RIAstro : UIView
-(void)show;

@property (nonatomic, retain) UILabel *astro1Label;
@property (nonatomic, retain) UILabel *astro2Label;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UIImageView *astro1;
@property (nonatomic, retain) UIImageView *astro2;

@end

NSString *fontName;

#define astro1Path @"/Library/Application Support/ReachInfo.bundle/firstAstronaut.png"
#define astro2Path @"/Library/Application Support/ReachInfo.bundle/secondAstronaut.png"
#define fontPath @"/Library/Application Support/ReachInfo.bundle/Roboto.ttf"



