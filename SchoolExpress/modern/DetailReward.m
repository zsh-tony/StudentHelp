//
//  OrderReward.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-15.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "DetailReward.h"

@implementation DetailReward
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.orderTime = dict[@"orderTime"];
        self.point = dict[@"point"];
        self.rewardType = [dict[@"rewardType"]intValue];
        
            }
    return self;
    
}

@end
