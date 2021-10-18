//
//  FXTabBarController.m
//  FXAnimation
//
//  Created by Felix on 2021/10/11.
//

/*
 思路:
 1.使用自定义TabBar替代系统TabBar（重写hitTest方法即可实现超出tabbar部分的视图响应手势）
 2.继承自定义tabbarController，通过代理实现点击事件的处理
 */

#import "FXTabBarController.h"
#import "CustomTabBar.h"

@interface FXTabBarController () <CustomTabBarControllerDelegate>

@end

@implementation FXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customTabBar.tintColor = [UIColor colorWithRed:251.0/255.0 green:199.0/255.0 blue:115/255.0 alpha:1];
    self.customTabBar.translucent = NO;
    [self.customTabBar.centerBtn setImage:[UIImage imageNamed:@"AppIcon"] forState:UIControlStateNormal];
    self.customTabBar.centerBtn.backgroundColor = UIColor.redColor;
    self.customDelegate = self;
    [self addChildViewControllers];
}

- (void)addChildViewControllers {
    //图片大小建议32*32
    [self addChildrenViewController:[[UIViewController alloc] init] andTitle:@"首页" andImageName:@"AppIcon"];
    [self addChildrenViewController:[[UIViewController alloc] init] andTitle:@"应用" andImageName:@"AppIcon"];
    [self addChildrenViewController:[[UIViewController alloc] init] andTitle:@"" andImageName:@""];
    [self addChildrenViewController:[[UIViewController alloc] init] andTitle:@"消息" andImageName:@"AppIcon"];
    [self addChildrenViewController:[[UIViewController alloc] init] andTitle:@"我的" andImageName:@"AppIcon"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName {
    if (imageName.length > 0) {
        childVC.tabBarItem.image = [UIImage imageNamed:imageName];
        childVC.tabBarItem.selectedImage =  [UIImage imageNamed:imageName];
    }
    childVC.title = title;
    [self addChildViewController:childVC];
}

- (void)CustomTabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 2){
        [self rotationAnimation];
    } else {
        [self.customTabBar.centerBtn.layer removeAllAnimations];
    }
}

//旋转动画
- (void)rotationAnimation {
    if ([@"key" isEqualToString:[self.customTabBar.centerBtn.layer animationKeys].firstObject]){
        return;
    }
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3.0;
    rotationAnimation.repeatCount = 1;
    [self.customTabBar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
}

@end
