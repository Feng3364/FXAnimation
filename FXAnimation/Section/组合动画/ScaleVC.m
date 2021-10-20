//
//  ScaleVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/21.
//

/*
 思路:
 1.需求：图片不断放大缩小
 2.点赞动画：遍历生成六个三角形（散开动画：放大+移动路径）
 3.取消动画：UIView.animateWithDuration展示红心旋转隐藏
 */

#import "ScaleVC.h"

#define BreathAnimationKey @"BreathAnimationKey"
#define BreathAnimationName @"BreathAnimationName"
#define BreathScaleName @"BreathScaleName"

CGFloat HeartWH = 200;

@interface ScaleVC ()

@property (nonatomic, strong) UIView *heartView;

@end

@implementation ScaleVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
    [self addBreathAnimation];
    [self shakeAnimation];
}

#pragma mark - UI
- (void)setupUI {
    _heartView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, HeartWH, HeartWH)];
    [self.view addSubview:_heartView];
}

- (void)addBreathAnimation {
    CALayer *layer = [CALayer layer];
    layer.position = CGPointMake(HeartWH / 2.0f, HeartWH / 2.0f);
    layer.bounds = CGRectMake(0, 0, HeartWH/2.0f, HeartWH/2.0f);
    layer.contents = (__bridge  id _Nullable)[UIImage imageNamed:@"AppIcon"].CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    [self.heartView.layer addSublayer:layer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@1.f, @1.4f, @1.f];
    animation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    animation.duration = 1;
    animation.repeatCount = FLT_MAX;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setValue:BreathAnimationKey forKey:BreathAnimationName];
    [layer addAnimation:animation forKey:BreathAnimationKey];
    
    CALayer *breathLayer = [CALayer layer];
    breathLayer.position = layer.position;
    breathLayer.bounds = layer.bounds;
    breathLayer.backgroundColor = UIColor.clearColor.CGColor;
    breathLayer.contents = (__bridge  id _Nullable)[UIImage imageNamed:@"AppIcon"].CGImage;
    breathLayer.contentsGravity = kCAGravityResizeAspect;
    [self.heartView.layer addSublayer:breathLayer];

    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = @[@1.f, @2.4f];
    scaleAnimation.keyTimes = @[@0.0f, @1.f];
    scaleAnimation.duration = animation.duration;
    scaleAnimation.repeatCount = FLT_MAX;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animation];
    opacityAnimation.keyPath = @"opacity";
    opacityAnimation.values = @[@1.f, @0.f];
    opacityAnimation.keyTimes = @[@0.0f, @1.0f];
    opacityAnimation.repeatCount = FLT_MAX;
    opacityAnimation.duration = animation.duration;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    CAAnimationGroup *scaleOpacityGroup = [CAAnimationGroup animation];
    scaleOpacityGroup.animations = @[scaleAnimation, opacityAnimation];
    scaleOpacityGroup.removedOnCompletion = NO;
    scaleOpacityGroup.fillMode = kCAFillModeForwards;
    scaleOpacityGroup.duration = animation.duration;
    scaleOpacityGroup.repeatCount = FLT_MAX;
    [breathLayer addAnimation:scaleOpacityGroup forKey:BreathScaleName];
}

- (void)shakeAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@1.0f, @0.8f, @1.0f];
    animation.keyTimes = @[@0.0f, @0.5f, @1.f];
    animation.duration = 0.35f;
    animation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
    ];
    [self.heartView.layer addAnimation:animation forKey:@""];
}


@end
