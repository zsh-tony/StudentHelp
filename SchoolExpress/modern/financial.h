//
//  financial.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-13.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailReward.h"
@interface financial : NSObject
@property (nonatomic,strong)NSString *totalPoints;

@property (nonatomic,strong)NSString *activityRewardStr;

@property (nonatomic,strong)NSString *orderRewardStr;

@property (nonatomic,strong)DetailReward *detailRward;
@end
