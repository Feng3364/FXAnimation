//
//  RainEmitterVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/8.
//

#import "RainEmitterVC.h"

@interface RainEmitterVC ()

@property (nonatomic, strong) CAEmitterLayer * rainLayer;

@end

@implementation RainEmitterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupEmitter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = UIColor.blackColor;
}

#pragma mark - UI
- (void)setupUI {
    UIButton *rainBtn = [self createButtonWithTitle:@"下雨了"
                                         selectTitle:@"雨停了"
                                        btnSelected:true
                                                tag:0
                                                 sel:@"onClickRainButton:"];
    UIButton *rainMoreBtn = [self createButtonWithTitle:@"雨大了"
                                            selectTitle:@""
                                            btnSelected:false
                                                    tag:100
                                                    sel:@"onClickRainChangeButton:"];
    UIButton *rainLittleBtn = [self createButtonWithTitle:@"雨小了"
                                              selectTitle:@""
                                              btnSelected:false
                                                      tag:200
                                                      sel:@"onClickRainChangeButton:"];
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[rainBtn, rainMoreBtn, rainLittleBtn]];
    stackView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 40);
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.distribution = UIStackViewDistributionFillEqually;
    [self.view addSubview:stackView];
}

- (void)setupEmitter {
    CAEmitterCell *snowCell = [CAEmitterCell emitterCell];
    snowCell.contents = (id)[UIImage imageNamed:@"AppIcon"].CGImage;
    snowCell.birthRate = 25.f;
    snowCell.lifetime = 20.f;
    snowCell.speed = 10.f;
    snowCell.velocity = 10.f;
    snowCell.velocityRange = 10.f;
    snowCell.yAcceleration = 1000.f;
    snowCell.scale = 0.1;
    snowCell.scaleRange = 0.f;
    
    _rainLayer = [CAEmitterLayer layer];
    _rainLayer.emitterShape = kCAEmitterLayerLine;
    _rainLayer.emitterMode = kCAEmitterLayerSurface;
    _rainLayer.emitterSize = self.view.frame.size;
    _rainLayer.emitterPosition = CGPointMake(self.view.bounds.size.width * 0.5, -10);
    _rainLayer.emitterCells = @[snowCell];
    [self.view.layer addSublayer:_rainLayer];
}

#pragma mark - Action
- (void)onClickRainButton:(UIButton *)sender {
    if (sender.selected) {
        [_rainLayer setValue:@0.f forKeyPath:@"birthRate"];
    } else {
        [_rainLayer setValue:@1.f forKeyPath:@"birthRate"];
    }
    
    sender.selected = !sender.selected;
}

- (void)onClickRainChangeButton:(UIButton *)sender {
    NSInteger rate = 1;
    CGFloat scale = 0.05;
    
    if (sender.tag == 100) {
        if (_rainLayer.birthRate < 30) {
            [_rainLayer setValue:@(_rainLayer.birthRate + rate) forKeyPath:@"birthRate"];
            [_rainLayer setValue:@(_rainLayer.scale + scale) forKeyPath:@"scale"];
        }
    } else if (sender.tag == 200) {
        if (_rainLayer.birthRate > 1) {
            [_rainLayer setValue:@(_rainLayer.birthRate - rate) forKeyPath:@"birthRate"];
            [_rainLayer setValue:@(_rainLayer.scale - scale) forKeyPath:@"scale"];
        }
    }
}

#pragma mark - Private
- (UIButton *)createButtonWithTitle:(NSString *)title
                        selectTitle:(NSString *)selectTitle
                        btnSelected:(BOOL)btnSelected
                                tag:(NSInteger)tag
                                sel:(NSString *)sel {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:selectTitle forState:UIControlStateSelected];
    btn.selected = btnSelected;
    btn.tag = tag;
    [btn addTarget:self action:NSSelectorFromString(sel) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
