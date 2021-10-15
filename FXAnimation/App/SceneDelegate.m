//
//  SceneDelegate.m
//  FXAnimation
//
//  Created by Felix on 2021/7/30.
//

#import "SceneDelegate.h"
#import "ViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions API_AVAILABLE(ios(13.0)) {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setWindowScene:windowScene];
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

@end
