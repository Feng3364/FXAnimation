//
//  SystemTransitionVC.m
//  FXAnimation
//
//  Created by Felix on 2021/8/11.
//

#import "SystemTransitionVC.h"

typedef NS_ENUM(NSUInteger, AnimationType) {
    Fade = 1,               // 淡入淡出
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
