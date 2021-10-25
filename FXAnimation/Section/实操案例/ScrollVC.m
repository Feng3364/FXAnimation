//
//  ScrollVC.m
//  FXAnimation
//
//  Created by Felix on 2021/10/21.
//

#import "ScrollVC.h"

#define ScreenWidth     UIScreen.mainScreen.bounds.size.width
#define ScreenHeight    UIScreen.mainScreen.bounds.size.height
#define StatusHeight    [[UIApplication sharedApplication] statusBarFrame].size.height
#define NaviBarHeight   44
#define NaviHeight      StatusHeight+NaviBarHeight

static const int countTimeHeight = 40;

@interface ScrollVC () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UIView *fakeNavigator;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *countTimeView;
@property (nonatomic, strong) UILabel *countTimeLabel;

@end

@implementation ScrollVC

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - UI
- (void)setupUI {
    [self.view addSubview:self.scroll];
    [self.view addSubview:self.countTimeView];
    [self.view addSubview:self.fakeNavigator];
    [self.view addSubview:self.countTimeLabel];
    [self.fakeNavigator addSubview:self.titleLabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollY = scrollView.contentOffset.y;
    
    // 标题
    CGFloat offsetRate = scrollY / NaviBarHeight;
    offsetRate = MAX(0, MIN(1, offsetRate));
    self.titleLabel.alpha = 1 - offsetRate;
    
    // 倒计时视图
    CGFloat offsetY = MIN(NaviBarHeight + 10, MAX(0, scrollY));
    CGFloat originY = NaviHeight + 10;
    self.countTimeView.frame = CGRectMake(30, originY - offsetY, ScreenWidth - 60, countTimeHeight);
    self.countTimeLabel.frame = CGRectMake(30, originY - offsetY, ScreenWidth - 60, countTimeHeight);
    
    // 滚动视图
    CGFloat offsetY2 = MIN(NaviBarHeight + 20, MAX(0, scrollY));
    CGFloat scrollOriginY = NaviHeight + countTimeHeight + 20 - offsetY2;
    self.scroll.frame = CGRectMake(0, scrollOriginY, ScreenWidth, ScreenHeight - NaviHeight);
}

#pragma mark - Lazy
- (UIScrollView *)scroll {
    if (!_scroll) {
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 500)];
        redView.backgroundColor = UIColor.redColor;
        
        UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 500, ScreenWidth, 500)];
        yellowView.backgroundColor = UIColor.yellowColor;
        
        UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(0, 1000, ScreenWidth, 500)];
        greenView.backgroundColor = UIColor.greenColor;
        
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviHeight + countTimeHeight + 20, ScreenWidth, ScreenHeight - NaviHeight)];
        _scroll.delegate = self;
        if (@available(iOS 13.0, *)) {
            _scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _scroll.contentSize = CGSizeMake(ScreenWidth, 1500);
        [_scroll addSubview:redView];
        [_scroll addSubview:yellowView];
        [_scroll addSubview:greenView];
    }
    return _scroll;
}

- (UIView *)fakeNavigator {
    if (!_fakeNavigator) {
        _fakeNavigator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NaviHeight)];
        _fakeNavigator.backgroundColor = UIColor.systemBlueColor;
    }
    return _fakeNavigator;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, StatusHeight, ScreenWidth, NaviBarHeight)];
        _titleLabel.text = @"刷真题";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColor.whiteColor;
    }
    return _titleLabel;
}

- (UIView *)countTimeView {
    if (!_countTimeView) {
        _countTimeView = [[UIView alloc] initWithFrame:CGRectMake(30, NaviHeight + 10, ScreenWidth - 60, countTimeHeight)];
        _countTimeView.backgroundColor = UIColor.systemPinkColor;
    }
    return _countTimeView;
}

- (UILabel *)countTimeLabel {
    if (!_countTimeLabel) {
        _countTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, NaviHeight + 10, ScreenWidth - 60, countTimeHeight)];
        _countTimeLabel.text = @"还有00:00:28出现一道必考真题";
        _countTimeLabel.textAlignment = NSTextAlignmentCenter;
        _countTimeLabel.textColor = UIColor.whiteColor;
    }
    return _countTimeLabel;
}

@end
