//
//  registerViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-23.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "RegisterViewController.h"
#import "NextRegisterViewController.h"
#import "LPPopup.h"
#define kphoneLimitWords 11
#define kPwdMaxWords 20
#define kPwdMinWords 6
#define kWidthMargin 20
#define kHeightMargin 15
#define kLabelWidth 40
#define kLabelHeight 30
#define kBtnHeight 40
#define kBtnWidth 80
@interface RegisterViewController ()
{
    LPPopup *popup;
}
@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kGlobalBg;
    [self addSubViews];
    self.title = @"注册";
//       self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithBg:@"navigationbar_back.png" title:@"取消" size:CGSizeMake(80, 30) target:self action:@selector(popVC)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_back.png" target:self action:@selector(popVC)];
}
-(void)popVC
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addSubViews
{
    
    // Do any additional setup after loading the view.
    self.phoneLabel =[[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin, kLabelWidth, kLabelHeight)];
    self.phoneLabel.text = @"+86";
    self.phoneLabel.layer.borderWidth = 0.5;
    self.phoneLabel.layer.cornerRadius = 5;
    self.phoneLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.phoneLabel.font = kDetailContentFont;
    self.phoneLabel.backgroundColor = [UIColor clearColor];
    self.phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.phoneLabel];
    
    self.note =[[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin+kLabelHeight, 260, kLabelHeight)];
    self.note.text = @"点击“下一步”表示您已阅读并遵守“免责声明”";
    self.note.font = [UIFont systemFontOfSize:13];
    //[self.note sizeToFit];
    self.note.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.note];
    
    self.phoneText =[[UITextView alloc]initWithFrame:CGRectMake(kWidthMargin+kLabelWidth+2, kHeightMargin, 210, kLabelHeight)];
    self.phoneText.font = kDetailContentFont;
    self.phoneText.layer.borderWidth = 0.5;
    self.phoneText.layer.cornerRadius = 5;
    self.phoneText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.phoneText.keyboardType = UIKeyboardTypePhonePad;
    self.phoneText.backgroundColor = [UIColor clearColor];
    self.phoneText.delegate = self;
    [self.view addSubview:self.phoneText];
    
    self.phonePlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin+kLabelWidth+15, kHeightMargin, 210, kLabelHeight)];
    //self.phonePlaceholder.lineBreakMode = UILineBreakModeWordWrap;
    self.phonePlaceholder.numberOfLines = 0;
    self.phonePlaceholder.alpha = 0.6;
    self.phonePlaceholder.textColor = [UIColor lightGrayColor];
    self.phonePlaceholder.font = kDetailContentFont;
    self.phonePlaceholder.text = @"请输入手机号";
    [self.view addSubview:self.phonePlaceholder];

    
    //    self.pwdPlaceholder = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin+kLabelWidth+5, kHeightMargin*3+kLabelHeight, 180, kLabelHeight)];
    //    self.pwdPlaceholder.numberOfLines = 0;
    //    self.pwdPlaceholder.textColor = [UIColor lightGrayColor];
    //    self.pwdPlaceholder.font = kDetailContentFont;
    //    self.pwdPlaceholder.text = @"请输入密码";
    //    self.pwdPlaceholder.hidden=YES;
    //    [self.view addSubview:self.pwdPlaceholder];
    
    
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin*2 +kLabelHeight*2, 260, kBtnHeight)];
    self.loginBtn.backgroundColor = [UIColor orangeColor];
    [self.loginBtn setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    
}
-(void)next
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (![self checkTel:self.phoneText.text]) {
        NSLog(@"sijdfosjid");
   
        
    }else{
     
        NSURLRequest *request = [NSURLRequest requestWithPath:kRegistUserPath params:@{@"step":@"1",  @"phone":self.phoneText.text,                                                  }];
                //
        NSHTTPURLResponse *response = nil;
        NSError *error =nil;
        NSLog(@"%@",request);
        NSData *responeData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *responesStr = [[NSString alloc]initWithData:responeData encoding:NSUTF8StringEncoding];
        //NSLog(@"%@----%@",teststr1,teststr);
        NSLog(@"responeStr%@",responesStr);
        
         int code =   [responesStr intValue];
        NSLog(@"code=%d",code);
        
        if (code > 0) {
            NextRegisterViewController *next = [[NextRegisterViewController alloc]init];
            if (next.passCodeId) {
                next.passCodeId([NSString stringWithFormat:@"%d",code]);
            }
            if (next.passPhone) {
                next.passPhone(self.phoneText.text);
            }
            [self.navigationController pushViewController:next animated:YES];
        }else{
            popup = [LPPopup popupWithText:@"用户已存在!"];
            popup.popupColor = [UIColor blackColor];
            popup.alpha = 0.8;
            popup.textColor = [UIColor whiteColor];
            popup.font = kDetailContentFont;
            //popup.textInsets = UIEdgeInsetsMake(10, 0, 0, 0);
            [popup showInView:self.view
                centerAtPoint:self.view.center
                     duration:3
                   completion:nil];
        }
        
        
    
        
    }
    
    
   

}

- (void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length] == 0)
    {
        [self.phonePlaceholder setHidden:NO];
    }else{
        [self.phonePlaceholder setHidden:YES];
    }
    if (textView.markedTextRange == nil && textView.text.length > kphoneLimitWords) {
        textView.text = [textView.text substringToIndex:kphoneLimitWords];
    }
    
}
- (BOOL)checkTel:(NSString *)str

{
    
    if ([str length] == 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"手机号为空", nil) message:NSLocalizedString(@"请输入手机号码", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        
        return NO;
        
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        
        
        return NO;
        
    }
    
    
    
    return YES;
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    if ( [text isEqualToString:@"\n"] ) {
        //Do whatever you want
        
        [textView resignFirstResponder];
        
        //如果不加这个，每次都会换行了
    }
    if (textView.text.length  >= kphoneLimitWords && text.length > range.length) {
        return NO;
    }
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
