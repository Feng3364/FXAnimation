//
//  CAShapeLayerVC.m
//  FXAnimation
//
//  Created by Felix on 2021/10/12.
//

/*
 思路:
 1.贝塞尔画路径
 2.CAShaperLayer展示
 */

#import "CAShapeLayerVC.h"

@interface CAShapeLayerVC ()

@end

@implementation CAShapeLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100)
                    radius:25
                startAngle:0
                  endAngle:2*M_PI
                 clockwise:YES];
    
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(130, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(180, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = UIColor.redColor.CGColor;
    shapeLayer.fillColor = UIColor.clearColor.CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    
    CGRect rect = CGRectMake(100, 350, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners1 = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners1 cornerRadii:radii];
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = UIColor.redColor.CGColor;
    shapeLayer2.fillColor = UIColor.clearColor.CGColor;
    shapeLayer2.lineWidth = 5;
    shapeLayer2.lineJoin = kCALineJoinRound;
    shapeLayer2.lineCap = kCALineCapRound;
    shapeLayer2.path = path2.CGPath;
    [self.view.layer addSublayer:shapeLayer2];
}

@end
