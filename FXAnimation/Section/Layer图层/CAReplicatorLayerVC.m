//
//  CAReplicatorLayerVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/7.
//

/*
 思路:
 1.CAReplicatorLayer实现镜面
 */

#import "CAReplicatorLayerVC.h"

@interface CAReplicatorLayerVC ()

@end

@implementation CAReplicatorLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    ReflectionView *reflectionView = [[ReflectionView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:reflectionView];
    
    UIImage *image = [UIImage imageNamed:@"AppIcon"];
    UIImageView *imgv = [[UIImageView alloc] initWithImage:image];
    imgv.frame = CGRectMake(0, 0, 200, 200);
    [reflectionView addSubview:imgv];
}

@end


@implementation ReflectionView

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
}

-(void)setUp {
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
    layer.instanceCount = 2;
    CATransform3D transform = CATransform3DIdentity;
    //间隔
    CGFloat veticalOffset = self.bounds.size.height + 2;
    transform = CATransform3DTranslate(transform, 0, veticalOffset, 0);
    transform = CATransform3DScale(transform, -1, -1, 0);
    layer.instanceTransform = transform;
    layer.instanceAlphaOffset = -0.7;
}

@end
