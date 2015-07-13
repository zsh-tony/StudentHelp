//
//  Account.h
//  weibo
//
//  Created by zsh tony on 14-7-27.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Account : NSObject<NSCoding>
@property (nonatomic , copy)NSString *accessToken;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *screenName;
@property (nonatomic,copy)NSString *schoolName;

@property (nonatomic,strong)User *userSelf;
@end
