//
//  OuterFood.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-11.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "BaseTextModel.h"
@interface OuterFood : BaseTextModel
@property (nonatomic,strong)NSString *titleText;
@property (nonatomic,assign)NSString *fee;
@property (nonatomic,strong)NSString *foodTime;
@property (nonatomic,strong)NSString *messLocation;
@property (nonatomic,strong)NSString *foodName;
@property (nonatomic,strong)NSString *ownerLocation;
@property (nonatomic,strong)NSString *note;
@end
