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
    //macOS上contents对UIImage/CGImage都会起作用，但是iOS上必须转成id类型
    self.view.layer.contents = (__bridge id)image.CGImage;
    
    // 填充方式（layer.contentsGravity类似于contentMode）
    self.view.contentMode = UIViewContentModeScaleAspectFit;
    self.view.layer.contentsGravity = kCAGravityResizeAspect;
}

@end
