//
//  LoginViewModel.h
//  RAC+MVVM模拟用户登录
//
//  Created by 薛涛 on 17/2/27.
//  Copyright © 2017年 Xuetao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "ReactiveCocoa.h"

@interface LoginViewModel : NSObject

@property (nonatomic, strong) Account *account;
@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
