//
//  AVPlayLayerVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/8.
//

#import "AVPlayLayerVC.h"
#import <AVFoundation/AVFoundation.h>

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
    playerLayer.frame = CGRectMake(100, 210, 300, 180);
    playerLayer.borderColor = UIColor.blackColor.CGColor;
    playerLayer.borderWidth = 1.0;
    playerLayer.shadowOffset = CGSizeMake(0, 3);
    playerLayer.shadowOpacity = 0.80;
    self.view.layer.sublayerTransform = CATransform3DMakePerspective(1000);
    [self.view.layer addSublayer:playerLayer];
    
    [self.player play];
}

@end
