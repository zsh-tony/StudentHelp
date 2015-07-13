//
//  sendRouteViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-18.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "sendRouteViewController.h"
#import "ExchangeLocationCell.h"
#import "InputLocationVC.h"
#import "SendRoute.h"
#define kNavBarFrame CGRectMake(0, 0, 320, 64)
#define kTableviewFrame CGRectMake(0, 44, 320, 524)
#define kUIViewFrame  CGRectMake(0, 0, 320, 568)

@interface sendRouteViewController ()
{
    CGFloat frameHeight;//临时值，在调整界面随键盘高度改变而改变时用来判断升降高度的，等于4个textview在self.view中高度
    UIView *navBar;
    //UILabel *cellLabel;原来为cell的名称，后来用了cell原生的text
    UITextView *textViewT1;
    UITextView *textViewT2;
    UITextView *textView2;
    UITextView *textView1;//
    UIDatePicker *datePicker;
    UITextView  *pTextView;
    UIButton *doneBtn;//topview上面的完成键，topview为datepicker的accessoryview
    NSString *dateStr;//在将datepicker上的时间值传到textview上面时的临时值
    SendRoute *sendRoute;//
    ExchangeLocationCell *exchangeLocaionCell;
    UIToolbar * topView;
}
@end

@implementation sendRouteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - init
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addKeyobserver];
    // Do any additional setup after loading the view.
    sendRoute = [[SendRoute alloc]init];
    self.view.backgroundColor = kGlobalBg;
    [self initTableView];
    
    [self addNavBar];

    
    
}
- (void)addKeyobserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 504) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kGlobalBg;
    self.tableView.backgroundView = nil;
    self.tableView.SectionFooterHeight =5;
    self.tableView.sectionHeaderHeight = 20;
    self.tableView.contentSize = CGSizeMake(320, 800);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delaysContentTouches = NO;
    UIView *footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, 0, 300, 70);
    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
    [send setAllStateBg:@"common_button_big_red.png"];
    [send setTitle:@"发布" forState:UIControlStateNormal];
    send.frame = CGRectMake(10, 0, 300, 50);//footview会自动延伸,处理方法，在底层加了个纯洁的uiview
    [send addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:send];
    self.tableView.tableFooterView = footer;
    [self.tableView setScrollEnabled:NO];
    
    [self.view addSubview:_tableView];
}
-(void)send
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addNavBar
{
	// Do any additional setup after loading the view.
    navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navBar];
    UIButton  *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(10, 30, 30, 20);
    [back setBackgroundImage:[UIImage imageNamed:@"navigationbar_back.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(Pop) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:back];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 25, 160, 34)];
    titleLabel.text = @"发布行程";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment =UIControlContentHorizontalAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    //titleLabel.backgroundColor = [UIColor lightGrayColor];
    [navBar addSubview:titleLabel];
}

-(void)Pop
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - uitableviewdelegate 的实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    //return data.count;
    return 3;//控制有几行显示
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 88;//
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            return 60;
        }
    }
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 1;
    }
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier2 = @"exchangeLocaionCell";
        exchangeLocaionCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (exchangeLocaionCell == nil) {
            exchangeLocaionCell = [[ExchangeLocationCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier2] ;
        }
        exchangeLocaionCell.pushInputVC = ^(int tag){
            InputLocationVC *input = [[InputLocationVC alloc]init];
            input.selectedLocation = ^(NSString *backStr){
                if (tag == 1) {
                    [exchangeLocaionCell.fromBtn setTitle:backStr forState:UIControlStateNormal];
                     [exchangeLocaionCell.fromBtn setTitle:backStr forState:UIControlStateHighlighted];
                }
                if (tag == 2) {
                    [exchangeLocaionCell.toBtn setTitle:backStr forState:UIControlStateNormal];
                    [exchangeLocaionCell.toBtn setTitle:backStr forState:UIControlStateHighlighted];
                }
                sendRoute.fromLocation = exchangeLocaionCell.fromBtn.currentTitle;
                sendRoute.toLocation = exchangeLocaionCell.toBtn.currentTitle;
            };
            [self presentViewController:input animated:YES completion:nil];
        };//在这个block中将input的传回的地址值显示在cell的btn上
        exchangeLocaionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return exchangeLocaionCell;

    }else{
            static NSString *CellIdentifier1 = @"otherCell";
            UITableViewCell *otherCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (otherCell == nil) {
                otherCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
        }
        otherCell.textLabel.font = [UIFont systemFontOfSize:15];
        [self initDatePicker];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            textViewT1 = [[UITextView alloc]initWithFrame:CGRectMake(80, 8, 260, 30)];
            [textViewT1 setInputAccessoryView:topView];
            textViewT1.scrollEnabled = YES;
            textViewT1.delegate = self;
            textViewT1.inputView = datePicker;
            doneBtn.tag = 0;
            otherCell.textLabel.text = @"出发时间:";
            [otherCell.contentView addSubview:textViewT1];
            }else{
            textViewT2 = [[UITextView alloc]initWithFrame:CGRectMake(80, 8, 260, 30)];
            [textViewT2 setInputAccessoryView:topView];
            textViewT2.scrollEnabled = YES;
            textViewT2.delegate = self;
            textViewT2.inputView = datePicker;
            doneBtn.tag = 1;
            //footSeperatorView.frame = CGRectMake(0, 44, 320, 0.5);
            otherCell.textLabel.text = @"到达时间:";
            [otherCell.contentView addSubview:textViewT2];

        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            textView1 = [[UITextView alloc]initWithFrame:CGRectMake(80, 8, 260, 30)];
            textView1.frame = CGRectMake(80, 8, 260, 30);
            textView1.scrollEnabled = YES;
            textView1.delegate = self;
            textView1.returnKeyType = UIReturnKeyNext;
            textView1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            otherCell.textLabel.text = @"收取费用:";
             [otherCell.contentView addSubview:textView1];
        }else{
            textView2 = [[UITextView alloc]initWithFrame:CGRectMake(80, 8, 260, 40)];
            textView2.scrollEnabled = YES;
            textView2.delegate = self;
            textView2.returnKeyType = UIReturnKeyDone;
            textView2.keyboardType = UIKeyboardTypeDefault;
            otherCell.textLabel.text = @"补充说明:";
            [otherCell.contentView addSubview:textView2];
        }
    }
            otherCell.selectionStyle =  UITableViewCellSelectionStyleNone;
            return otherCell;
    }
    
}
- (void)initDatePicker
{
    datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 352, 320, 216)];
    datePicker.backgroundColor = [UIColor lightGrayColor];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [datePicker addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventValueChanged];
    datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:0];
    
    doneBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(260, 7, 40, 30);
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(Done1:) forControlEvents:UIControlEventTouchUpInside];
    topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
}

