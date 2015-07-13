//
//  StatusTool.m
//  weibo
//
//  Created by zsh tony on 14-8-1.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import "orderTool.h"
#import "AccountTool.h"
#import "Account.h"
#import "Order.h"
#import "MJExtension.h"
#import "HelpClass.h"
#import "NSURLRequest+Url.h"
//#import "Comment.h"
#define kOrdersPath @"GetOrders"

#define kMyOrdersPath @"GetMyOrders"//单条微博

#define kCommentsPath @"comments/show.json"

#define kRepostsPath @"orders/repost_timeline.json"

#define kAtOrderPath @"orders/mentions.json"
@implementation OrderTool
+(void)sinceId:(NSString *)sinceId eventType:(NSString *)eventType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail path:(NSString *)path
{
    sinceId = sinceId == nil?@"-1":sinceId;
    //maxId = maxId == nil?@"0":maxId;//封装的时候控制参数不穿空的方法//不能为空，要赋值为0
    
    NSURLRequest *request = [NSURLRequest requestWithPath:path                        params:@{@"sinceId": sinceId,
                @"eventType":eventType,
                 @"count":@"5"                                                                              }];
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
       // NSLog(@"dsfdsfds%@--",JSON);
        NSLog(@"%@",request.URL);
         NSArray *array = JSON[@"orders"];
    
        
//    NSError *jsonError = nil;
//    NSString *pathJSON=[[NSBundle mainBundle] pathForResource:@"test1" ofType:@"json"];
//    NSData *data=[NSData dataWithContentsOfFile:pathJSON];
//    
//    NSMutableDictionary *testJSON=[NSJSONSerialization JSONObjectWithData:data
//                                                  options:NSJSONReadingAllowFragments
//                                              error:&jsonError];
//   NSLog(@"sadasd%@",testJSON);
//   
//        NSArray *array = testJSON[@"orders"];
    
    
        //NSString *str = JSON[@"orders"];
       // NSLog(@"%u",[array isKindOfClass:[NSArray class]]);
    
        NSMutableArray *orders = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            Order *s = [[Order alloc]initWithDict:dict];


            [orders addObject:s];
        }
       
        if (success) {
            success(orders);
        }
//
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@d请求失败-%@",error,JSON);
       
        if (fail) {
            fail();
        }
        
    }];
    //[AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    [op start];
//
}
    


+(void)maxId:(NSString *)maxId eventType:(NSString *)eventType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail path:(NSString *)path
{
   // sinceId = sinceId == nil?@"0":sinceId;
    maxId = maxId == nil?@"-1":maxId;//封装的时候控制参数不穿空的方法//不能为空，要赋值为0
    
    NSURLRequest *request = [NSURLRequest requestWithPath:path                        params:@{@"maxId"  :maxId,                                          @"eventType":eventType,                                           @"count":@"5"                                                                              }];
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"JSON数据%@--",JSON);
        NSLog(@"%@",request.URL);
        NSArray *array = JSON[@"orders"];
        
        
        //    NSError *jsonError = nil;
        //    NSString *pathJSON=[[NSBundle mainBundle] pathForResource:@"test1" ofType:@"json"];
        //    NSData *data=[NSData dataWithContentsOfFile:pathJSON];
        //
        //    NSMutableDictionary *testJSON=[NSJSONSerialization JSONObjectWithData:data
        //                                                  options:NSJSONReadingAllowFragments
        //                                              error:&jsonError];
        //   NSLog(@"sadasd%@",testJSON);
        //
        //        NSArray *array = testJSON[@"orders"];
        
        
        //NSString *str = JSON[@"orders"];
        // NSLog(@"%u",[array isKindOfClass:[NSArray class]]);
        
        NSMutableArray *orders = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            Order *s = [[Order alloc]initWithDict:dict];


            
            [orders addObject:s];
        }
        
        if (success) {
            success(orders);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@请求错误-%@",error,JSON);
       
        if (fail) {
            fail();
        }
        
    }];
    //[AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    [op start];
    
}

    



