//
//  user.m
//  weibo
//
//  Created by zsh tony on 14-8-1.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import "user.h"
#import "HelpExpress.h"

@implementation User
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.userId = dict[@"userId"];
        self.nickName = dict[@"nickName"];
        self.profileImageUrl = dict[@"profileImageUrl"];
        
        self.verifiedType = [dict[@"verified_type"] intValue];
        self.verified = [dict[@"verified"]boolValue];
        self.personalSignature = dict[@"personalSignature"];
        //self.mbtype = [dict[@"mbtype"] intValue];
        //self.mbrank = [dict[@"mbrank"] intValue];
        

    }
    return self;

}


@end
