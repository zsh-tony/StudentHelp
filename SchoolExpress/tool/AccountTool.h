//
//  AccountTool.h
//  weibo
//
//  Created by zsh tony on 14-8-1.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class Account;
@interface AccountTool : NSObject
singleton_interface(AccountTool)
@property (nonatomic,strong,/*readonly*/)Account *currentAccount;//只能拿不能赋值，但是登陆控制器的归档有bug，所以开放这个接口
-(void)addAccount:(Account *)account;
@end
