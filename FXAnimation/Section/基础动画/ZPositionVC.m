//
//  ZPositionVC.m
//  FXAnimation
//
//  Created by Felix on 2021/7/30.
//

/*
 思路:
 1.设置zPosition修改景深（可以粗略理解为修改图层层级）
 */

#import "ZPositionVC.h"

@interface ZPositionVC ()

@property (nonatomic, strong) CALayer *lowLayer;
@property (nonatomic, strong) CALayer *highLayer;

@end

@implementation ZPositionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    _lowLayer = [CALayer layer];
    _lowLayer.frame = CGRectMake(100, 100, 100, 100);
    _lowLayer.backgroundColor = UIColor.redColor.CGColor;
    [self.view.layer addSublayer:_lowLayer];
    
    _highLayer = [CALayer layer];
    _highLayer.frame = CGRectMake(150, 150, 100, 100);
    _highLayer.backgroundColor = UIColor.greenColor.CGColor;
    [self.view.layer addSublayer:_highLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 修改层次 默认是0.0
    _lowLayer.zPosition = _lowLayer.zPosition == 0.9 ? 0 : 0.9;
}

@end
