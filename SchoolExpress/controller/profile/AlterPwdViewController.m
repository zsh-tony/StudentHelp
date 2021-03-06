
//
//  AlterPwdViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-5-8.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "AlterPwdViewController.h"
#import "LPPopup.h"
#define kHeightMargin 10
#define kWidthMargin 35
#define kLabelHeight 30
#define kItemWidth 250
#define kTextWidth 150
#define kTimerWidth 80
#define kBtnHeight 40
#define kPwdMaxWords 16
#define kCodeMaxWords 4
@interface AlterPwdViewController ()<UITextFieldDelegate>
{
    UITableViewCell *orginPwdCell;
    UITableViewCell *newPwdCell;
    UITableViewCell *ensurePwdCell;
    UITextField *newPhoneField;
    UITextField *newPwdField;
    UITextField *againPwdField;
    LPPopup *popup;
}
@end

@implementation AlterPwdViewController

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
    [self initTableView];
    self.title = @"修改登陆密码";
}
- (void)initTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight =0;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.backgroundColor = kGlobalBg;
    UIView *footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, 0, 300, 70);
    UIButton *alter = [UIButton buttonWithType:UIButtonTypeCustom];
    [alter setAllStateBg:@"common_button_big_red.png"];
    [alter setTitle:@"更改" forState:UIControlStateNormal];
    alter.frame = CGRectMake(10, 10, 300, 44);//footview会自动延伸,处理方法，在底层加了个纯洁的uiview
    [alter addTarget:self action:@selector(alter) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:alter];
    self.tableView.tableFooterView = footer;
    
    [self.view addSubview:self.tableView];
}
-(void)alter
{
    if (![newPwdField.text isEqualToString:againPwdField.text]) {
        popup = [LPPopup popupWithText:@"两次密码输入不一致!"];
        popup.popupColor = [UIColor blackColor];
        popup.alpha = 0.8;
        popup.textColor = [UIColor whiteColor];
        popup.font = kDetailContentFont;
        [popup showInView:self.view
            centerAtPoint:self.view.center
                 duration:3.0f
               completion:nil];
    }
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    //    if (![keywordText.text isEqualToString:ensureKeyword.text]) {
    //        NSLog(@"dsdsad");
    //        alterCode.hidden = NO;
    //
    //    }else{
//    NSURLRequest *request = [NSURLRequest requestWithPath:nil params:@{@"phoneNumber":codeText.text,
//                                                                       @"keyWord":keywordText.text,
//                                                                       @"ensureKeyWord":ensureKeyword.text,}];
    //    NSLog(@"%@",self.phoneText.text);
    //    //[request setHTTPMethod:@"POST"];
    //
    //
    //    NSHTTPURLResponse *response = nil;
    //    NSError *error =nil;
    //    //NSError *jsonParseError = nil;
    //
    //    NSData *responeData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //    // NSDictionary *testdict= [NSJSONSerialization JSONObjectWithData:responeData options:0 error:&jsonParseError];
    //    // NSString *teststr1 = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString *teststr = [[NSString alloc]initWithData:responeData encoding:NSUTF8StringEncoding];
    //    NSLog(@"----%@",teststr);
    
    
    //}
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *CellIdentifier1 = @"orginPwdCell";
        orginPwdCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (orginPwdCell == nil) {
            orginPwdCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
        }
        orginPwdCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        newPhoneField = [[UITextField alloc]initWithFrame:CGRectMake(kWidthMargin, k10HeightMargin, kItemWidth, orginPwdCell.frame.size.height - 20)];
        [orginPwdCell.contentView addSubview:newPhoneField];
        newPhoneField.placeholder = @"请输入原密码";
        newPhoneField.secureTextEntry = YES;
        newPhoneField.delegate = self;
        newPhoneField.font = k13Font;
        return orginPwdCell;
    }else if(indexPath.row == 1){
        static NSString *CellIdentifier2 = @"newPwdCell";
        newPwdCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (newPwdCell == nil) {
            newPwdCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier2] ;
        }
        newPwdCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        newPwdField = [[UITextField alloc]initWithFrame:CGRectMake(kWidthMargin, k10HeightMargin, kItemWidth, orginPwdCell.frame.size.height - 20)];
        
        //newPhoneField.keyboardType = UIKeyboardTypeNamePhonePad;
        newPwdField.font = k13Font;
        newPwdField.delegate = self;
        newPwdField.secureTextEntry = YES;
        [newPwdCell.contentView addSubview:newPwdField];
        newPwdField.placeholder = @"请输入新密码";
        
        return newPwdCell;
    }else{
        static NSString *CellIdentifier3 = @"ensurePwdCell";
        ensurePwdCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (ensurePwdCell == nil) {
            ensurePwdCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier3] ;
        }
        ensurePwdCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        againPwdField = [[UITextField alloc]initWithFrame:CGRectMake(kWidthMargin, k10HeightMargin, kItemWidth, orginPwdCell.frame.size.height - 20)];
        againPwdField.delegate = self;
        againPwdField.font = k13Font;
        againPwdField.secureTextEntry = YES;
        [ensurePwdCell.contentView addSubview:againPwdField];
        againPwdField.placeholder = @"请再次输入新密码";
        
        return ensurePwdCell;
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 20) {
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
