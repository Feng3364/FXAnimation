//
//  LikeVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/11.
//

#import "LikeVC.h"
#define FavoriteViewLikeBeforeTag 1 //点赞
#define FavoriteViewLikeAfterTag  2 //取消点赞

#pragma mark - UIView-LikeView
@interface LikeView ()

@property (nonatomic, strong) UIImageView *likeBefore;
@property (nonatomic, strong) UIImageView *likeAfter;
@property (nonatomic, assign) CGFloat     likeDuration;
@property (nonatomic, strong) UIColor     *zanFillColor;

@end

@implementation LikeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _likeBefore = [[UIImageView alloc] initWithFrame:frame];
        _likeBefore.contentMode = UIViewContentModeCenter;
        _likeBefore.image = [UIImage imageNamed:@"icon_home_like_before"];
        _likeBefore.userInteractionEnabled = true;
        _likeBefore.tag = FavoriteViewLikeBeforeTag;
        [_likeBefore addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
        [self addSubview:_likeBefore];
        
        _likeAfter = [[UIImageView alloc] initWithFrame:frame];
        _likeAfter.contentMode = UIViewContentModeCenter;
        _likeAfter.image = [UIImage imageNamed:@"icon_home_like_after"];
        _likeAfter.userInteractionEnabled = true;
        _likeAfter.tag = FavoriteViewLikeAfterTag;
        [_likeAfter addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
        [self addSubview:_likeAfter];
    }
    return self;
}

- (void)handleGesture:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case FavoriteViewLikeBeforeTag: {
            //开始动画(点赞)
            [self startLikeAnim:YES];
            break;
        }
        case FavoriteViewLikeAfterTag: {
            //开始动画(取消点赞)
            [self startLikeAnim:NO];
            break;
        }
    }
}

-(void)startLikeAnim:(BOOL)isLike {
    _likeBefore.userInteractionEnabled = false;
    _likeAfter.userInteractionEnabled = false;
    
    if (isLike) {
        CGFloat length = 30;
        CGFloat duration = self.likeDuration > 0 ? self.likeDuration : 0.5f;
        
        for (int i = 0; i < 6; i++) {
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.position = _likeBefore.center;
            layer.fillColor = self.zanFillColor == nil ? UIColor.redColor.CGColor : self.zanFillColor.CGColor;
            
            UIBezierPath *startPath = [UIBezierPath bezierPath];
            [startPath moveToPoint:CGPointMake(-2, -length)];
            [startPath addLineToPoint:CGPointMake(2, -length)];
            [startPath addLineToPoint:CGPointMake(0, 0)];
            layer.path = startPath.CGPath;
            
            layer.transform = CATransform3DMakeRotation(M_PI / 3.0f * i, 0.0, 0.0, 1.0);
            [self.layer addSublayer:layer];
            
            CAAnimationGroup *group = [CAAnimationGroup animation];
            group.removedOnCompletion = false;
            group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            group.fillMode = kCAFillModeForwards;
            group.duration = duration;
            
            CABasicAnimation *scaleAnimate = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimate.fromValue = @0.0;
            scaleAnimate.toValue = @1.0;
            scaleAnimate.duration = duration * 0.2f;
            
            UIBezierPath *endPath = [UIBezierPath bezierPath];
            [endPath moveToPoint:CGPointMake(-2, -length)];
            [endPath addLineToPoint:CGPointMake(2, -length)];
            [endPath addLineToPoint:CGPointMake(0, -length)];
            
            CABasicAnimation *pathAnim = [CABasicAnimation animationWithKeyPath:@"path"];
            pathAnim.fromValue = (__bridge id)layer.path;
            pathAnim.toValue = (__bridge id)endPath.CGPath;
            pathAnim.beginTime = duration * 0.2f;
            pathAnim.duration = duration * 0.8f;
            [group setAnimations:@[scaleAnimate, pathAnim]];
            [layer addAnimation:group forKey:nil];
        }
        
        [_likeAfter setHidden:NO];
        _likeAfter.alpha = 0.0f;
        _likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI/3*2), 0.5f, 0.5f);
        [UIView animateWithDuration:0.4f
                              delay:0.2f
             usingSpringWithDamping:0.6f
              initialSpringVelocity:0.8f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.likeBefore.alpha = 0.0f;
                             self.likeAfter.alpha = 1.0f;
                             self.likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(0), 1.0f, 1.0f);
                         }
                         completion:^(BOOL finished) {
                             self.likeBefore.alpha = 1.0f;
                             self.likeBefore.userInteractionEnabled = YES;
                             self.likeAfter.userInteractionEnabled = YES;
                         }];
    } else {
        _likeAfter.alpha = 1.0f;
        _likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(0), 1.0f, 1.0f);
        [UIView animateWithDuration:0.35f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI_4), 0.1f, 0.1f);
        } completion:^(BOOL finished) {
            [self.likeAfter setHidden:true];
            self.likeBefore.userInteractionEnabled = true;
            self.likeAfter.userInteractionEnabled = true;
        }];
    }
}

@end


#pragma mark - UIViewController-LikeVC
@interface LikeVC ()
@property (nonatomic, strong) LikeView *likeView;
@end

@implementation LikeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    CGFloat cx = 5;
    CGFloat width = 50 * cx;
    CGFloat height = 45 * cx;
    self.likeView = [[LikeView alloc] initWithFrame:CGRectMake(100, 100, width, height)];
   
    self.likeView.likeDuration = 0.5;
    self.likeView.zanFillColor = [UIColor redColor];
    [self.view addSubview:self.likeView];
    self.view.backgroundColor = [UIColor blackColor];
}

@end
