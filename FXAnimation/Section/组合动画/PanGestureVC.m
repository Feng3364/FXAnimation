//
//  PanGestureVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/10.
//

/*
 思路:
 1.默认两个圆
 2.通过拖拽手势绘制当前视图
 3.拖拽中固定圆缩小，视图实时变化
 4.拖到一定范围后，固定圆消失
 5.拖拽结束回归原点，同时有个反弹效果
 */

#import "PanGestureVC.h"

@interface PanGestureVC ()

@property (nonatomic, strong) UIView *originCircle;
@property (nonatomic, strong) UIView *moveCircle;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
//坐标记录
@property (nonatomic, assign) CGPoint originCenter;
@property (nonatomic, assign) CGRect originFrame;
//圆1的半径
@property (nonatomic, assign) CGFloat radius;

@end

@implementation PanGestureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    _originCircle = [[UIView alloc] initWithFrame:CGRectMake(36, CGRectGetHeight(self.view.bounds)-156, 40, 40)];
    _originCircle.layer.cornerRadius = 20;
    _originCircle.backgroundColor = UIColor.redColor;
    [self.view addSubview:_originCircle];
    
    _moveCircle = [[UIView alloc] initWithFrame:_originCircle.frame];
    _moveCircle.layer.cornerRadius = 20;
    _moveCircle.backgroundColor = UIColor.redColor;
    [self.view addSubview:_moveCircle];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:_moveCircle.bounds];
    numLabel.text = @"99";
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.textColor = UIColor.whiteColor;
    [_moveCircle addSubview:numLabel];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [_moveCircle addGestureRecognizer:pan];
    
    _shapeLayer = [CAShapeLayer layer];
    _originFrame = _originCircle.frame;
    _originCenter = _originCircle.center;
    _radius = CGRectGetWidth(_originCircle.frame)/2;
}

#pragma mark - Action
- (void)panAction:(UIPanGestureRecognizer *)ges {
    if (ges.state == UIGestureRecognizerStateChanged) {
        _moveCircle.center = [ges locationInView:self.view];
        
        if (_radius < 9) {
            _originCircle.hidden = true;
            [_shapeLayer removeFromSuperlayer];
        }
        [self drivePath];
    } else if (ges.state == UIGestureRecognizerStateEnded
               || ges.state == UIGestureRecognizerStateFailed
               || ges.state == UIGestureRecognizerStateCancelled) {
        [_shapeLayer removeFromSuperlayer];
        __weak typeof(self) weakself = self;
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            weakself.moveCircle.center = weakself.originCenter;
        } completion:^(BOOL finished) {
            weakself.originCircle.hidden = false;
            weakself.originCircle.frame = weakself.originFrame;
            weakself.radius = weakself.originFrame.size.width / 2;
            weakself.originCircle.layer.cornerRadius = weakself.radius;
        }];
    }
}

#pragma mark - Private
- (void)drivePath {
    CGPoint center1 = _originCircle.center;
    CGPoint center2 = _moveCircle.center;
    
    CGFloat distance = sqrt(pow(center2.x - center1.x, 2) + pow(center1.y - center2.y, 2));
    CGFloat sinValue = (center2.x - center1.x) / distance;
    CGFloat cosValue = (center1.y - center2.y) / distance;
    
    CGFloat r1 = CGRectGetWidth(_originFrame) / 2 - distance / 20;
    CGFloat r2 = CGRectGetWidth(_moveCircle.bounds) / 2;
    _radius = r1;
    
    CGPoint pA = CGPointMake(center1.x - r1 * cosValue, center1.y - r1 * sinValue);
    CGPoint pB = CGPointMake(center1.x + r1 * cosValue, center1.y + r1 * sinValue);
    CGPoint pC = CGPointMake(center2.x + r2 * cosValue, center2.y + r2 * sinValue);
    CGPoint pD = CGPointMake(center2.x - r2 * cosValue, center2.y - r2 * sinValue);
    
    CGPoint pO = CGPointMake(pA.x + distance/2*sinValue, pA.y - distance/2*cosValue);
    CGPoint pP = CGPointMake(pB.x + distance/2*sinValue, pB.y - distance/2*cosValue);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pA];
    [path addQuadCurveToPoint:pD controlPoint:pO];
    [path addLineToPoint:pC];
    [path addQuadCurveToPoint:pB controlPoint:pP];
    [path closePath];
    
    if (_originCircle.hidden) {
        return;
    }
    
    _shapeLayer.path = path.CGPath;
    _shapeLayer.fillColor = UIColor.redColor.CGColor;
    [self.view.layer insertSublayer:_shapeLayer below:_moveCircle.layer];
    
    _originCircle.center = _originCenter;
    _originCircle.bounds = CGRectMake(0, 0, r1*2, r1*2);
    _originCircle.layer.cornerRadius = r1;
}

@end
