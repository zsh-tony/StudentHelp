//
//  status.m
//  weibo
//
//  Created by zsh tony on 14-8-1.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import "HelpExpress.h"
#import "User.h"
@implementation HelpExpress

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {

        
        
        self.titleText = dict[@"titleText"];
        self.expressLocation = dict[@"expressLocation"];
        self.expressTime = dict[@"expressTime"];
        self.companyName = dict[@"companyName"];
        self.ownerLocation = dict[@"ownerLocation"];
        self.note = dict[@"note"];
        
        self.fee = dict[@"fee"];
//        if (retweetedDict) {
//            self.retweetedStatus = [[Express alloc]initWithDict:dict[@"retweeted_status"]];
//        }
//        NSDictionary *user = dict[@"user"];
//        if (user) {
//            self.user = [[User alloc]initWithDict:dict[@"user"]];
//        }
//      
    }
    return self;
}
//-(void)setCreatedAt:(NSString *)createdAt//这里用的是setter方法，是因为，用这个方法更彻底，只调用一次就可以了，getter方法的话，每次都要调用
//{
//    //1分钟：刚刚  1分钟-60分钟以内：xx分钟前  1小时-24小时内：xx小时前 24小时：
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init ];
//    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
//    formatter.locale = [[NSLocale alloc ]initWithLocaleIdentifier:@"en_US"];//zh_CN
//    NSDate *date = [formatter dateFromString:createdAt];
//    NSDate *now = [NSDate date];
//    NSTimeInterval delta = [now timeIntervalSinceDate:date];//当前时间比右边的时间多了多少秒
//    if (delta < 60) {
//        createdAt = @"刚刚";
//    }else if (delta <60 *60){
//        createdAt = [NSString stringWithFormat:@"%.f分钟前",delta/60];
//    }else if (delta < 60*60*60){
//        createdAt = [NSString stringWithFormat:@"%f.小时前",delta/(60*60)];
//    }else{
//        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
//        createdAt = [formatter stringFromDate:date];
//    }
//    
//    //    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
//    //    return [formatter stringFromDate:date];
//    //时间显示策略
//
//}
//-(void)setSource:(NSString *)source
//{
//
//    int startIndex = [source rangeOfString:@">"].location + 1;
//    int endIndex = [source rangeOfString:@"</a>"].location;
//    int len = endIndex - startIndex;
//    _source = [source substringWithRange:NSMakeRange(startIndex, len)];
//    _source =[NSString stringWithFormat:@"来自%@",_source ];
//}
//-(NSString *)createdAt//这里又用了getter方法，是因为这里的时间要不断通过cell去调用新的值，这里要更新新的值而不是不变的，所以要用getter
//{
//        //1分钟：刚刚  1分钟-60分钟以内：xx分钟前  1小时-24小时内：xx小时前 24小时：
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init ];
//    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
//    formatter.locale = [[NSLocale alloc ]initWithLocaleIdentifier:@"en_US"];//zh_CN
//    NSDate *date = [formatter dateFromString:_createdAt];
//    NSDate *now = [NSDate date];
//    NSTimeInterval delta = [now timeIntervalSinceDate:date];//当前时间比右边的时间多了多少秒
//    if (delta < 60) {
//        return @"刚刚";
//    }else if (delta <60 *60){
//        return [NSString stringWithFormat:@"%.f分钟前",delta/60];
//    }else if (delta < 60*60*60){
//        return [NSString stringWithFormat:@"%.f小时前",delta/(60*60)];
//    }else{
//        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
//        return [formatter stringFromDate:date];
//    }
//    
//    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
//    return [formatter stringFromDate:date];
//    //时间显示策略
//
//}
-(void)update:(HelpExpress *)other
{
//    self.repostsCount = other.repostsCount;
//   self.commentsCount = other.commentsCount;
//    self.atttiudesCount = other.atttiudesCount;
//    
//    self.retweetedStatus.repostsCount = other.retweetedStatus.repostsCount;
//    self.retweetedStatus.commentsCount = other.retweetedStatus.commentsCount;
//    self.retweetedStatus.atttiudesCount = other.retweetedStatus.atttiudesCount;
}

@end