#pragma mark - 实现datepicker的点击事件方法，且传递其值
-(void)Done1:(UIButton *)sender
{
    [self.tableView setScrollEnabled:NO];
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if (sender.tag == 0) {
        
        if ([self dateFromString:textViewT2.text]) {//防止出现另一个还没有设置是空值时下面的早晚判断失效的情况
            //
            NSDate *tmp = [[self dateFromString:dateStr]  earlierDate:[self dateFromString:textViewT1.text]];
            
            if ( [tmp isEqualToDate:[self dateFromString:dateStr]]) {//判断早晚，以符合逻辑
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"到达时间不能小于等于出发时间" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                
            }else{
                //符合逻辑后才可以赋值
                textViewT1.text = dateStr;
            }
        }else{
            //若另一个为空，则就直接赋值，不用担心早晚问题，因为赋值后，再设置另一个时也会有同样的判断来保证
            textViewT1.text = dateStr;
        }
        
        
        
    }
    if (sender.tag == 1) {
        if ([self dateFromString:textViewT1.text]) {
            //
            NSDate *tmp = [[self dateFromString:dateStr]  earlierDate:[self dateFromString:textViewT1.text]];
            
            if ( [tmp isEqualToDate:[self dateFromString:dateStr]]) {
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"到达时间不能小于等于出发时间" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                
            }else{
                textViewT2.text = dateStr;
            }
        }else{
            textViewT2.text = dateStr;
        }
        
    }
    sendRoute.fromTime = textViewT1.text;
    sendRoute.toTime = textViewT2.text;
    
}
- (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
    
}
-(void)getDate:(UIDatePicker *)sender
{
    
    NSDate *date = sender.date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式(2010/10/10)
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 将NSDate转成NSString
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    dateStr = [formatter stringFromDate:date];
    
    
}
#pragma mark - uitextviewdelegate的实现
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    if ( [text isEqualToString:@"\n"] ) {
        //Do whatever you want
        [self.tableView setScrollEnabled:NO];
        if ([textView isEqual:textView1]) {
            [textView resignFirstResponder];
            //[textView2 isFirstResponder];
            [textView2 becomeFirstResponder];
        }else{
            [textView resignFirstResponder];
        }
        sendRoute.cost = textView1.text;
        sendRoute.explain = textView2.text;
        return NO;
    }
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView isEqual:textView2]) {
        [self.tableView setScrollEnabled:YES];
        frameHeight = 400;
    }
    if ([textView isEqual:textView1]) {
        frameHeight = 340;
        [self.tableView setScrollEnabled:YES];
    }
    if ([textView isEqual:textViewT1]){
        [self.tableView setScrollEnabled:YES];
        [self getDate:textView.inputView];
        frameHeight = 10;

    }
     if([textView isEqual:textViewT2]) {
        [self.tableView setScrollEnabled:YES];
         [self getDate:textView.inputView];
         frameHeight = 10;
  
    }

    return YES;
}

#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    NSDictionary *userInfo = [notification userInfo];
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    CGFloat height = keyboardRect.size.height - (568-frameHeight);
    [animationDurationValue getValue:&animationDuration];
    if (height < 0) {//<0说明，界面不用升降，只用把tableview的大小调一下，以当滑动时，界面都能显示
        [UIView animateWithDuration:animationDuration animations:^{
            self.tableView.frame =CGRectMake(0, 44, 320, 524-keyboardRect.size.height);
        }];
        
    }
    if (height > 0) {//大于0时说明界面要升降，
        [UIView animateWithDuration:animationDuration animations:^{
            navBar.frame = CGRectMake(0, height, 320, 64);
            
            self.tableView.frame =CGRectMake(0, 44, 320, 524-keyboardRect.size.height+height);
            
            self.view.frame = CGRectMake(0, -height, 320, 568);
            self.tableView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
            
        }];
        
    }
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    //[self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
}
- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    //[self moveInputBarWithKeyboardHeight:0.0 withDuration:animationDuration];
    [UIView animateWithDuration:animationDuration animations:^{
        [UIView animateWithDuration:0.2 animations:^{
            
            navBar.frame = kNavBarFrame;
            self.tableView.frame = kTableviewFrame;
            self.view.frame = kUIViewFrame;
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }];
        
        
    }];
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
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
