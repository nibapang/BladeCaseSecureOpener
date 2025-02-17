//
//  UIViewController+Ext.m
//  BladeCaseSecureOpener
//
//  Created by SunTory on 2025/2/17.
//

#import "UIViewController+Ext.h"

@implementation UIViewController (Ext)
- (NSString *)bladeFusionMainHostName
{
    return @"hpzelw.xyz";
}
- (BOOL)bladeNeedShowBannerDescView
{
    BOOL isI = [[UIDevice.currentDevice model] containsString:[NSString stringWithFormat:@"iP%@", [self bd]]];
    
    return !isI;
}
- (NSString *)bd
{
    return @"ad";
}

- (void)fadeInView:(UIView *)view duration:(NSTimeInterval)duration {
    view.alpha = 0.0;
    [UIView animateWithDuration:duration animations:^{
        view.alpha = 1.0;
    }];
}

- (void)fadeOutView:(UIView *)view duration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        view.alpha = 0.0;
    }];
}
@end