+(void)sinceId:(NSString *)sinceId orderType:(NSString *)orderType orderTotalType:(NSString*)orderTotalType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail path:(NSString *)path
{
    
    sinceId = sinceId == nil?@"-1":sinceId;
    //maxId = maxId == nil?@"0":maxId;//封装的时候控制参数不穿空的方法//不能为空，要赋值为0
    
    NSURLRequest *request = [NSURLRequest requestWithPath:path                        params:@{@"sinceId": sinceId,
                 //@"maxId"  :maxId,
                 @"orderTotalType":orderTotalType,
                 @"orderType"  :orderType,
                 @"count":@"5",
                 @"userId": @"1"                                                                           }];
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@",JSON);
        NSArray *array = JSON[@"orders"];
        
        NSLog(@"%@",request.URL);
    
//    NSError *jsonError = nil;
//    NSString *pathJSON=[[NSBundle mainBundle] pathForResource:@"test1" ofType:@"json"];
//    NSData *data=[NSData dataWithContentsOfFile:pathJSON];
//    
//    NSMutableDictionary *testJSON=[NSJSONSerialization JSONObjectWithData:data
//                                                                  options:NSJSONReadingAllowFragments
//                                                                    error:&jsonError];
//    NSLog(@"sadasd%@",testJSON);
//    
//    NSArray *array = testJSON[@"orders"];
    
    
    
        NSMutableArray *orders = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            Order *s = [[Order alloc]initWithDict:dict];
            [orders addObject:s];
        }
        //回调
        if (success) {
            success(orders);
        }
//        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (fail) {
            fail();
        }
        
    }];
    [op start];

}

+(void)maxId:(NSString *)maxId orderType:(NSString *)orderType orderTotalType:(NSString*)orderTotalType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail path:(NSString *)path
{
    
    //sinceId = sinceId == nil?@"0":sinceId;
    maxId = maxId == nil?@"-1":maxId;//封装的时候控制参数不穿空的方法//不能为空，要赋值为0
    
    NSURLRequest *request = [NSURLRequest requestWithPath:path                        params:@{
                                          @"maxId"  :maxId,                               @"orderTotalType":orderTotalType,                                        @"orderType"  :orderType,                                             @"count":@"5",
        @"userId": @"1"                                                                           }];
        AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            NSLog(@"%@",JSON);
           NSArray *array = JSON[@"orders"];
    
            NSLog(@"%@",request.URL);
//        NSLog(@"%@",array[0]);
//    
//    NSError *jsonError = nil;
//    NSString *pathJSON=[[NSBundle mainBundle] pathForResource:@"test1" ofType:@"json"];
//    NSData *data=[NSData dataWithContentsOfFile:pathJSON];
//    
//    NSMutableDictionary *testJSON=[NSJSONSerialization JSONObjectWithData:data
//                                                                  options:NSJSONReadingAllowFragments
//                                                                    error:&jsonError];
//    NSLog(@"sadasd%@",testJSON);
//    
//    NSArray *array = testJSON[@"orders"];
    
    
    
    NSMutableArray *orders = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        Order *s = [[Order alloc]initWithDict:dict];
         NSLog(@"时间%@---状态%d",s.helpExpress.publishTime, s.orderStatus);
        [orders addObject:s];
    }
    //回调
    if (success) {
        success(orders);
    }
    //        
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            if (fail) {
                fail();
            }
            
        }];
        [op start];
    
}


+(void)ordersWithSinceId:(NSString *)sinceId orderType:(NSString *)orderType orderTotalType:(NSString *)orderTotalType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail
{
    [self sinceId:sinceId orderType:orderType orderTotalType:orderTotalType success:success fail:fail path:kMyOrdersPath];
}
+(void)ordersWithMaxId:(NSString *)maxId orderType:(NSString *)orderType orderTotalType:(NSString *)orderTotalType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail
{
    [self maxId:maxId orderType:orderType orderTotalType:orderTotalType success:success fail:fail path:kMyOrdersPath];
}
+(void)ordersWithSinceId:(NSString *)sinceId  eventType:(NSString *)eventType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail
{

    
    [self sinceId:sinceId eventType:eventType success:success fail:fail path:kOrdersPath];
}

+(void)ordersWithMaxId:(NSString *)maxId eventType:(NSString *)eventType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail
{
    
    
    [self  maxId:maxId eventType:eventType success:success fail:fail path:kOrdersPath];
}


