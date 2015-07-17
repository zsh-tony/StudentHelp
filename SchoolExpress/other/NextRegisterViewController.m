//
//  NextRegisterViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-5-2.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "NextRegisterViewController.h"
#import "MZTimerLabel.h"
#import "RegisterSchViewController.h"
#define kHeightMargin 10
#define kWidthMargin 35
#define kLabelHeight 30
#define kItemWidth 250
#define kTextWidth 150
#define kTimerWidth 80
#define kBtnHeight 40
#define kPwdMaxWords 16
#define kCodeMaxWords 6
@interface NextRegisterViewController ()<MZTimerLabelDelegate,UITextFieldDelegate>
{
    MZTimerLabel *timer;
    UILabel *alterLabel;
    UITextField *codeText;
    UITextField *keywordText;
    UITextField *ensureKeyword;
    UIButton *registerBtn;
    UIView *seperator3;
    UIButton *rePassCodeBtn;
    UILabel *alterCode;
    
    NSString *selfCodeId;
    NSString *selfPhone;
}
@end

@implementation NextRegisterViewController


//(self.view.bounds.size.width - 2*kWidthMargin)
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        alterLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin, kItemWidth, kLabelHeight)];
        alterLabel.font = [UIFont systemFontOfSize:13];
        alterLabel.backgroundColor = [UIColor clearColor];
        __block UILabel *blockLabel = alterLabel;
        __weak NextRegisterViewController *weakSelf = self;
        _passPhone = ^(NSString *phone){
            blockLabel.text = [NSString stringWithFormat:@"验证码短信已经发送到+86-%@",[weakSelf protectedPhone:phone]] ;
            selfPhone = phone;
        };
        NextRegisterViewController *strongSelf = weakSelf;
        alterLabel.textAlignment = NSTextAlignmentLeft;
        alterLabel.textColor = [UIColor lightGrayColor];
        [strongSelf.view addSubview:alterLabel];
        
        _passCodeId = ^(NSString *codeId){
            selfCodeId = [NSString stringWithFormat:@"%@",codeId];
           
        };
      
    }
    return self;
}
-(NSString*)protectedPhone:(NSString *)phoneNumber
{
    NSRange range1 = NSMakeRange(0, 3);
    NSRange range2 = NSMakeRange(7, 4);
    NSString *str = [NSString stringWithFormat:@"%@****%@",[phoneNumber substringWithRange:range1],[phoneNumber substringWithRange:range2]];
    return str;
    
}
- (void)initTimer
{
    timer = [[MZTimerLabel alloc] init];
    timer.timerType = MZTimerLabelTypeTimer;
    timer.frame =CGRectMake(kWidthMargin+kItemWidth-kTimerWidth,codeText.frame.origin.y , kTimerWidth, kLabelHeight);
    timer.layer.borderWidth = 0.5;
    timer.layer.cornerRadius = 5;
    timer.layer.borderColor = [[UIColor grayColor] CGColor];
    timer.timeLabel.textAlignment = NSTextAlignmentCenter;
    timer.timeLabel.font = [UIFont systemFontOfSize:13.0f];
    timer.timeLabel.textColor = [UIColor lightGrayColor];
    [timer setCountDownTime:60];
    [self.view addSubview:timer];
    [timer start];
    timer.timeFormat = @"ss";
    timer.delegate = self;
}

