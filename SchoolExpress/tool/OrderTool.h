//
//  OrderTool.h
//  weibo
//
//  Created by zsh tony on 14-8-1.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Order;
@interface OrderTool : NSObject
//类方法的知名缺点：不能返回成员变量

+(void)ordersWithSinceId:(NSString *)sinceId eventType:(NSString *)eventType success:(void(^)(NSMutableArray *orders))success fail:(void(^)())fail;//想要返回微博数据，但是这个请求是异步请求，发送完了后可能还在发送请求，只能用block
+(void)ordersWithMaxId:(NSString *)maxId eventType:(NSString *)eventType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail;
+(void)maxId:(NSString *)maxId eventType:(NSString *)eventType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail path:(NSString *)path;
+(void)sinceId:(NSString *)sinceId eventType:(NSString *)eventType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail path:(NSString *)path;


+(void)ordersWithSinceId:(NSString *)sinceId orderType:(NSString *)orderType orderTotalType:(NSString *)orderTotalType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail;
+(void)ordersWithMaxId:(NSString *)maxId orderType:(NSString *)orderType orderTotalType:(NSString *)orderTotalType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail;

+(void)sinceId:(NSString *)sinceId orderType:(NSString *)orderType orderTotalType:(NSString*)orderTotalType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail path:(NSString *)path;
+(void)maxId:(NSString *)maxId orderType:(NSString *)orderType orderTotalType:(NSString*)orderTotalType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail path:(NSString *)path;


//+(void)commentsWithId:(NSString *)idstr sinceId:(NSString *)sinceId maxId:(NSString *)maxId  success:(void(^)(NSMutableArray *comments,NSString *nextCursor,int totalNum))success fail:(void(^)())fail;

//+(void)repostsWithId:(NSString *)idstr sinceId:(NSString *)sinceId maxId:(NSString *)maxId  success:(void(^)(NSMutableArray *comments,NSString *nextCursor,int totalNum))success fail:(void(^)())fail;
+(void)atUserOrdersWithSinceId:(NSString *)sinceId maxId:(NSString *)maxId eventType:(NSString *)eventType success:(void(^)(NSMutableArray *orders))success fail:(void(^)())fail;
+(void)orderWithId:(NSString *)idstr success:(void(^)(Order *order))success fail:(void(^)())fail;
@end
