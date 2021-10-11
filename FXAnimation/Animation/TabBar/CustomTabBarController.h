//
//  CustomTabBarController.h
//  FXAnimation
//
//  Created by Felix on 2021/10/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CustomTabBarControllerDelegate <UITabBarControllerDelegate>

- (void)CustomTabBarController:(UITabBarController *)tabBarController
       didSelectViewController:(UIViewController *)viewController;
@end

@class CustomTabBar;
@interface CustomTabBarController : UITabBarController

@property (nonatomic, weak) id<CustomTabBarControllerDelegate> customDelegate;
@property (nonatomic, strong) CustomTabBar *customTabBar;

@end

NS_ASSUME_NONNULL_END
