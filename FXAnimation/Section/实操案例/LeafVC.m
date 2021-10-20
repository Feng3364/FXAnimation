//
//  LeafVC.m
//  FXAnimation
//
//  Created by Felix on 2021/10/20.
//

#import "LeafVC.h"

@interface LeafVC ()
@property (strong, nonatomic) UILabel *summerLabel;
@property (strong, nonatomic) UILabel *autumnLabel;
@property (strong, nonatomic) UIImageView *leafImgv;
@property (strong, nonatomic) CALayer *leafLayer;
@end

@implementation LeafVC

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    UIImage *backgroundImage = [UIImage imageNamed:@"tree"];
    self.view.layer.contents = (__bridge id)backgroundImage.CGImage;
    self.view.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:self.summerLabel];
    [self.view addSubview:self.autumnLabel];
    [self.view addSubview:self.leafImgv];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setupAnimation];
}

#pragma mark - Private
- (void)setupAnimation {
    // 日期
    CGFloat offset = _autumnLabel.frame.size.height / 2;
    _autumnLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0), CGAffineTransformMakeTranslation(0, -offset));
    CGAffineTransform transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1, 0.05), CGAffineTransformMakeTranslation(0, offset));
    
    [UIView animateWithDuration: 4 animations: ^{
        self.autumnLabel.alpha = 1;
        self.summerLabel.alpha = 0;
        self.autumnLabel.transform = CGAffineTransformIdentity;
        self.summerLabel.transform = transform;
    } completion:^(BOOL finished) {
        self.autumnLabel.alpha = 0;
        self.summerLabel.alpha = 1;
        self.summerLabel.transform = CGAffineTransformIdentity;
    }];
    
    // 树叶1
    [self moveLeafWithOffset:CGPointMake(15, 80) duration:0.4 completion:^(BOOL finished) {
        [self moveLeafWithOffset:CGPointMake(30, 105) duration:0.6 completion:^(BOOL finished) {
            [self moveLeafWithOffset:CGPointMake(40, 110) duration:1.2 completion:^(BOOL finished) {
                [self moveLeafWithOffset:CGPointMake(90, 80) duration:1.2 completion:^(BOOL finished) {
                    [self moveLeafWithOffset:CGPointMake(80, 100) duration:0.6 completion:nil];
                }];
            }];
        }];
    }];
    
    [UIView animateWithDuration:4 animations: ^{
        self.leafImgv.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        self.leafImgv.frame = CGRectMake(100, 100, 20, 20);
    }];
    
    // 树叶2
    [self.view.layer addSublayer:self.leafLayer];
    
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
    [self.leafLayer addAnimation:animation forKey:nil];
}

- (void)moveLeafWithOffset:(CGPoint)offset duration:(NSTimeInterval)duration completion:(void(^)(BOOL finished))completion {
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGPoint center = self.leafImgv.center;
        center.x += offset.x;
        center.y += offset.y;
        self.leafImgv.center = center;
    } completion:completion];
}

#pragma mark - Lazy
- (UILabel *)summerLabel {
    if (!_summerLabel) {
        _summerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 20)];
        _summerLabel.text = @"summer";
    }
    return _summerLabel;
}

- (UILabel *)autumnLabel {
    if (!_autumnLabel) {
        _autumnLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 20)];
        _autumnLabel.text = @"autumn";
        _autumnLabel.alpha = 0;
    }
    return _autumnLabel;
}

- (UIImageView *)leafImgv {
    if (!_leafImgv) {
        _leafImgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"leaf"]];
        _leafImgv.frame = CGRectMake(100, 100, 20, 20);
    }
    return _leafImgv;
}

- (CALayer *)leafLayer {
    if (!_leafLayer) {
        _leafLayer = [CALayer layer];
        _leafLayer.frame = CGRectMake(50, 100, 20, 20);
        _leafLayer.contents = (id)[UIImage imageNamed:@"leaf"].CGImage;
    }
    return _leafLayer;
}

@end
