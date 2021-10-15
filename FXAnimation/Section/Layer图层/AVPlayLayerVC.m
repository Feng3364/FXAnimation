//
//  AVPlayLayerVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/8.
//

#import "AVPlayLayerVC.h"
#import <AVFoundation/AVFoundation.h>

#define ScreenWidth UIScreen.mainScreen.bounds.size.width

static CATransform3D CATransform3DMakePerspective(CGFloat z) {
    CATransform3D t = CATransform3DIdentity;
    t.m34 = - 1.0 / z;
    return t;
}

@interface AVPlayLayerVC ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation AVPlayLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"mp4"];
    self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:videoPath]];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = CGRectMake((ScreenWidth - 300) / 2.0, 0, 300, 180);
    playerLayer.borderColor = UIColor.blackColor.CGColor;
    playerLayer.borderWidth = 1.0;
    playerLayer.shadowOffset = CGSizeMake(0, 3);
    playerLayer.shadowOpacity = 0.80;
    self.view.layer.sublayerTransform = CATransform3DMakePerspective(1000);
    [self.view.layer addSublayer:playerLayer];
    [self.player play];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    slider.minimumValue = -1.0;
    slider.maximumValue = 1.0;
    slider.continuous = NO;
    slider.value = 0.0;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchDragInside];
    
    UIButton *spinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    spinButton.frame = CGRectMake(0, 30, 50, 30);
    [spinButton setTitle:@"Spin" forState:UIControlStateNormal];
    [spinButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [spinButton addTarget:self action:@selector(spinIt) forControlEvents:UIControlEventTouchUpInside];
    
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[slider, spinButton]];
    stackView.frame = CGRectMake(0, 200, ScreenWidth, 60);
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFillEqually;
    [self.view addSubview:stackView];
}

#pragma mark - Action
- (void)sliderValueChanged:(UISlider *)sender {
    CALayer *layer = [self.view.layer sublayers].firstObject;
    layer.transform = CATransform3DMakeRotation([sender value], 0, 1, 0);
}

- (void)spinIt {
    CALayer *layer = [self.view.layer sublayers][0];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.duration = 1.25f;
    animation.toValue = @(360 * M_PI / 180);
    [layer addAnimation:animation forKey:@"spinAnimation"];
}

@end
