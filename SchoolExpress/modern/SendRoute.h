//
//  sendRoute.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-20.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendRoute : NSObject
@property (nonatomic,strong) NSString *fromLocation;
@property (nonatomic,strong) NSString *toLocation;
@property (nonatomic,strong) NSString *fromTime;
@property (nonatomic,strong) NSString *toTime;
@property (nonatomic,strong) NSString *cost;
@property (nonatomic,strong) NSString *explain;

@end
