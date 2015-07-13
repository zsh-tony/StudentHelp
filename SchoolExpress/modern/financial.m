//
//  financial.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-13.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "financial.h"
#import "DetailReward.h"
@implementation financial
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.totalPoints = dict[@"totalPoints"];
        self.activityRewardStr = dict[@"activityRewardStr"];
        self.orderRewardStr = dict[@"orderRewardStr"];
        NSDictionary *detailRewardDict = dict[@"detailReward"];
        if (detailRewardDict != nil) {
            self.detailRward = [[DetailReward alloc]initWithDict:detailRewardDict];
        }
        
    }
    return self;
    
}
@end
