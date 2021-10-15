//
//  AppDelegate.m
//  FXAnimation
//
//  Created by Felix on 2021/7/30.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (@available(iOS 13.0, *)) {

    } else {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.window setBackgroundColor:UIColor.whiteColor];
        
        ViewController *vc = [ViewController new];
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
        if (@available (iOS 15, *)) {
            UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
            appearance.backgroundColor = UIColor.blackColor;
            appearance.titleTextAttributes = @{
                NSFontAttributeName: [UIFont systemFontOfSize:20],
                NSForegroundColorAttributeName: [UIColor whiteColor],
            };
            navi.navigationBar.standardAppearance = appearance;
            navi.navigationBar.scrollEdgeAppearance = appearance;
        }
        self.window.rootViewController = navi;
        [self.window makeKeyAndVisible];
    }
    return YES;
}

@end
