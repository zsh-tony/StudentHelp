//
//  BaseTextModel.h
//  weibo
//
//  Created by zsh tony on 14-8-19.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>

//created_at	string	评论创建时间

//text	string	评论的内容

//user	object	评论作者的用户信息字段 详细
//idstr	string	字符串型的评论ID
//status	object	评论的微博信息字段 详细
@class User;
@interface BaseTextModel : NSObject
@property (nonatomic ,copy) NSString *userId;
@property (nonatomic, copy)NSString *text;
@property (nonatomic,copy) NSString *publishTime;
@property (nonatomic,strong)User *user;
-(id)initWithDict:(NSDictionary *)dict;
@end
