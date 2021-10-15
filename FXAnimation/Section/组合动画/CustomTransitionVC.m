//
//  CustomTransitionVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/11.
//

#import "CustomTransitionVC.h"

#pragma mark - Class-CircleTransition
@interface CircleTransition () <CAAnimationDelegate>

@property(nonatomic,strong) id<UIViewControllerContextTransitioning> context;

@end

@implementation CircleTransition

/// 定义转场动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _context = transitionContext;
    
    // 获取容器
    UIView *containerView = [transitionContext containerView];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [containerView addSubview:toVC.view];
    
    // 添加动画
    UIButton *btn;
    CustomTransitionVC *vc1;
    CustomPopVC *vc2;
    if (_isPush) {
        vc1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        vc2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        btn = vc1.btn;
    } else {
        vc1 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        vc2 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        btn = vc2.btn;
    }
    [containerView addSubview:vc1.view];
    [containerView addSubview:vc2.view];
    
    // 画小圆
    UIBezierPath *smallPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
    CGPoint centerP = btn.center;
    CGFloat radius = 0;
    CGFloat y = CGRectGetHeight(toVC.view.bounds) - CGRectGetMaxY(btn.frame) + CGRectGetHeight(btn.bounds) / 2;
    CGFloat x = CGRectGetWidth(toVC.view.bounds) - CGRectGetMaxX(btn.frame) + CGRectGetWidth(btn.bounds) / 2;
    if (btn.frame.origin.x > CGRectGetWidth(toVC.view.bounds) / 2) {
        if (CGRectGetMaxY(btn.frame) < CGRectGetHeight(toVC.view.bounds)/2) {
            radius = sqrtf(btn.center.x*btn.center.x + y*y);
        } else {
            radius = sqrtf(btn.center.x*btn.center.x + btn.center.y*btn.center.y);
        }
    } else {
        if (CGRectGetMidY(btn.frame) < CGRectGetHeight(toVC.view.frame)) {
            radius = sqrtf(x*x + y*y);
        } else {
            radius = sqrtf(x*x + btn.center.y*btn.center.y);
        }
    }
    
    // 画大圆
    UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:centerP radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:true];
    
    // layer
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    if (_isPush) {
        shaperLayer.path = bigPath.CGPath;
    } else {
        shaperLayer.path = smallPath.CGPath;
    }
    
    // 蒙版
    UIViewController *vc;
    if (_isPush) {
        vc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    } else {
        vc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
    vc.view.layer.mask = shaperLayer;
    
    // layer添加动画
    CABasicAnimation *animte = [CABasicAnimation animationWithKeyPath:@"path"];
    if (_isPush) {
        animte.fromValue = (id)smallPath.CGPath;
    } else {
        animte.fromValue = (id)bigPath.CGPath;
    }
    
    animte.duration = [self transitionDuration:transitionContext];
    animte.delegate = self;
    [shaperLayer addAnimation:animte forKey:nil];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [_context completeTransition:true];
    // 取消蒙版
    if (_isPush) {
        UIViewController *toVC = [_context viewControllerForKey:UITransitionContextToViewControllerKey];
        toVC.view.layer.mask = nil;
    } else {
        UIViewController *toVC = [_context viewControllerForKey:UITransitionContextFromViewControllerKey];
        toVC.view.layer.mask = nil;
    }
}

@end

#pragma mark - Class-CustomTransitionVC
@interface CustomTransitionVC () <UINavigationControllerDelegate>

@end

@implementation CustomTransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self config];
    [self setupUI];
}

- (void)config {
    self.navigationController.delegate = self;
}

#pragma mark - UI
- (void)setupUI {
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _btn.backgroundColor = UIColor.redColor;
    [_btn addTarget:self action:@selector(onClickPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

#pragma mark - Action
- (void)onClickPush {
    [self.navigationController pushViewController:[CustomPopVC new] animated:true];
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        CircleTransition *ct = [CircleTransition new];
        ct.isPush = YES;
        return ct;
    } else {
        return nil;
    }
}

@end


#pragma mark - Class-CustomPopVC
@interface CustomPopVC () <UINavigationControllerDelegate>

@end

@implementation CustomPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self config];
    [self setupUI];
}

- (void)config {
    self.navigationController.delegate = self;
}

#pragma mark - UI
- (void)setupUI {
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _btn.backgroundColor = UIColor.blackColor;
    [_btn addTarget:self action:@selector(onClickPop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

#pragma mark - Action
- (void)onClickPop {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        CircleTransition *ct = [CircleTransition new];
        ct.isPush = YES;
        return ct;
    } else {
        return nil;
    }
}

@end
