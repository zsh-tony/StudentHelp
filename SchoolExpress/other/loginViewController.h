//
//  loginViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-23.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UILabel *accountLabel;
@property (nonatomic,strong)UITextView *accountText;
@property (nonatomic,strong)UILabel *accountPlaceholder;
@property (nonatomic,strong)UILabel *passWordLabel;
@property (nonatomic,strong)UITextField *passWordText;
@property (nonatomic,strong)UILabel *pwdPlaceholder;
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)UIButton *registerBtn;
@property (nonatomic,strong)UIButton *findPassWord;
@end
