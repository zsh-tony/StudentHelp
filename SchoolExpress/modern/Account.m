//
//  Account.m
//  weibo
//
//  Created by zsh tony on 14-7-27.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import "Account.h"

@implementation Account

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _accessToken = [aDecoder decodeObjectForKey:kAccessToken];
        _userId = [aDecoder decodeObjectForKey:kUid];
        _screenName = [aDecoder decodeObjectForKey:@"screen_name"];
        _schoolName = [aDecoder decodeObjectForKey:@"school_name"];
        _userSelf = [aDecoder decodeObjectForKey:@"userSelf"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_accessToken forKey:kAccessToken];
    [aCoder encodeObject:_userId forKey:kUid];
    [aCoder encodeObject:_screenName forKey:@"screen_name"];
    [aCoder encodeObject:_schoolName forKey:@"school_name"];
    [aCoder encodeObject:_userSelf forKey:@"userSelf"];
}
@end
