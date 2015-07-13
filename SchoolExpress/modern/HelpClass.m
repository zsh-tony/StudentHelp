
//
//  HelpClass.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-11.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "HelpClass.h"

@implementation HelpClass
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        
        self.titleText = dict[@"titleText"];
        self.roomLocation = dict[@"roomLocation"];
        self.classTime = dict[@"classTime"];
        self.className = dict[@"className"];
//        self.ownerLocation = dict[@"ownerLocation"];
        self.note = dict[@"note"];
        
        self.fee = dict[@"fee"];
    }
    return self;
}
@end
