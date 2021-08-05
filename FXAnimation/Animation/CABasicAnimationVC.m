//
//  CABasicAnimationVC.m
//  FXAnimation
//
//  Created by Felix on 2021/7/30.
//

#import "CABasicAnimationVC.h"

@interface CABasicAnimationVC ()

@property (nonatomic, strong) CALayer *offsetLayer;
@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation CABasicAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    _offsetLayer = [CALayer layer];
    _offsetLayer.frame = CGRectMake(100, 100, 100, 100);
    _offsetLayer.backgroundColor = UIColor.redColor.CGColor;
    [self.view.layer addSublayer:_offsetLayer];
    
    _colorLayer = [CALayer layer];
    _colorLayer.frame = CGRectMake(300, 100, 100, 100);
    _colorLayer.backgroundColor = UIColor.redColor.CGColor;
    [self.view.layer addSublayer:_colorLayer];
}

#pragma mark - Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 平移
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.toValue = @600;
    animation.duration = 1;
    // 还原
    animation.removedOnCompletion = YES;
    [self.offsetLayer addAnimation:animation forKey:nil];
    
    // 颜色渐变+旋转
    [CATransaction begin];
    [CATransaction setAnimationDuration:1];
    self.colorLayer.frame = CGRectMake(300, 600, 100, 100);
    self.colorLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
    }];
    [CATransaction commit];
}

@end
