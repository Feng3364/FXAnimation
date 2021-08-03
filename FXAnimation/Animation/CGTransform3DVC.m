//
//  CGTransform3DVC.m
//  FXAnimation
//
//  Created by Felix on 2021/7/30.
//

#import "CGTransform3DVC.h"

@interface CGTransform3DVC ()

@property (nonatomic, strong) UIImageView *imgv1;
@property (nonatomic, strong) UIImageView *imgv2;
@property (nonatomic, strong) UIImageView *imgv3;
@property (nonatomic, strong) UIImageView *imgv4;

@end

@implementation CGTransform3DVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    _imgv1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _imgv1.image = [UIImage imageNamed:@"AppIcon"];
    [self.view addSubview:_imgv1];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(100, 250, 200, 100)];
    containerView.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:containerView];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500;
    containerView.layer.sublayerTransform = perspective;
    
    _imgv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _imgv2.image = [UIImage imageNamed:@"AppIcon"];
    [containerView addSubview:_imgv2];
    
    _imgv3 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    _imgv3.image = [UIImage imageNamed:@"AppIcon"];
    [containerView addSubview:_imgv3];
    
    _imgv4 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 400, 100, 100)];
    _imgv4.image = [UIImage imageNamed:@"AppIcon"];
    [self.view addSubview:_imgv4];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 500;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    _imgv1.layer.transform = transform;
    
    CATransform3D transform2 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    CATransform3D transform3 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    _imgv2.layer.transform = transform2;
    _imgv3.layer.transform = transform3;
    
    CATransform3D transform4 = CATransform3DIdentity;
    transform4.m34 = -1.0/500;
    transform4 = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    _imgv4.layer.transform = transform4;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 500;
    transform = CATransform3DRotate(transform, 0, 0, 1, 0);
    _imgv1.layer.transform = transform;
    
    CATransform3D transform2 = CATransform3DMakeRotation(0, 0, 1, 0);
    CATransform3D transform3 = CATransform3DMakeRotation(0, 0, 1, 0);
    _imgv2.layer.transform = transform2;
    _imgv3.layer.transform = transform3;
    
    CATransform3D transform4 = CATransform3DIdentity;
    transform4.m34 = -1.0/500;
    transform4 = CATransform3DMakeRotation(M_PI_4, 0, 0, 0);
    _imgv4.layer.transform = transform4;
}

@end
