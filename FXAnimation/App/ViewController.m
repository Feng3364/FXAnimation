//
//  ViewController.m
//  FXAnimation
//
//  Created by Felix on 2021/7/30.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy)   NSArray<NSDictionary *> *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}

#pragma mark - UI
- (void)setupUI {
    self.navigationItem.title = @"FXAnimation";
    [self.view addSubview:self.tableView];
}

#pragma mark - Data
- (void)setupData {
    self.dataArray = @[
        @{@"title": @"基础动画", @"list": @[
            @{@"title": @"平移+旋转+变色", @"vc": @"CABasicAnimationVC"},
            @{@"title": @"Layer展示图片", @"vc": @"CGImageVC"},
            @{@"title": @"景深区分", @"vc": @"ZPositionVC"},
            @{@"title": @"3D旋转", @"vc": @"CGTransform3DVC"},
            @{@"title": @"透视投影实现立体盒子", @"vc": @"CGTransformPracticeVC"},
        ]},
        @{@"title": @"Layer图层", @"list": @[
            @{@"title": @"CAShapeLayer实现火柴人", @"vc": @"CAShapeLayerVC"},
            @{@"title": @"CATextLayer替代UILabel", @"vc": @"CATextLayerVC"},
            @{@"title": @"CATransformLayer实现立体三维图形效果", @"vc": @"CATransformLayerVC"},
            @{@"title": @"CAGradientLayer实现渐变效果", @"vc": @"CAGradientLayerVC"},
            @{@"title": @"CAReplicatorLayer实现镜面效果", @"vc": @"CAReplicatorLayerVC"},
            @{@"title": @"CAEmitterLayer实现粒子发射", @"vc": @"CAEmitterLayerVC"},
            @{@"title": @"AVPlayLayer视频播放", @"vc": @"AVPlayLayerVC"},
        ]},
        @{@"title": @"TabBar", @"list": @[
            @{@"title": @"事件穿透", @"vc": @"HitTestVC"},
            @{@"title": @"子视图超出父视图范围", @"vc": @"FXTabBarController"},
        ]},
        @{@"title": @"组合动画", @"list": @[
            @{@"title": @"雨滴", @"vc": @"RainEmitterVC"},
            @{@"title": @"点赞-动效", @"vc": @"ThumbVC"},
            @{@"title": @"摇晃抖动", @"vc": @"SharkVC"},
            @{@"title": @"贝塞尔曲线路径", @"vc": @"BezierPathAnimationVC"},
            @{@"title": @"拖拽小红点", @"vc": @"PanGestureVC"},
            @{@"title": @"系统转场动画", @"vc": @"SystemTransitionVC"},
            @{@"title": @"自定义转场动画", @"vc": @"CustomTransitionVC"},
            @{@"title": @"喜欢-动效", @"vc": @"LikeVC"},
            @{@"title": @"文本放大动效", @"vc": @"LabelVC"},
            @{@"title": @"音乐播放效果", @"vc": @"MusicVC"},
            @{@"title": @"持续放大缩小效果", @"vc": @"ScaleVC"},
        ]},
        @{@"title": @"实操案例", @"list": @[
            @{@"title": @"注册场景", @"vc": @"RegisterVC"},
            @{@"title": @"树叶飘落", @"vc": @"LeafVC"},
            @{@"title": @"标题隐藏", @"vc": @"ScrollVC"},
            @{@"title": @"登录场景", @"vc": @"LoginVC"},
        ]},
    ];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *list = self.dataArray[section][@"list"];
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSArray *list = self.dataArray[indexPath.section][@"list"];
    cell.textLabel.text = list[indexPath.row][@"title"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = self.dataArray[section][@"title"];
    return title;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    NSArray *list = self.dataArray[indexPath.section][@"list"];
    NSDictionary *dict = list[indexPath.row];
    UIViewController *vc = [NSClassFromString(dict[@"vc"]) new];
    vc.navigationItem.title = dict[@"title"];
    vc.view.backgroundColor = UIColor.whiteColor;
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.showsHorizontalScrollIndicator = false;
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.rowHeight = 52;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = [UIView new];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

@end