- (void)initRePassCodeBtn
{
    rePassCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidthMargin+kItemWidth-kTimerWidth,codeText.frame.origin.y , kTimerWidth, kLabelHeight)];
    rePassCodeBtn.backgroundColor = [UIColor orangeColor];
    rePassCodeBtn.layer.borderWidth = 0.5;
    rePassCodeBtn.layer.cornerRadius = 5;
    rePassCodeBtn.layer.borderColor = [[UIColor orangeColor] CGColor];
    rePassCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    rePassCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    rePassCodeBtn.titleLabel.textColor = [UIColor lightGrayColor];
    [rePassCodeBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
    [rePassCodeBtn addTarget:self action:@selector(rePassCode) forControlEvents:UIControlEventTouchUpInside];
}
-(void)rePassCode
{
    [rePassCodeBtn removeFromSuperview];
    [self.view addSubview:timer];
    [timer reset];
    [timer start];
    
    NSURLRequest *request = [NSURLRequest requestWithPath:kRegistUserPath params:@{@"step":@"1",  @"phone":selfPhone,                                                  }];
    //
    NSHTTPURLResponse *response = nil;
    NSError *error =nil;
    NSLog(@"%@",request);
    NSData *responeData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responesStr = [[NSString alloc]initWithData:responeData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@----%@",teststr1,teststr);
    NSLog(@"responeStr%@",responesStr);
    
    int code =   [responesStr intValue];
    
    if (code >0) {
        selfCodeId = [NSString stringWithFormat:@"%d",code];
        alterLabel.hidden = NO;
    }else{
        alterLabel.text = @"发送失败";
        alterLabel.hidden = NO;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kGlobalBg;
    self.title = @"注册";
    [self addSubviews];
    [self initTimer];
    
    [self initRePassCodeBtn];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_back.png" target:self action:@selector(popVC)];
}
-(void)popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addSubviews
{
    seperator3 = [[UIView alloc]initWithFrame:CGRectMake(kWidthMargin, alterLabel.frame.origin.y+alterLabel.frame.size.height+0.5, kItemWidth, 0.5)];
    seperator3.alpha = 0.6;
    seperator3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:seperator3];
    codeText = [[UITextField alloc]initWithFrame:CGRectMake(kWidthMargin, alterLabel.frame.origin.y +alterLabel.frame.size.height+kHeightMargin, kTextWidth, kLabelHeight)];
    codeText.keyboardType = UIKeyboardTypeNumberPad;
    codeText.placeholder = @"请输入短信验证码";
    codeText.delegate = self;
    codeText.font = kDetailContentFont;
    [self.view addSubview:codeText];
    
    UIView *seperator1 = [[UIView alloc]initWithFrame:CGRectMake(kWidthMargin, codeText.frame.origin.y+codeText.frame.size.height+0.5+kHeightMargin, kItemWidth, 0.5)];
    seperator1.alpha = 0.6;
    seperator1.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:seperator1];
    
    keywordText = [[UITextField alloc]initWithFrame:CGRectMake(kWidthMargin, codeText.frame.origin.y +codeText.frame.size.height+2*kHeightMargin, kTextWidth, kLabelHeight)];
    keywordText.placeholder = @"设置登录密码";
    keywordText.font = kDetailContentFont;
    keywordText.delegate = self;
    keywordText.keyboardType = UIKeyboardTypeNamePhonePad;
    keywordText.secureTextEntry = YES;
    [self.view addSubview:keywordText];
    
    UIView *seperator2 = [[UIView alloc]initWithFrame:CGRectMake(kWidthMargin, keywordText.frame.origin.y+keywordText.frame.size.height+0.5+kHeightMargin, kItemWidth, 0.5)];
    seperator2.alpha = 0.6;
    seperator2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:seperator2];
    
    ensureKeyword = [[UITextField alloc]initWithFrame:CGRectMake(kWidthMargin, keywordText.frame.origin.y +keywordText.frame.size.height+2*kHeightMargin, kTextWidth, kLabelHeight)];
    ensureKeyword.placeholder = @"确认登陆密码";
    ensureKeyword.font = kDetailContentFont;
    ensureKeyword.secureTextEntry = YES;
    ensureKeyword.keyboardType = UIKeyboardTypeNamePhonePad;
    ensureKeyword.delegate = self;
    [self.view addSubview:ensureKeyword];
    
    UIView *seperator4 = [[UIView alloc]initWithFrame:CGRectMake(kWidthMargin, ensureKeyword.frame.origin.y+ensureKeyword.frame.size.height+0.5+kHeightMargin, kItemWidth, 0.5)];
    seperator4.alpha = 0.6;
    seperator4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:seperator4];
    
    registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidthMargin, ensureKeyword.frame.origin.y +ensureKeyword.frame.size.height+2*kHeightMargin, kItemWidth, kBtnHeight)];
    registerBtn.backgroundColor = [UIColor orangeColor];
    [registerBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(finalRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    alterCode = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin+kItemWidth-kTimerWidth,ensureKeyword.frame.origin.y , kTimerWidth, kLabelHeight)];
    alterCode.text = @"密码不一致";
    alterCode.font = [UIFont systemFontOfSize:13];
    alterCode.hidden = YES;
    alterCode.backgroundColor = [UIColor clearColor];
    alterCode.textAlignment = NSTextAlignmentLeft;
    alterCode.textColor = [UIColor redColor];
    [self.view addSubview:alterCode];
}


-(void)finalRegister
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (![keywordText.text isEqualToString:ensureKeyword.text]) {
        NSLog(@"dsdsad");
        alterCode.hidden = NO;

    }else{
        NSLog(@"selfCodeid=%@",selfCodeId);
        NSURLRequest *request = [NSURLRequest requestWithPath:kRegistUserPath params:@{@"step" : @"2",@"codeId":selfCodeId,@"code":codeText.text,
                     @"keyWord":keywordText.text}];
      
        
        //
        NSHTTPURLResponse *response = nil;
        NSError *error =nil;
        
        NSData *responeData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *responesStr = [[NSString alloc]initWithData:responeData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responesStr);
        int code = [responesStr intValue];
        if (code >0) {
            
            [AccountTool sharedAccountTool].currentAccount.userId = [NSString stringWithFormat:@"%d",code];
            RegisterSchViewController *registerSch = [[RegisterSchViewController alloc]init];
            if (registerSch.passUserId) {
                registerSch.passUserId([NSString stringWithFormat:@"%d",code]);
            }
            [self.navigationController pushViewController:registerSch animated:YES];
        }

    }
}

-(NSString*)timerLabel:(MZTimerLabel*)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time
{
    
    return [NSString stringWithFormat:@"%d秒后重发",(int)time];
}
-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    //time is up, what should I do master?
    [timer removeFromSuperview];
    [self.view addSubview:rePassCodeBtn];
    [alterLabel setHidden:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    //如果不加这个，每次都会换行了
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField isEqual:codeText]) {
        if (textField.text.length  >= kCodeMaxWords && string.length > range.length) {
            return NO;
        }

    }else{
    if (textField.text.length  >= kPwdMaxWords && string.length > range.length) {
        return NO;
    }
    }
    alterCode.hidden = YES;
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
