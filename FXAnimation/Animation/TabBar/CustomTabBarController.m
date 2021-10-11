//
//  CustomTabBarController.m
//  FXAnimation
//
//  Created by Felix on 2021/10/11.
//

#import "CustomTabBarController.h"
#import "CustomTabBar.h"

@interface CustomTabBarController () <UITabBarControllerDelegate>

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _customTabBar = [[CustomTabBar alloc] init];
    [_customTabBar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_customTabBar forKeyPath:@"tabBar"];
    self.delegate = self;
}

- (void)buttonAction:(UIButton *)button{
    NSInteger count = self.viewControllers.count;
    self.selectedIndex = count/2;
    [self tabBarController:self didSelectViewController:self.viewControllers[self.selectedIndex]];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    _customTabBar.centerBtn.selected = (tabBarController.selectedIndex == self.viewControllers.count/2);
    
    if (self.customDelegate){
        [self.customDelegate CustomTabBarController:tabBarController didSelectViewController:viewController];
    }
}

@end
