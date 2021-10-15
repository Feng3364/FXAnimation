//
//  SharkVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/9.
//

#import "SharkVC.h"
#define angleToRadians(angle) ((angle)/180.0 * M_PI)

@interface SharkVC ()

@property (nonatomic, strong) UIImageView *imgv;

@end

@implementation SharkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    _imgv = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    _imgv.image = [UIImage imageNamed:@"AppIcon"];
    [self.view addSubview:_imgv];
}

#pragma mark - Action
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CAKeyframeAnimation *animate = [CAKeyframeAnimation animation];
    animate.keyPath = @"transform.rotation";
    animate.values = @[
        @angleToRadians(-10),
        @angleToRadians(10),
        @angleToRadians(-10),
    ];
    animate.autoreverses = true;
    animate.speed = 2;
    animate.duration = 1;
    animate.repeatCount = 3;
    [_imgv.layer addAnimation:animate forKey:nil];
}

@end

