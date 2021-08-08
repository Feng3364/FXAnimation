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
    @{@"title": @"平移+旋转+变色", @"vc": @"CABasicAnimationVC"},
    @{@"title": @"layer展示图片", @"vc": @"CGImageVC"},
    @{@"title": @"垂直轴偏移", @"vc": @"ZPositionVC"},
    @{@"title": @"事件穿透", @"vc": @"HitTestVC"},
    @{@"title": @"旋转", @"vc": @"CGTransform3DVC"},
    @{@"title": @"旋转综合训练", @"vc": @"CGTransformPracticeVC"},
    @{@"title": @"旋转图层", @"vc": @"CATransformLayerVC"},
    @{@"title": @"渐变色图层", @"vc": @"CAGradientLayerVC"},
    @{@"title": @"反射图层", @"vc": @"CAReplicatorLayerVC"},
    @{@"title": @"粒子发射", @"vc": @"CAEmitterLayerVC"},
    @{@"title": @"雨滴", @"vc": @"RainEmitterVC"},
    @{@"title": @"点赞", @"vc": @"ThumbVC"},
    ];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    UIViewController *vc = [NSClassFromString(dict[@"vc"]) new];
    vc.navigationItem.title = dict[@"title"];
    vc.view.backgroundColor = UIColor.whiteColor;
    vc.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController pushViewController:vc animated:true];
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
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return _tableView;
}

@end
