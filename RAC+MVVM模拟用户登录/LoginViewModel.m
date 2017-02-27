//
//  LoginViewModel.m
//  RAC+MVVM模拟用户登录
//
//  Created by 薛涛 on 17/2/27.
//  Copyright © 2017年 Xuetao. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (Account *)account {
    if (_account == nil) {
        _account = [[Account alloc] init];
    }
    return _account;
}


- (id)init {
    if (self = [super init]) {
        [self initBind];
    }
    return self;
}

// 初始化绑定
- (void)initBind {
    // 监听账号的属性值改变  把他们聚合成一个信号
    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.account, user),RACObserve(self.account, password)] reduce:^id(NSString *user, NSString *pwd){
        return @(user.length && pwd.length);
    }];
    
    // 处理登录业务逻辑
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"点击了登录");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           // 模仿网络延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"登录成功"];
                // 数据传输完毕 必须调用完成 否则命令会永远处于执行状态
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    
    // 监听登录产生的数据
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        if ([x isEqualToString:@"登录成功"]) {
            NSLog(@"登录成功");
        }
    }];
    
    // 监听登录状态
    [[_loginCommand.executing skip:1] subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            NSLog(@"正在登录");
        } else {
            NSLog(@"登录成功");
        }
    }];
}

@end
