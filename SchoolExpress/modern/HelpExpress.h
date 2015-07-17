//
//  status.h
//  weibo
//
//  Created by zsh tony on 14-8-1.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//
/*
 created_at	string	微博创建时间
 mid	int64	微博MID
 idstr	string	字符串型的微博ID
 text	string	微博信息内容
 source	string	微博来源
 in_reply_to_status_id	string	（暂未支持）回复ID
 in_reply_to_user_id	string	（暂未支持）回复人UID
 in_reply_to_screen_name	string	（暂未支持）回复人昵称
 thumbnail_pic	string	缩略图片地址，没有时不返回此字段
 bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
 original_pic	string	原始图片地址，没有时不返回此字段
 user	object	微博作者的用户信息字段 详细
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count	int	转发数
 comments_count	int	评论数
 attitudes_count	int	表态数
 pic_urls	object	微博配图地址。多图时返回多图链接。无配图返回“[]”//包含前面的图片，这里只用这个就可以了
 */
#import <Foundation/Foundation.h>
#import "User.h"
#import "BaseTextModel.h"
@interface HelpExpress :BaseTextModel
////@property (nonatomic ,copy) NSString *idStr;
////@property (nonatomic, copy)NSString *text;
//@property (nonatomic , copy) NSString *source;
//@property (nonatomic, assign) int repostsCount;
//@property (nonatomic, assign) int commentsCount;
//@property (nonatomic, assign) int atttiudesCount;
//@property (nonatomic,strong) NSArray *picUrls;
////@property (nonatomic,copy) NSString *createdAt;
//@property (nonatomic ,strong)Express *retweetedStatus;
////@property (nonatomic,strong)User *user;
////-(id)initWithDict:(NSDictionary *)dict;


@property (nonatomic,strong)NSString *titleText;
@property (nonatomic,strong)NSString *fee;
@property (nonatomic,strong)NSString *expressTime;
@property (nonatomic,strong)NSString *expressLocation;
@property (nonatomic,strong)NSString *companyName;
@property (nonatomic,strong)NSString *ownerLocation;
@property (nonatomic,strong)NSString *note;



-(void)update:(Express *)other;
@end
