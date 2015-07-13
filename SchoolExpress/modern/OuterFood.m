//
//  OuterFood.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-11.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "OuterFood.h"

@implementation OuterFood
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        
        self.titleText = dict[@"titleText"];
        self.messLocation = dict[@"messLocation"];
        self.foodTime = dict[@"foodTime"];
        self.foodName = dict[@"foodName"];
        self.ownerLocation = dict[@"ownerLocation"];
        self.note = dict[@"note"];
        
        self.fee = dict[@"fee"];
    }
    return self;
}
@end
