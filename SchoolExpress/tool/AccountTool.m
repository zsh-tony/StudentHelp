//
//  AccountTool.m
//  weibo
//
//  Created by zsh tony on 14-8-1.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import "AccountTool.h"
#define kFileName @"accounts.data"
#define kCurrentName @"currentAcount.data"
#import "Account.h"
#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)[0] stringByAppendingPathComponent:kFileName]
#define kCurrentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)[0] stringByAppendingPathComponent:kCurrentName]

@interface AccountTool()
{
    NSMutableArray *accounts;
}

@end

@implementation AccountTool
singleton_implementation(AccountTool)

-(id)init
{
    if (self = [super init]) {

  
        accounts = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        _currentAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:kCurrentPath];
        if (accounts ==nil) {
            accounts = [NSMutableArray array];
        }
    }
    return self;
}

-(void)addAccount:(Account *)account
{
    [accounts addObject:account];
    //NSLog(@"%@",accounts[0]);
    _currentAccount = account;
    
    [NSKeyedArchiver archiveRootObject:_currentAccount toFile:kCurrentPath];
    [NSKeyedArchiver archiveRootObject:accounts toFile:kFilePath];
    
}
@end
