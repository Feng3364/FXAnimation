//
//  BezierPathAnimationVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/10.
//

/*
 思路:
 1.使用关键帧动画（position）实现小汽车的移动
 */

#import "BezierPathAnimationVC.h"

@interface BezierPathAnimationVC ()

@end

@implementation BezierPathAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    CALayer *carLayer = [CALayer layer];
    carLayer.frame = CGRectMake(15, 200-18, 36, 36);
    carLayer.contents = (id)[UIImage imageNamed:@"car"].CGImage;
    [self.view.layer addSublayer:carLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 200)];
    [path addCurveToPoint:CGPointMake(300, 200)
            controlPoint1:CGPointMake(100, 100)
            controlPoint2:CGPointMake(200, 300)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = path.CGPath;
    animation.duration = 4.0;
    animation.rotationMode = kCAAnimationRotateAuto;
    [carLayer addAnimation:animation forKey:nil];
}

@end
