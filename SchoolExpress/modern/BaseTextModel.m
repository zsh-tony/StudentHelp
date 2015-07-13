//
//  BaseTextModel.m
//  weibo
//
//  Created by zsh tony on 14-8-19.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import "BaseTextModel.h"
#import "User.h"
@implementation BaseTextModel
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.userId = dict[@"userId"];
        self.text = dict[@"text"];
        self.publishTime = dict[@"publishTime"];
        NSDictionary *user = dict[@"user"];
        if (user) {
            self.user = [[User alloc]initWithDict:dict[@"user"]];
        }
        
    }
    return self;
}

-(NSString *)publishTime//这里又用了getter方法，是因为这里的时间要不断通过cell去调用新的值，这里要更新新的值而不是不变的，所以要用getter
{
    
    //1分钟：刚刚  1分钟-60分钟以内：xx分钟前  1小时-24小时内：xx小时前 24小时：
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init ];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.locale = [[NSLocale alloc ]initWithLocaleIdentifier:@"zh_CN"];//zh_CN
    NSDate *date = [formatter dateFromString:_publishTime];
    NSDate *now = [NSDate date];
    NSTimeInterval delta = [now timeIntervalSinceDate:date];//当前时间比右边的时间多了多少秒
   if (delta < 60*60*24){
        formatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"今天%@",[formatter stringFromDate:date]];
    }else if(delta < 60*60*24*2){
        
        formatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"昨天%@",[formatter stringFromDate:date]];
        
    }else if(delta < 60*60*24*3){
        
        return @"前天";
        
    }else{
        formatter.dateFormat = @"MM-dd HH:mm";
        
        return [NSString stringWithFormat:@"%.f天前",delta/(60*60*24)];
    }
    
//    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
//    return [formatter stringFromDate:date];
    //时间显示策略
    
}

@end
