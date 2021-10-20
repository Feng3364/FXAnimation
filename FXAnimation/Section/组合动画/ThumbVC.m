//
//  ThumbVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/8.
//

/*
 思路:
 1.重写按钮的选中效果
 2.使用关键帧动画（transform.scale）完成放大效果
 3.放大之后实现粒子效果
 4.取消点赞时移除动画
 */

#import "ThumbVC.h"

#pragma mark - UIViewController-ThumbVC
@interface ThumbVC ()

@end

@implementation ThumbVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    LikeButton *btn = [LikeButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(200, 150, 30, 130);
    [btn setImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"like_orange"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(onClickThunmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - Action
- (void)onClickThunmBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end


#pragma mark - UIButton-LikeButton
@implementation LikeButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupExplosion];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupExplosion];
}

- (void)setupExplosion {
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"explosionCell";
    explosionCell.alphaSpeed = -1.f;
    explosionCell.alphaRange = 0.10;
    explosionCell.lifetime = 1;
    explosionCell.lifetimeRange = 0.1;
    explosionCell.velocity = 40.f;
    explosionCell.velocityRange = 10.f;
    explosionCell.scale = 0.08;
    explosionCell.scaleRange = 0.02;
    explosionCell.contents = (id)[[UIImage imageNamed:@"spark_red"] CGImage];
    
    _explosionLayer = [CAEmitterLayer layer];
    _explosionLayer.emitterSize = CGSizeMake(self.bounds.size.width + 40, self.bounds.size.height + 40);
    _explosionLayer.emitterShape = kCAEmitterLayerCircle;
    _explosionLayer.emitterMode = kCAEmitterLayerOutline;
    _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    _explosionLayer.emitterCells = @[explosionCell];
    [self.layer addSublayer:_explosionLayer];
}

- (void)layoutSubviews {
    _explosionLayer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    
    if (selected) {
        animation.values = @[@1.5,@2.0, @0.8, @1.0];
        animation.duration = 0.5;
        animation.calculationMode = kCAAnimationCubic;
        [self.layer addAnimation:animation forKey:nil];
        [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.25];
    } else {
        [self stopAnimation];
    }
}

/// 取消高亮
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:false];
}

- (void)startAnimation {
    [_explosionLayer setValue:@1000 forKeyPath:@"emitterCells.explosionCell.birthRate"];
    _explosionLayer.beginTime = CACurrentMediaTime();
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
}

- (void)stopAnimation {
    [_explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosionCell.birthRate"];
    [_explosionLayer removeAllAnimations];
}

@end
