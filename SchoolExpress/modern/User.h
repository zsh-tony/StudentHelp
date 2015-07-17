//
//  user.h
//  weibo
//
//  Created by zsh tony on 14-8-1.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//
typedef enum {
    VerifiedTypeNone = - 1,
    VerifiedTypePersonal = 0,
} VerifiedType;
typedef enum {
    MBTypeNone = 0, // 没有
    MBTypeNormal, // 普通
    MBTypeYear // 年费
} MBType;

#import <Foundation/Foundation.h>
@class Express;
@interface User : NSObject
@property (nonatomic ,copy) NSString *userId;
@property (nonatomic ,copy) NSString *nickName;
@property (nonatomic ,copy) NSString *profileImageUrl;
@property (nonatomic, assign) BOOL verified;
@property (nonatomic,assign) VerifiedType verifiedType;
//@property (nonatomic,assign) MBType mbtype;
//@property (nonatomic,assign) int mbrank;
@property (nonatomic,strong)NSString *personalSignature;

//@property(nonatomic,strong)Express *express;//最新的一条微博
-(id)initWithDict:(NSDictionary *)dict;

@end
