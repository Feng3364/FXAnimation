//
//  CGImageVC.m
//  FXAnimation
//
//  Created by Felix on 2021/7/30.
//

#import "CGImageVC.h"

@interface CGImageVC ()

@end

@implementation CGImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    UIImage *image = [UIImage imageNamed:@"AppIcon"];
    self.view.layer.contents = (__bridge  id)image.CGImage;
    
    // 填充方式
    self.view.contentMode = UIViewContentModeScaleAspectFit;
    self.view.layer.contentsGravity = kCAGravityResizeAspect;
}

@end
