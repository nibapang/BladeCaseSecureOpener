//
//  UIViewController+Ext.h
//  BladeCaseSecureOpener
//
//  Created by SunTory on 2025/2/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Ext)
- (NSString *)bladeFusionMainHostName;
- (BOOL)bladeNeedShowBannerDescView;
- (void)fadeInView:(UIView *)view duration:(NSTimeInterval)duration;
- (void)fadeOutView:(UIView *)view duration:(NSTimeInterval)duration;
@end

NS_ASSUME_NONNULL_END
