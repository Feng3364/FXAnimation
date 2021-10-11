//
//  CGTransformPracticeVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/4.
//

#import "CGTransformPracticeVC.h"

@interface CGTransformPracticeVC ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, copy) NSArray<UIView *> *transformArray;

@end

@implementation CGTransformPracticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    _containerView.backgroundColor = UIColor.blackColor;
    [self.view addSubview:_containerView];
    
    // 处理父视图
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    _containerView.layer.sublayerTransform = perspective;
    
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFace:0 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    
    //add cube face 3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
}

#pragma mark - Private
- (UIView *)createViewWithColor:(UIColor *)color {
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = color;
    return v;
}

- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform {
    // 1.获取视图
    UIView *face = self.transformArray[index];
    [self.containerView addSubview:face];
    
    // 设置中心点
    CGSize containerSize = self.containerView.bounds.size;
    face.frame = CGRectMake(containerSize.width / 2.0, containerSize.height / 2.0, 200, 200);
    
    // 3.设置变换
    face.layer.transform = transform;
}

#pragma mark - Lazy
- (NSArray<UIView *>*)transformArray {
    if (!_transformArray) {
        _transformArray = @[
            [self createViewWithColor:UIColor.redColor],
            [self createViewWithColor:UIColor.orangeColor],
            [self createViewWithColor:UIColor.yellowColor],
            [self createViewWithColor:UIColor.greenColor],
            [self createViewWithColor:UIColor.blueColor],
            [self createViewWithColor:UIColor.purpleColor],
        ];
    }
    return _transformArray;
}

@end
