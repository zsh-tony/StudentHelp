//
//  NextRegisterViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-5-2.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextRegisterViewController : UIViewController
@property (nonatomic,copy)void (^passPhone) (NSString *phone);
@property (nonatomic,copy)void (^passCodeId) (NSString *codeId);
@end
