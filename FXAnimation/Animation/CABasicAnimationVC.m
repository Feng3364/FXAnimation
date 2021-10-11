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
    animation.keyPath = @"position.y";//kvc赋值
    animation.toValue = @100;//将要修改成toValue
    animation.duration = 1;
    // 恢复（表示是否在动画完成之后将其移除——平移动画只修改了呈现树，并不是移动图层本身）
    // 动画开始时原始图层就会隐藏；动画结束呈现树会移除，原始图层显示
    animation.removedOnCompletion = NO;//是否还原动画，默认为YES
    // kCAFillModeBackwards表示立即展示动画第一帧，会跳过隐式动画（0.25秒）
    animation.fillMode = kCAFillModeForwards;//动画结束后layer保持动画最后的状态
    [self.offsetLayer addAnimation:animation forKey:nil];
    
    // CATransaction用来修改隐式动画，它不需要初始化，只能通过压栈和出栈操作
    [CATransaction begin];
    [CATransaction setAnimationDuration:1];
    self.colorLayer.frame = CGRectMake(300, 600, 100, 100);
    self.colorLayer.backgroundColor = [UIColor orangeColor].CGColor;
    
    // 动画结束时设置旋转   
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
    }];
    [CATransaction commit];
}

@end
