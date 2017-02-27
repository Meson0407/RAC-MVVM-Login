//
//  ViewController.m
//  RAC+MVVM模拟用户登录
//
//  Created by 薛涛 on 17/2/27.
//  Copyright © 2017年 Xuetao. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewModel.h"

@interface ViewController ()

@property (nonatomic, strong) LoginViewModel *loginViewModel;
@property (weak, nonatomic) IBOutlet UITextField *usernumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation ViewController

- (LoginViewModel *)loginViewModel {
    if (_loginViewModel == nil) {
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 给模型的属性绑定信号
    // 只要账号文本框改变，就会给account赋值
    RAC(self.loginViewModel.account, user) = _usernumber.rac_textSignal;
    RAC(self.loginViewModel.account, password) = _password.rac_textSignal;
    
    // 绑定登录按钮
    RAC(self.login, enabled) = self.loginViewModel.enableLoginSignal;
    
    // 监听登录按钮点击
    [[_login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        // 执行登录事件
        [self.loginViewModel.loginCommand execute:nil];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
