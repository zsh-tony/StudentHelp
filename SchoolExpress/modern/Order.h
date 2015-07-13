//
//  BaseOrder.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-13.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "HelpExpress.h"
#import "CampusFood.h"
#import "OuterFood.h"
#import "HelpClass.h"

typedef enum {
    ReleasedStatus = 0,
    AppliedStatus = 1,
    ConfirmedStatus = 2,
    CompletedStatus = 3,
}OrderStatus;


typedef enum {
    OrderReleaseType = 0,
    OrderAcceptType = 1,
} OrderTotalType;

typedef enum {
    UnderwayOrder = 0,
    CompletedOrder = 1,
    FailOrder = 2,
} OrderType;

typedef enum {
    AllType = 0,
    HelpClassType = 1,
    CampusFoodType = 2,
    HelpExpressType = 3,
    OuterFoodType = 4,
} EventType;
@interface Order : NSObject
@property (nonatomic,strong)NSMutableArray *acceptUser;
@property (nonatomic,strong)NSString *orderId;
@property (nonatomic,strong)NSString *sortId;
//@property (nonatomic,strong)NSString *publishTime;

//@property (nonatomic,assign)NSString *free;
@property (nonatomic,strong)NSMutableDictionary *eventDict;
@property (nonatomic,strong)HelpExpress *helpExpress;
@property (nonatomic,strong)CampusFood *campusFood;
@property (nonatomic,strong)OuterFood *outerFood;
@property (nonatomic,strong)HelpClass *helpClass;
@property (nonatomic,assign)OrderStatus orderStatus;
@property (nonatomic,assign)OrderType  orderType;
@property (nonatomic,assign)EventType  eventType;
@property (nonatomic,assign)OrderTotalType orderTotalType;
-(id)initWithDict:(NSDictionary *)dict;
@end
