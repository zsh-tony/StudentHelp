//
//  loginViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-23.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "loginViewController.h"
#import "RegisterViewController.h"
#define kaccountLimitWords 11
#define kPwdMaxWords 20
#define kPwdMinWords 6
#define kWidthMargin 30
#define kHeightMargin 15
#define kLabelWidth 40
#define kLabelHeight 30
#define kBtnHeight 40
#define kBtnWidth 80
@interface loginViewController ()
{
    UIView *navBar;
}
@end

@implementation loginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissSelf:) name:@"dismissSelf" object:nil];
    }
    return self;
}

-(void)dismissSelf:(NSNotification*)notification
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addSubViews
{

    // Do any additional setup after loading the view.
    self.title = @"登陆";
    self.view.backgroundColor = kGlobalBg;
    self.accountLabel =[[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin, kLabelWidth, kLabelHeight)];
    self.accountLabel.text = @"账户";
    self.accountLabel.font = kDetailContentFont;
    self.accountLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.accountLabel];
    
    self.passWordLabel =[[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin*3+kLabelHeight, kLabelWidth, kLabelHeight)];
    self.passWordLabel.text = @"密码";
    self.passWordLabel.font = kDetailContentFont;
    self.passWordLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.passWordLabel];
    
    self.accountText =[[UITextView alloc]initWithFrame:CGRectMake(kWidthMargin+kLabelWidth, kHeightMargin, 180, kLabelHeight)];
    self.accountText.font = kDetailContentFont;
    self.accountText.keyboardType = UIKeyboardTypeNamePhonePad;
    self.accountText.backgroundColor = [UIColor clearColor];
    self.accountText.delegate = self;
    [self.view addSubview:self.accountText];
    
    self.accountPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin+kLabelWidth+5, kHeightMargin, 180, kLabelHeight)];
    //self.accountPlaceholder.lineBreakMode = UILineBreakModeWordWrap;
    self.accountPlaceholder.numberOfLines = 0;
    self.accountPlaceholder.alpha = 0.6;
    self.accountPlaceholder.textColor = [UIColor lightGrayColor];
    self.accountPlaceholder.font = kDetailContentFont;
    self.accountPlaceholder.text = @"手机号/用户名";
    [self.view addSubview:self.accountPlaceholder];

    self.passWordText =[[UITextField alloc]initWithFrame:CGRectMake(kWidthMargin+kLabelWidth+4, kHeightMargin*3+kLabelHeight, 180, kLabelHeight)];

    self.passWordText.returnKeyType = UIReturnKeyDone;
    self.passWordText.secureTextEntry = YES;
    self.passWordText.font = kDetailContentFont;
    
    self.passWordText.backgroundColor = [UIColor clearColor];
    self.passWordText.keyboardType = UIKeyboardTypeNamePhonePad;
    NSLog(@"%u",self.passWordText.secureTextEntry);
    self.passWordText.placeholder = @"请输入密码";
    self.passWordText.delegate = self;
    [self.view addSubview:self.passWordText];
    
