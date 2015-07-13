//
//  OrderReward.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-15.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    OrderRewardType = 0,
    ActivityRewardType = 1,
} RewardType;
@interface DetailReward : NSObject
@property (nonatomic,assign)RewardType rewardType;
@property (nonatomic,strong)NSString *orderTime;
@property (nonatomic,strong)NSString *point;
-(id)initWithDict:(NSDictionary *)dict;
@end
