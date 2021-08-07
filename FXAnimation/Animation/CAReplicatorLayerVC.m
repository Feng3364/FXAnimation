//
//  CAReplicatorLayerVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/7.
//

#import "CAReplicatorLayerVC.h"

@interface CAReplicatorLayerVC ()

@end

@implementation CAReplicatorLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

#pragma mark - UI
- (void)createUI {
    UIImage *image = [UIImage imageNamed:@"AppIcon"];
    UIImageView *imgv = [[UIImageView alloc] initWithImage:image];
    imgv.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:imgv];
    
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    layer.instanceCount = 2;
    
    CATransform3D transform = CATransform3DIdentity;
    CGFloat veticalOffset = imgv.bounds.size.height + 2;
    transform = CATransform3DTranslate(transform, 0, veticalOffset, 0);
    transform = CATransform3DScale(transform, -1, -1, 0);
    layer.instanceTransform = transform;
    layer.instanceAlphaOffset = -0.7;
    [imgv.layer addSublayer:layer];
}

@end

