//
//  HelpClass.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-11.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "BaseTextModel.h"
@interface HelpClass : BaseTextModel
@property (nonatomic,strong)NSString *titleText;
@property (nonatomic,strong)NSString *fee;
@property (nonatomic,strong)NSString *classTime;
@property (nonatomic,strong)NSString *roomLocation;
@property (nonatomic,strong)NSString *className;
//@property (nonatomic,strong)NSString *ownerLocation;
@property (nonatomic,strong)NSString *note;
@end
