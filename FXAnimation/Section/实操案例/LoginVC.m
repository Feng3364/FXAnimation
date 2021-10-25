//
//  LoginVC.m
//  FXAnimation
//
//  Created by Felix on 2021/10/21.
//

#import "LoginVC.h"

#define ScreenWidth UIScreen.mainScreen.bounds.size.width

@interface LoginVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *avatarImgv;
@property (nonatomic, strong) UITextField *username;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *expandBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy)   NSArray *dataArray;

@end

@implementation LoginVC

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}

#pragma mark - UI
- (void)setupUI {
    [self.view addSubview:self.avatarImgv];
    [self.view addSubview:self.username];
    [self.view addSubview:self.password];
    [self.view addSubview:self.loginBtn];
    [self.username addSubview:self.expandBtn];
    [self.view addSubview:self.tableView];
}

- (void)setupData {
    self.dataArray = @[@"Felix", @"Feng", @"xxx", @"xxx", @"xxx", @"xxx"];
}

#pragma mark - Action
- (void)onClickExpandButton:(UIButton *)sender {
    [self.view endEditing:true];
    [self animateToRotateButton:sender.isSelected];
    sender.isSelected ? [self showRecordList] : [self hideRecordList];
}

- (void)showRecordList {
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.tableView.frame = CGRectMake(30, 150, ScreenWidth - 60, 300);
    } completion:nil];
}

- (void)hideRecordList {
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.tableView.frame = CGRectMake(30, 150, ScreenWidth - 60, 0);
    } completion:nil];
}

#pragma mark - Private
- (UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder frame:(CGRect)frame {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    return textField;
}

- (void)animateToRotateButton:(BOOL)isSelected {
    CATransform3D transform = isSelected ? CATransform3DIdentity : CATransform3DMakeRotation(M_PI, 0, 0, 1);
    [_expandBtn setSelected:!isSelected];
    
    [UIView animateWithDuration: 0.25 animations: ^{
        self.expandBtn.layer.transform = transform;
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.backgroundColor = UIColor.redColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    self.username.text = self.dataArray[indexPath.row];
    [self hideRecordList];
}

#pragma mark - Lazy
- (UIImageView *)avatarImgv {
    if (!_avatarImgv) {
        _avatarImgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _avatarImgv.center = CGPointMake(ScreenWidth / 2, 50);
        _avatarImgv.image = [UIImage imageNamed:@"AppIcon"];
        _avatarImgv.layer.cornerRadius = 20;
        _avatarImgv.layer.masksToBounds = true;
    }
    return _avatarImgv;
}

- (UITextField *)username {
    if (!_username) {
        _username = [self createTextFieldWithPlaceholder:@"请输入用户名" frame:CGRectMake(30, 100, ScreenWidth - 60, 50)];
    }
    return _username;
}

- (UITextField *)password {
    if (!_password) {
        _password = [self createTextFieldWithPlaceholder:@"请输入密码" frame:CGRectMake(30, 170, ScreenWidth - 60, 50)];
    }
    return _password;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginBtn.frame = CGRectMake(30, 240, ScreenWidth - 60, 50);
        _loginBtn.backgroundColor = UIColor.systemGreenColor;
        [_loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    }
    return _loginBtn;
}

- (UIButton *)expandBtn {
    if (!_expandBtn) {
        _expandBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 60 - 50, 0, 50, 50)];
        [_expandBtn setTitle:@"∨" forState:UIControlStateNormal];
        [_expandBtn setTitleColor:UIColor.systemGrayColor forState:UIControlStateNormal];
        [_expandBtn addTarget:self action:@selector(onClickExpandButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expandBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 150, ScreenWidth - 60, 0) style:UITableViewStylePlain];
        _tableView.showsHorizontalScrollIndicator = false;
        _tableView.showsVerticalScrollIndicator = false;
        _tableView.rowHeight = 50;
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
