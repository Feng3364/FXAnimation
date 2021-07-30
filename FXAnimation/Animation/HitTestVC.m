//
//  HitTestVC.m
//  FXAnimation
//
//  Created by Felix on 2021/7/30.
//

#import "HitTestVC.h"

@interface HitTestVC ()

@property (strong, nonatomic) HitTestView *containerView;
@property (nonatomic, strong) CALayer *containerLayer;
@property (strong, nonatomic) HitTestView *innerView;
@property (nonatomic, strong) CALayer *innerLayer;

@end

@implementation HitTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    _containerView = [[HitTestView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    [self.view addSubview:_containerView];
    
    _containerLayer = [CALayer layer];
    _containerLayer.frame = CGRectMake(0, 0, 300, 300);
    _containerLayer.backgroundColor = UIColor.redColor.CGColor;
    [_containerView.layer addSublayer:_containerLayer];
    
    _innerView = [[HitTestView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    [self.view addSubview:_innerView];

    _innerLayer = [CALayer layer];
    _innerLayer.frame = CGRectMake(0, 0, 150, 150);
    _innerLayer.backgroundColor = UIColor.yellowColor.CGColor;
    [_innerView.layer addSublayer:_innerLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
}

@end


@implementation HitTestView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 判断是否有交互、是否隐藏
    if (self.isUserInteractionEnabled == NO || self.alpha  == 0.0 || self.hidden == true) {
        return [self hitTest:point withEvent:event];
    }
    
    // 判断坐标
    if ([self pointInside:point withEvent:event]) {
        for (UIView *subview in self.subviews) {
            CGPoint coverPoint = [subview convertPoint:point toView:self];
            UIView *hitTestView = [subview hitTest:coverPoint withEvent:event];
            if (hitTestView) {
                return hitTestView;
            }
        }
    }
    return [self hitTest:point withEvent:event];
}

@end
