//
//  LabelVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/12.
//

#import "LabelVC.h"

@interface LabelVC ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation LabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 100)];
    _label.text = @"0";
    _label.textColor = UIColor.redColor;
    _label.font = [UIFont fontWithName:@"AvenirNext-BoldItalic" size:50];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
}

#pragma mark - Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self labelDanceAnimation:0.4];
    self.label.text = [NSString stringWithFormat:@"%d", [self.label.text intValue] + 1];
}

#pragma mark - Private
- (void)labelDanceAnimation:(NSTimeInterval)duration {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 0.4 * duration;
    opacityAnimation.fromValue = @0.f;
    opacityAnimation.toValue = @1.f;
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = duration;
    scaleAnimation.values = @[@3.f, @1.f, @1.2f, @1.f];
    scaleAnimation.keyTimes = @[@0.f, @0.16f, @0.28f, @0.4f];
    scaleAnimation.removedOnCompletion = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[opacityAnimation, scaleAnimation];
    animationGroup.duration = duration;
    animationGroup.removedOnCompletion = YES;
    animationGroup.fillMode = kCAFillModeForwards;
    [self.label.layer addAnimation:animationGroup forKey:nil];
}

@end
