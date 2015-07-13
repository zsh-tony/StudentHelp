//
//  BaseOrder.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-13.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "Order.h"

@implementation Order
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.orderId = dict[@"orderId"];
        self.sortId = dict[@"sortId"];
        self.eventType = [dict[@"eventType"] intValue];
        //self.free = dict[@"free"];
        //self.eventDict =[NSMutableDictionary dictionaryWithObjectsAndKeys:self.helpExpress,@"helpExpress",self.campusFood,@"campusFood",self.outerFood,@"outerFood",self.helpClass,@"helpClass",nil];
        NSDictionary *expressdict = dict[@"HelpExpress"];
        NSDictionary *campusFooddict = dict[@"CampusFood"];
        NSDictionary *outerFooddict = dict[@"OuterFood"];
        NSDictionary *helpClassdict = dict[@"HelpClass"];
        NSMutableArray *userArray = dict[@"acceptUser"];
        NSMutableArray *newUser = [NSMutableArray array];
        self.acceptUser = [NSMutableArray array];
        if (userArray != nil) {
            
            for ( NSDictionary *dict in userArray) {
                User *user = [[User alloc]initWithDict:dict];
                [newUser addObject:user];
            }
            self.acceptUser = newUser;
        }
       // NSLog(@"%@",self.acceptUser);
       //NSDictionary *user = dict[@"user"];
        self.orderStatus = [dict[@"orderStatus"] intValue];
        NSLog(@"sortID%@---状态%d",self.sortId, self.orderStatus);
        
        self.orderType = [dict[@"orderType"] intValue];
        self.orderTotalType = [dict[@"orderTotalType"] intValue];
 
        if (expressdict!= nil) {
            self.helpExpress = [[HelpExpress alloc]initWithDict:expressdict];
        }
        if (campusFooddict!= nil) {
            self.campusFood = [[CampusFood alloc]initWithDict:campusFooddict];
        }
        if (outerFooddict!= nil) {
            self.outerFood = [[OuterFood alloc]initWithDict:outerFooddict];
        }
        if (helpClassdict!= nil) {
            self.helpClass = [[HelpClass alloc]initWithDict:helpClassdict];
        }
//        if (user!= nil) {
//            self.helpExpress = [[HelpExpress alloc]initWithDict:expressdict];
//        }
        
        
    }
    return self;
    
}
@end