//    self.pwdPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin+kLabelWidth+5, kHeightMargin*3+kLabelHeight, 180, kLabelHeight)];
//    self.pwdPlaceholder.numberOfLines = 0;
//    self.pwdPlaceholder.textColor = [UIColor lightGrayColor];
//    self.pwdPlaceholder.font = kDetailContentFont;
//    self.pwdPlaceholder.text = @"请输入密码";
//    self.pwdPlaceholder.hidden=YES;
//    [self.view addSubview:self.pwdPlaceholder];

    
    UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin*2+kLabelHeight, 240, 0.5)];
    seperator.backgroundColor = [UIColor blackColor];
    seperator.alpha = 0.1;
    [self.view addSubview:seperator];
    
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin*4 +kLabelHeight*2, 260, kBtnHeight)];
    self.loginBtn.backgroundColor = [UIColor orangeColor];
    [self.loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
    self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin*5+kLabelHeight*2+kBtnHeight, kBtnWidth, 30)];
    self.registerBtn.backgroundColor = kGlobalBg;
    self.registerBtn.titleLabel.font = kDetailContentFont;
    [self.registerBtn setTitleColor:[UIColor blueColor]forState:UIControlStateNormal];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
    
    self.findPassWord = [[UIButton alloc]initWithFrame:CGRectMake(200, kHeightMargin*5+kLabelHeight*2+kBtnHeight, kBtnWidth, 30)];
    self.findPassWord.backgroundColor = [UIColor whiteColor];
    [self.findPassWord setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    self.findPassWord.titleLabel.font = kDetailContentFont;
    [self.findPassWord setTitle:@"找回密码" forState:UIControlStateNormal];
    [self.findPassWord addTarget:self action:@selector(findKey) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.findPassWord];
}
- (void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length] == 0)
    {
        [self.accountPlaceholder setHidden:NO];
    }else{
        [self.accountPlaceholder setHidden:YES];
    }
    if (textView.markedTextRange == nil && textView.text.length > kaccountLimitWords) {
        textView.text = [textView.text substringToIndex:kaccountLimitWords];
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
  
    if ( [text isEqualToString:@"\n"] ) {
        //Do whatever you want
  
        [textView resignFirstResponder];
        
        //如果不加这个，每次都会换行了
    }
    if (textView.text.length  >= kaccountLimitWords && text.length > range.length) {
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    //如果不加这个，每次都会换行了
     return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length  >= kPwdMaxWords && string.length > range.length) {
        return NO;
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSubViews];
    self.view.backgroundColor = kGlobalBg;
   // [self addNavBar];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_back.png" target:self action:@selector(Pop)];
}
-(void)Pop
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




-(void)setNavigationTheme
{
//    UINavigationBar *navBar = [UINavigationBar appearance];
//    [navBar setBackgroundImage:[UIImage imageNamed:@"orange.png"] forBarMetrics:UIBarMetricsDefault];
//    //控制器上面的导航栏会默认影响状态栏的颜色
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    //[navBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background.png"]]];
//    [navBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor],
//                                     UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero],
//                                     UITextAttributeFont:[UIFont systemFontOfSize:20]}];
//    
    
    NSString *icon = @"navigationbar_button_background.png";
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:[icon filenameAppend:@"_pushed"]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:[icon filenameAppend:@"_disable"]] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    
    NSDictionary *barItemTextAttr =@{
                                     UITextAttributeTextColor:[UIColor whiteColor],
                                     UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero],
                                     UITextAttributeFont:[UIFont systemFontOfSize:13]};
    
    [barItem setTitleTextAttributes:barItemTextAttr forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:barItemTextAttr forState:UIControlStateHighlighted];
}

-(void)login
{
    
    NSURLRequest *request = [NSURLRequest requestWithPath:kRegistUserPath params:@{@"step":@"3",@"userId":@"1",@"campus":@"1",}];
    NSLog(@"%@",[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"step",@"1",@"userId",@"4",@"campus", nil]);
    //NSURLRequest *request = [NSURLRequest requestWithPath:kRegistUserPath params:@{@"step":@"1",  @"phone":selfPhone,                                                  }];
    NSHTTPURLResponse *response = nil;
    NSError *error =nil;
    NSLog(@"%@",request);
    NSData *responeData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responesStr = [[NSString alloc]initWithData:responeData encoding:NSUTF8StringEncoding];
    
    NSLog(@"返回的是%@",responesStr);
    
    
//    [[UIApplication sharedApplication].keyWindow endEditing:YES];
//    NSURLRequest *request = [NSURLRequest requestWithPath:nil params:@{@"account":self.accountText.text,
//                 @"passWord":self.passWordText.text,                                                                                    }];
//    NSLog(@"%@--%@",self.accountText.text,self.passWordText.text);
//    [request setHTTPMethod:@"POST"];
//    
//    
//    NSHTTPURLResponse *response = nil;
//    NSError *error =nil;
//    
//    NSData *responeData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
// 
//    NSString *teststr = [[NSString alloc]initWithData:responeData encoding:NSUTF8StringEncoding];
//    NSLog(@"----%@",teststr);
    

    
}

-(void)registerAccount
{
    RegisterViewController *registerAccount = [[RegisterViewController alloc]init];
    
    
    [self.navigationController pushViewController:registerAccount animated:YES];
    //[self presentViewController:registerAccount animated:YES completion:nil];
}

-(void)findKey
{
    
    
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
