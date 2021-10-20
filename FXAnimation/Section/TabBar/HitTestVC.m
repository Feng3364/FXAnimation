//
//  HitTestVC.m
//  FXAnimation
//
//  Created by Felix on 2021/7/30.
//

/*
 思路:
 1.HitTest调用顺序：touch->UIApplication->UIWindow->UIViewController->UIView->Subview->...->当前view
 2.事件的传递顺序与之相反
 */

#import "HitTestVC.h"

#pragma mark - UIViewController-HitTestVC
@interface HitTestVC ()

@property (strong, nonatomic) UIView *containerView;
@property (nonatomic, strong) CALayer *innerLayer;

@end

@implementation HitTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    _containerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    _containerView.backgroundColor = UIColor.redColor;
    [self.view addSubview:_containerView];

    _innerLayer = [CALayer layer];
    _innerLayer.frame = CGRectMake(0, 0, 150, 150);
    _innerLayer.backgroundColor = UIColor.blueColor.CGColor;
    [self.containerView.layer addSublayer:_innerLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.view];
    CALayer *layer = [self.containerView.layer hitTest:point];
    if (layer == self.innerLayer) {
        NSLog(@"在蓝色view中");
    } else if (layer == self.containerView.layer) {
        NSLog(@"在红色view中");
    } else {
        NSLog(@"在containerView中");
    }
}

@end


#pragma mark - UIView-HitTestView
// 仿写hitTest响应链
@implementation HitTestView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 判断是否有交互、是否隐藏
    if (self.isUserInteractionEnabled == NO || self.alpha  == 0.0 || self.hidden == true) {
        return nil;
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
        return self;
    }
    return nil;
}

@end
