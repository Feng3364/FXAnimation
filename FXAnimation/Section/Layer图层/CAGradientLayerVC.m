//
//  CAGradientLayerVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/7.
//

/*
 思路:
 1.CAGradientLayer实现渐变色
 */

#import "CAGradientLayerVC.h"

@interface CAGradientLayerVC ()

@end

@implementation CAGradientLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(10, 50, self.view.frame.size.width - 20, 100);
    
    gradientLayer.locations = @[@0.25,@0.5,@0.25];
    
    gradientLayer.colors = @[
        (__bridge id)[UIColor redColor].CGColor,
        (__bridge id)[UIColor blueColor].CGColor,
        (__bridge id)[UIColor purpleColor].CGColor
    ];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    [self.view.layer addSublayer:gradientLayer];
}

@end