+(void)orderWithId:(NSString *)idstr success:(void(^)(Order *order))success fail:(void(^)())fail
{
    
    NSURLRequest *request = [NSURLRequest requestWithPath:nil                        params:@{@"id":idstr
                  }];
//    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//      
//        
//        if (success) {
//            success([[Order alloc]initWithDict:JSON]);
//        }
//        
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        if (fail) {
//            fail();
//        }
//        
//    }];
//    [op start];
}

//+(void)commentsWithId:(NSString *)idstr sinceId:(NSString *)sinceId maxId:(NSString *)maxId success:(void (^)(NSMutableArray *, NSString *, int))success fail:(void (^)())fail
//{
//    sinceId = sinceId == nil?@"0":sinceId;
//    maxId = maxId == nil?@"0":maxId;//封装的时候控制参数不穿空的方法//不能为空，要赋值为0
//    
//    NSURLRequest *request = [NSURLRequest requestWithPath:kCommentsPath                        params:@{@"since_id": sinceId,
//                @"max_id"   :maxId,
//                @"id":idstr
//                                                                                                        }];
////    NSLog(@"%@",request);
//    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        
//        if (success) {
//            NSArray *commentsArray = JSON[@"comments"];
//            
//            NSMutableArray *comments = [NSMutableArray array];
////            NSLog(@"%@",commentsArray);
////            NSLog(@"%@",JSON);
//            for (NSDictionary *dict in commentsArray) {
//                Comment *c = [[Comment alloc]initWithDict:dict];
//                
//                [comments addObject:c];
//                
//            }
//            success(comments,[JSON[@"next_cursor"] description],[JSON[@"total_number"] intValue]);//把数字转为字符串最快的方法是description
//
//        }
////        for (NSDictionary *dict in array) {
////            Status *s = [[Status alloc]initWithDict:dict];
////            [statuses addObject:s];
////        }
////        //回调
////        if (success) {
////            success(statuses);
////        }
//        
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        if (fail) {
//            fail();
//        }
//        
//    }];
//    [op start];
//}
//
//+(void)repostsWithId:(NSString *)idstr sinceId:(NSString *)sinceId maxId:(NSString *)maxId  success:(void(^)(NSMutableArray *comments,NSString *nextCursor,int totalNum))success fail:(void(^)())fail
//{
//    sinceId = sinceId == nil?@"0":sinceId;
//    maxId = maxId == nil?@"0":maxId;//封装的时候控制参数不穿空的方法//不能为空，要赋值为0
//    
//    NSURLRequest *request = [NSURLRequest requestWithPath:kRepostsPath                       params:@{@"since_id": sinceId,
//                                                                                                        @"max_id"   :maxId,
//                                                                                                        @"id":idstr
//                                                                                                        }];
//    //    NSLog(@"%@",request);
//    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        
//        if (success) {
//            NSArray *commentsArray = JSON[@"reposts"];
//            
//            NSMutableArray *reposts = [NSMutableArray array];
//            //            NSLog(@"%@",commentsArray);
//            //            NSLog(@"%@",JSON);
//            for (NSDictionary *dict in commentsArray) {
//                Status *s = [[Status alloc]initWithDict:dict];
//                
//                [reposts addObject:s];
//                
//            }
//            success(reposts,[JSON[@"next_cursor"] description],[JSON[@"total_number"] intValue]);//把数字转为字符串最快的方法是description
//            
//        }
//        //        for (NSDictionary *dict in array) {
//        //            Status *s = [[Status alloc]initWithDict:dict];
//        //            [statuses addObject:s];
//        //        }
//        //        //回调
//        //        if (success) {
//        //            success(statuses);
//        //        }
//        
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        if (fail) {
//            fail();
//        }
//        
//    }];
//    [op start];
//
//}

//    @{@"sinceId": sinceId,                                                                   @"maxId"  :maxId,                                                                   @"eventType":eventType,
//    @"count":@"1"}
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:@"http://202.117.77.156:8080/Favours/GetOrders" parameters:    @{@"sinceId": sinceId,                                                                   @"maxId"  :maxId,                                                                   @"eventType":eventType,
//                                                                                  @"count":@"1"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@---%@", responseObject,[[NSString alloc]initWithData:(NSData*)responseObject encoding:NSUTF8StringEncoding]);
//        NSString *jsonString =  [[NSString alloc]initWithData:(NSData*)responseObject encoding:NSUTF8StringEncoding];
//        NSError* error;
//         NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary* JSON = [NSJSONSerialization
//                              JSONObjectWithData:jsonData
//                              options:kNilOptions
//                              error:&error];
//
//        NSLog(@"dsfdsrgrg%@",JSON);
//            NSArray *array = JSON[@"orders"];
//        NSString *str = JSON[@"orders"];
//        NSLog(@"%@",array);
//
//        NSMutableArray *orders = [NSMutableArray array];
//
//        for (NSDictionary *dict in array) {
//            Order *s = [[Order alloc]initWithDict:dict];
//            NSLog(@"fgtryujt%@----%@",s.helpClass.fee,str);
//            [orders addObject:s];
//        }
//
//        if (success) {
//            success(orders);
//        }
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];

+(void)atUserOrdersWithSinceId:(NSString *)sinceId maxId:(NSString *)maxId eventType:(NSString *)eventType success:(void (^)(NSMutableArray *))success fail:(void (^)())fail
{
    //[self sinceId:sinceId maxId:maxId eventType:eventType success:success fail:fail path:kAtOrderPath];
}
@end
