//
//  CAEmitterLayerVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/7.
//

#import "CAEmitterLayerVC.h"

@interface CAEmitterLayerVC ()

@property (nonatomic, strong) CAEmitterLayer * colorBallLayer;

@end

@implementation CAEmitterLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = UIColor.blackColor;
}

#pragma mark - UI
- (void)createUI {
    CAEmitterCell *colorBallCell = [CAEmitterCell emitterCell];
    // 粒子名称
    colorBallCell.name = @"colorBallCell";
    // 粒子产生率
    colorBallCell.birthRate = 20.f;
    // 粒子生命周期
    colorBallCell.lifetime = 10.f;
    // 粒子速度
    colorBallCell.velocity = 40.f;
    // 粒子速度平均量
    colorBallCell.velocityRange = 100.f;
    // 粒子x、y、z的加速度分量
    colorBallCell.yAcceleration = 15.f;
    // 指定维度
    colorBallCell.emissionLongitude = M_PI;
    // 发射角度范围
    colorBallCell.emissionRange = M_PI_4;
    // 缩放比例
    colorBallCell.scale = 0.2;
    // 缩放比例范围
    colorBallCell.scaleRange = 0.1;
    // 生命周期内的缩放速度
    colorBallCell.scaleSpeed = 0.02;
    // 粒子内容
    colorBallCell.contents = (id)[UIImage imageNamed:@"AppIcon"].CGImage;
    // 粒子颜色
    colorBallCell.color = [UIColor colorWithRed:0.5 green:0.f blue:0.5 alpha:1].CGColor;
    // 粒子颜色red,green,blue,alpha能改变的范围
    colorBallCell.redRange = 1.f;
    colorBallCell.greenRange = 1.f;
    colorBallCell.alphaRange = 0.8;
    // 粒子颜色red,green,blue,alpha在生命周期内的改变速度,默认都是0
    colorBallCell.blueSpeed = 1.f;
    colorBallCell.alphaSpeed = -0.1f;
    
    _colorBallLayer = [CAEmitterLayer layer];
    // 发射源尺寸大小
    _colorBallLayer.emitterSize = self.view.frame.size;
    // 发射源形状
    _colorBallLayer.emitterShape = kCAEmitterLayerPoint;
    // 发射模式
    _colorBallLayer.emitterMode = kCAEmitterLayerPoints;
    // 发射中心点
    _colorBallLayer.emitterPosition = CGPointMake(self.view.layer.bounds.size.width, 0);
    // 添加
    _colorBallLayer.emitterCells = @[colorBallCell];
    [self.view.layer addSublayer:_colorBallLayer];
}

#pragma mark - Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [self locationFromTouchEvent:event];
    [self setBallInPosition:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [self locationFromTouchEvent:event];
    [self setBallInPosition:point];
}

#pragma mark - Private
/**
 * 获取手指所在点
 */
- (CGPoint)locationFromTouchEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    return [touch locationInView:self.view];
}

/**
 * 移动发射源到某个点上
 */
- (void)setBallInPosition:(CGPoint)position {
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"emitterCells.colorBallCell.scale"];
    animate.fromValue = @0.2f;
    animate.toValue = @0.5f;
    animate.duration = 1.f;
    animate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [_colorBallLayer addAnimation:animate forKey:nil];
    [_colorBallLayer setValue:[NSValue valueWithCGPoint:position] forKey:@"emitterPosition"];
    [CATransaction commit];
}

@end
