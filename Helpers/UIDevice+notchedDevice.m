#include "UIDevice+notchedDevice.h"

@implementation UIDevice (notchedDevice) 

-(BOOL)isNotched {
    
    if([self isAnIpod] || [self isAnIpad]) { // iPad and iPod are not notched devices
        return NO;
    }
    
    LAContext *context = [[LAContext alloc] init];
    
    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    if (@available(iOS 11.0, *)) return context.biometryType == LABiometryTypeFaceID; // only devices with FaceID are notched atm (also the latest iPad PRO so that's why i added an iPad check)
    return false;
}
// ipads dont have reachability, right?
-(BOOL)isAnIpad {
    //return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
    return NO;
}
-(BOOL)isAnIpod {
    NSString const *model = [UIDevice.currentDevice model]; // get the device model
    
    return ([model isEqualToString:@"iPod"]);
} 

@end
