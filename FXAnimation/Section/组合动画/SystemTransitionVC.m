//
//  SystemTransitionVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/11.
//

#import "SystemTransitionVC.h"

#define TIME_DURATION 1.0f

typedef NS_ENUM(NSUInteger, AnimationType) {
    Fade,               // 淡入淡出
    Push,                   // 推挤
    Reveal,                 // 揭开
    MoveIn,                 // 覆盖
    Cube,                   // 立方体
    SuckEffect,             // 吮吸
    OglFlip,                // 翻转
    RippleEffect,           // 波纹
    PageCurl,               // 翻页
    PageUnCurl,             // 反翻页
    CameraIrisHollowOpen,   // 开镜头
    CameraIrisHollowClose,  // 关镜头
    CurlDown,               // 下翻页
    CurlUp,                 // 上翻页
    FlipFromLeft,           // 左翻转
    FlipFromRight,          // 右翻转
};

@interface SystemTransitionVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy)   NSArray<NSString *> *dataArray;
@property (nonatomic, assign) int subtype;
@property (nonatomic, assign) bool isRed;

@end

@implementation SystemTransitionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}

#pragma mark - UI
- (void)setupUI {
    [self.view addSubview:self.tableView];
}

#pragma mark - Data
- (void)setupData {
    self.dataArray = @[
        @"Fade  淡入淡出",
        @"Push  推挤",
        @"Reveal  揭开",
        @"MoveIn  覆盖",
        @"Cube  立方体",
        @"SuckEffect  吮吸",
        @"OglFlip  翻转",
        @"RippleEffect  波纹",
        @"PageCurl  翻页",
        @"PageUnCurl  反翻页",
        @"CameraIrisHollowOpen  开镜头",
        @"CameraIrisHollowClose  关镜头",
        @"CurlDown  下翻页",
        @"CurlUp  上翻页",
        @"FlipFromLeft  左翻转",
        @"FlipFromRight  右翻转",
    ];
}

#pragma mark - CATransition 动画实现
- (void)transitionWithType:(NSString *)type withSubType:(NSString *)subType forView:(UIView *)view {
    CATransition *animation = [[CATransition alloc] init];
    animation.duration = TIME_DURATION;
    animation.type = type;
    if (subType != nil) {
        animation.subtype = subType;
    }
    [view.layer addAnimation:animation forKey:@"animation"];
}

#pragma mark - CATransition 动画实现
- (void)animationWithView:(UIView *)view withAnimationTransition:(UIViewAnimationTransition)transition {
    [UIView animateWithDuration:TIME_DURATION animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *subTypeString;
    switch (_subtype) {
        case 0:
            subTypeString = kCATransitionFromLeft;
            break;
            
        case 1:
            subTypeString = kCATransitionFromBottom;
            break;
            
        case 2:
            subTypeString = kCATransitionFromRight;
            break;
            
        case 3:
            subTypeString = kCATransitionFromTop;
            break;
            
        default:
            break;
    }
    
    _subtype++;
    if (_subtype>3) {
        _subtype =0;
    }
    
    AnimationType animationType = indexPath.row;
    switch (animationType) {
        case Fade:
            self.isRed = !self.isRed;
            self.view.backgroundColor = self.isRed ? UIColor.redColor : UIColor.greenColor;
            [self transitionWithType:kCATransitionFade withSubType:subTypeString forView:self.view];
            break;
            
        case Push:
            [self transitionWithType:kCATransitionPush withSubType:subTypeString forView:self.view];
            break;
            
        case Reveal:
            [self transitionWithType:kCATransitionReveal withSubType:subTypeString forView:self.view];
            break;
            
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn withSubType:subTypeString forView:self.view];
            break;
            
        case Cube:
            [self transitionWithType:@"cube" withSubType:subTypeString forView:self.view];
            break;
            
        case SuckEffect:
            self.isRed = !self.isRed;
            self.view.backgroundColor = self.isRed ? UIColor.redColor : UIColor.greenColor;
            [self transitionWithType:@"suckEffect" withSubType:subTypeString forView:self.view];
            break;
            
        case OglFlip:
            [self transitionWithType:@"oglFlip" withSubType:subTypeString forView:self.view];
            break;
            
        case RippleEffect:
            self.isRed = !self.isRed;
            self.view.backgroundColor = self.isRed ? UIColor.redColor : UIColor.greenColor;
            [self transitionWithType:@"rippleEffect" withSubType:subTypeString forView:self.view];
            break;
            
        case PageCurl:
            [self transitionWithType:@"pageCurl" withSubType:subTypeString forView:self.view];
            break;
            
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" withSubType:subTypeString forView:self.view];
            break;
            
        case CameraIrisHollowOpen:
            self.isRed = !self.isRed;
            self.view.backgroundColor = self.isRed ? UIColor.redColor : UIColor.greenColor;
            [self transitionWithType:@"cameraIrisHollowOpen" withSubType:subTypeString forView:self.view];
            break;
            
        case CameraIrisHollowClose:
            self.isRed = !self.isRed;
            self.view.backgroundColor = self.isRed ? UIColor.redColor : UIColor.greenColor;
            [self transitionWithType:@"cameraIrisHollowClose" withSubType:subTypeString forView:self.view];
            break;
           
        case CurlDown:
            [self animationWithView:self.view withAnimationTransition:UIViewAnimationTransitionCurlDown];
            break;
            
        case CurlUp:
            [self animationWithView:self.view withAnimationTransition:UIViewAnimationTransitionCurlUp];
            break;
        
        case FlipFromLeft:
            [self animationWithView:self.view withAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
        
        case FlipFromRight:
            [self animationWithView:self.view withAnimationTransition:UIViewAnimationTransitionFlipFromRight];
            break;
    }
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 400) style:UITableViewStylePlain];
        _tableView.showsHorizontalScrollIndicator = false;
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.rowHeight = 52;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

@end
