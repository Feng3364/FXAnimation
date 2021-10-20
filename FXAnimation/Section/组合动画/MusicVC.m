//
//  MusicVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/21.
//

/*
 思路:
 1.旋转+音符
 2.CD动画：绕z轴旋转
 3.音符动画：移动+缩放+旋转+透明度
 */

#import "MusicVC.h"

#pragma mark - UIViewController-MusicVC
@interface MusicVC ()

@end

@implementation MusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = UIColor.redColor;
}

#pragma mark - UI
- (void)setupUI {
    MusicAlbumView *musicAlbum = [[MusicAlbumView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80 - 10, self.view.bounds.size.height - 80 - 88 - 10, 80, 80)];
    [musicAlbum.album setImage:[UIImage imageNamed:@"AppIcon"]];
    [musicAlbum startAnimation:12];
    [self.view addSubview:musicAlbum];
}

@end


#pragma mark - UIView-MusicAlbumView
@interface MusicAlbumView ()

@property (nonatomic, strong) UIView *albumContainer;
@property (nonatomic, strong) NSMutableArray<CALayer *> *noteLayers;

@end

@implementation MusicAlbumView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupData];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI {
    self.albumContainer = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.albumContainer];
    
    CALayer *bgLayer = [CALayer layer];
    bgLayer.frame = self.bounds;
    bgLayer.contents = (id)[UIImage imageNamed:@"music_cover"].CGImage;
    [self.albumContainer.layer addSublayer:bgLayer];
    
    CGFloat width = CGRectGetWidth(self.frame) / 2.0f;
    CGFloat height = CGRectGetHeight(self.frame) / 2.0f;
    CGRect albumFrame = CGRectMake(width / 2.0f, height / 2.0f, width, height);
    self.album = [[UIImageView alloc] initWithFrame:albumFrame];
    self.album.contentMode = UIViewContentModeScaleAspectFill;
    self.album.layer.cornerRadius = height / 2.0;
    self.album.layer.masksToBounds = true;
    [self.albumContainer addSubview:self.album];
}

#pragma mark - Data
- (void)setupData {
    self.noteLayers = [NSMutableArray array];
}

#pragma mark - Public
- (void)startAnimation:(CGFloat)rate {
    rate = fabs(rate);
    [self resetView];
    
    // 音符旋转
    [self addNoteAnimation:@"icon_home_musicnote1" delayTime:0.0f rate:rate];
    [self addNoteAnimation:@"icon_home_musicnote2" delayTime:1.0f rate:rate];
    [self addNoteAnimation:@"icon_home_musicnote1" delayTime:2.0f rate:rate];

    // 围绕z轴旋转
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
    rotationAnimation.duration = 6.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.albumContainer.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)resetView {
    [self.noteLayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull noteLayer, NSUInteger idx, BOOL * _Nonnull stop) {
        [noteLayer removeFromSuperlayer];
    }];
    [self.layer removeAllAnimations];
}

#pragma mark - Private
- (void)addNoteAnimation:(NSString *)imageName
               delayTime:(NSTimeInterval)delayTime
                    rate:(CGFloat)rate {
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.duration = rate / 4.0f;
    animationGroup.beginTime = CACurrentMediaTime() + delayTime;
    animationGroup.repeatCount = MAXFLOAT;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // 路径帧动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGFloat sideXLength = 40.0f;
    CGFloat sideYLength = 100.0f;
    CGPoint beginPoint = CGPointMake(CGRectGetMidX(self.bounds) - 5, CGRectGetMaxY(self.bounds));
    CGPoint endPoint = CGPointMake(beginPoint.x - sideXLength, beginPoint.y - sideYLength);
    
    NSInteger controlLength = 60;
    CGPoint controlPoint = CGPointMake(beginPoint.x - sideXLength/2.0f - controlLength,
                                       beginPoint.y - sideYLength/2.0f + controlLength);
    
    UIBezierPath *customPath = [UIBezierPath bezierPath];
    [customPath moveToPoint:beginPoint];
    [customPath addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    pathAnimation.path = customPath.CGPath;
    
    // 旋转帧动画
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    [rotationAnimation setValues:@[
        [NSNumber numberWithFloat:0],
        [NSNumber numberWithFloat:M_PI * 0.1],
        [NSNumber numberWithFloat:M_PI * -0.1]
    ]];
    
    // 透明度帧动画
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    [opacityAnimation setValues:@[
        [NSNumber numberWithFloat:0],
        [NSNumber numberWithFloat:0.2f],
        [NSNumber numberWithFloat:0.7f],
        [NSNumber numberWithFloat:0.2f],
        [NSNumber numberWithFloat:0]
    ]];
    
    // 缩放帧动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale";
    scaleAnimation.fromValue = @(1.0f);
    scaleAnimation.toValue = @(2.0f);
    
    // 组合
    [animationGroup setAnimations:@[pathAnimation, scaleAnimation, rotationAnimation, opacityAnimation]];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.opacity = 0.0f;
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:imageName].CGImage);
    layer.frame = CGRectMake(beginPoint.x, beginPoint.y, 10, 10);
    [layer addAnimation:animationGroup forKey:nil];
    [self.layer addSublayer:layer];
    [self.noteLayers addObject:layer];
}

@end
