#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface UIDevice (notchedDevice)
@property (nonatomic,readonly) NSString * model;
-(NSString *)model;
// new methods
-(BOOL)isNotched;
-(BOOL)isAnIpad;
-(BOOL)isAnIpod;
@end
