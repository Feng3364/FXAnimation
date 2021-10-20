//
//  LoginVC.m
//  FXAnimation
//
//  Created by Felix on 2021/10/20.
//

#import "LoginVC.h"

#define ScreenWidth UIScreen.mainScreen.bounds.size.width

@interface LoginVC ()

@property (nonatomic, strong) UITextField *username;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation LoginVC

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGPoint usernameCenter = _username.center;
    CGPoint passwordCenter = _password.center;
    _loginBtn.alpha = 0;
    
    usernameCenter.x -= ScreenWidth;
    passwordCenter.x -= ScreenWidth;
    
    _username.center = usernameCenter;
    _password.center = passwordCenter;
    
    usernameCenter.x += ScreenWidth;
    passwordCenter.x += ScreenWidth;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.username.center = usernameCenter;
    }];
    
    [UIView animateWithDuration: 0.5 delay: 0.35 options: 0 animations: ^{
        self.password.center = passwordCenter;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration: 0.2 delay: 0 usingSpringWithDamping: 0.5 initialSpringVelocity: 0 options: 0 animations: ^{
            self.loginBtn.alpha = 1;
        } completion: nil];
    }];
}

#pragma mark - UI
- (void)setupUI {
    _username = [self createTextFieldWithPlaceholder:@"请输入用户名" frame:CGRectMake(30, 100, ScreenWidth - 60, 50)];
    [self.view addSubview:_username];
    
    _password = [self createTextFieldWithPlaceholder:@"请输入密码" frame:CGRectMake(30, 170, ScreenWidth - 60, 50)];
    [self.view addSubview:_password];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.frame = CGRectMake(30, 240, ScreenWidth - 60, 50);
    [_loginBtn setTitle:@"login" forState:UIControlStateNormal];
    [self.view addSubview:_loginBtn];
}

#pragma mark - Private
- (UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder frame:(CGRect)frame {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    return textField;
}

@end
