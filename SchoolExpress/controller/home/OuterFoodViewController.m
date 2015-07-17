//
//  OuterFoodViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-1.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "OuterFoodViewController.h"

#import "UITextViewCell.h"
#import "UIBTextViewCell.h"
#import "UIButtonCell.h"
#import "ExpressCpyViewController.h"
#import "ExpressLocaViewController.h"
#import "OwnerLocaViewController.h"
#import "LTBounceSheet.h"
#import "ASValueTrackingSlider.h"

#define kNavBarFrame CGRectMake(0, 0, 320, 64)
#define kTableviewFrame CGRectMake(0, 44, 320, 524)
#define kUIViewFrame  CGRectMake(0, 0, 320, 568)
#define kLTextViewFrame CGRectMake(80, 7, 230, 30)
#define kBTextViewFrame CGRectMake(80, 7, 230, 61)
#define kTextViewFont [UIFont systemFontOfSize:14]
#define kBContentHeight 40
#define kLContentHeight 30
#define kBigCellHeight 70
#define kLCellHeight 44
#define kLimitWords 29
@interface OuterFoodViewController ()
{
    CGFloat frameHeight;//临时值，在调整界面随键盘高度改变而改变时用来判断升降高度的，等于4个textview在self.view中高度
    UIView *navBar;
    UIDatePicker *datePicker;
    NSString *dateStr;
    UIButton *doneBtn;
    UIToolbar * topView;
    UITextViewCell *TimeCell;
    UITextViewCell *foodCell;
    UITextViewCell *storeCell;
    UIBTextViewCell *foodInfoCell;
    UIButtonCell *ownerLocaCell;
    UIButtonCell *feeCell;//
    UIBTextViewCell *noteCell;
    LTBounceSheet *freeSheet;
    ASValueTrackingSlider *freeSlider;
    NSString *sliderValueStr;
    UIButton *mask;
}
@end

@implementation OuterFoodViewController

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
    [self addKeyobserver];
    
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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 524) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kGlobalBg;
    self.tableView.backgroundView = nil;
    self.tableView.SectionFooterHeight =1;
    self.tableView.sectionHeaderHeight = 1;
    self.tableView.contentSize = CGSizeMake(320, 800);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delaysContentTouches = NO;
    [self.tableView setScrollEnabled:NO];
    UIView *footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, 0, 300, 70);
    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
    [send setAllStateBg:@"common_button_big_red.png"];
    [send setTitle:@"发布" forState:UIControlStateNormal];
    send.frame = CGRectMake(10, 5, 300, 45);//footview会自动延伸,处理方法，在底层加了个纯洁的uiview
    [send addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:send];
    self.tableView.tableFooterView = footer;
    
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
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 25, 160, 34)];
    titleLabel.text = @"谁帮我到食堂带份饭";
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
    return 2;//控制有几行显示
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//        if (indexPath.row == 3) {
//            return kBigCellHeight;
//        }else{
            return kLCellHeight;
     //   }
    }else{
        if (indexPath.row == 2) {
            return kBigCellHeight;
        }else{
            return kLCellHeight;
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 3;
    }
    // Return the number of rows in the section.
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"美食信息";
    }else{
        return @"其他";
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
    [doneBtn addTarget:self action:@selector(topViewDone:) forControlEvents:UIControlEventTouchUpInside];
    topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self initDatePicker];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *CellIdentifier2 = @"storeCell";
            storeCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (storeCell == nil) {
                storeCell = [[UITextViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier2] ;
            }
            
            storeCell.placeholder.text =  @"哪家店";
            
            storeCell.titleLabel.text = @"店铺名称:";
    
            storeCell.contentText.returnKeyType = UIReturnKeyNext;
            storeCell.returnKey = ^(UITextView *textView){
                [textView resignFirstResponder];
                [foodCell becomeFirstResponder];
                
                
            };
            storeCell.keyboardHeight = ^{
                frameHeight = 90;
            };

            storeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return storeCell;
            
            
            
        }else if (indexPath.row == 1){
            static NSString *CellIdentifier3 = @"foodCell";
            foodCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier3];
            if (foodCell == nil) {
                foodCell = [[UITextViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier3] ;
            }
            foodCell.placeholder.text = @"想吃什么";
            foodCell.contentText.returnKeyType = UIReturnKeyDone;
            foodCell.titleLabel.text = @"美食名称:";
            foodCell.returnKey = ^(UITextView *textView){
                [textView resignFirstResponder];
                
                
            };
            foodCell.keyboardHeight = ^{
                frameHeight = 90;
            };

            foodCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  foodCell;
            
            
        }else{
            
            static NSString *CellIdentifier1 = @"TimeCell";
            TimeCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
            if (TimeCell == nil) {
                TimeCell = [[UITextViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1] ;
            }
            
            [TimeCell.contentText setInputAccessoryView:topView];
            
            TimeCell.contentText.inputView = datePicker;
            TimeCell.placeholder.text = @"想什么时候吃到";
            TimeCell.titleLabel.text = @"送达时间:";
            TimeCell.keyboardHeight = ^{
                frameHeight = 90;
            };
            TimeCell.getDate = ^(UITextView *textView){
                [self getDate:textView.inputView];
            };
            TimeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  TimeCell;
        }
        
//        }else{
//            static NSString *CellIdentifier4 = @"InfoCell";
//            foodInfoCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier4];
//            if (foodInfoCell == nil) {
//                foodInfoCell = [[UIBTextViewCell alloc]initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:CellIdentifier4] ;
//            }
//            foodInfoCell.placeholder.text = @"具体的要求可以提，比如口味方面不要辣椒";
//            foodInfoCell.titleLabel.text = @"美食详情:";
//            foodInfoCell.contentText.returnKeyType = UIReturnKeyNext;
//            foodInfoCell.returnKey = ^(UITextView *textView){
//                [textView resignFirstResponder];
//                
//                
//            };
//            foodInfoCell.keyboardHeight = ^{
//                frameHeight = 90;
//            };
//            foodInfoCell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return foodInfoCell;
//        }
    }else{
        
        if (indexPath.row == 0){
            static NSString *CellIdentifier5 = @"OwnerCell";
            ownerLocaCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier5];
            if (ownerLocaCell == nil) {
                ownerLocaCell = [[UIButtonCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier5] ;
            }
            ownerLocaCell.placeholder.text = @"给你送到哪";
            
            ownerLocaCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            ownerLocaCell.titleLabel.text = @"送达地址:";
            ownerLocaCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  ownerLocaCell;
        }else if (indexPath.row == 1){
            static NSString *CellIdentifier6 = @"feeCell";
            feeCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier6];
            if (feeCell == nil) {
                feeCell = [[UIButtonCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier6] ;
            }
            feeCell.placeholder.text = @"小费越高，接单成功率越高噢";
            
            feeCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            feeCell.titleLabel.text = @"悬赏小费:";
            feeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  feeCell;
            
        }else{
            static NSString *CellIdentifier7 = @"noteCell";
            noteCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier7];
            if (noteCell == nil) {
                noteCell = [[UIBTextViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier7] ;
            }
            noteCell.placeholder.text = @"对接单者说点什么，比如:希望能够按时送达";
            noteCell.titleLabel.text = @"补充说明:";
            noteCell.contentText.returnKeyType = UIReturnKeyDone
            ;
            noteCell.returnKey = ^(UITextView *textView){
                [textView resignFirstResponder];
                
            };
            noteCell.keyboardHeight = ^{
                frameHeight = 475;
            };
            
            noteCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return noteCell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.section == 1){
        if (indexPath.row == 0) {
            OwnerLocaViewController *ownerLoca = [[OwnerLocaViewController alloc ]init];
            ownerLoca.selectOwnerLoca = ^(NSString *display){
                ownerLocaCell.placeholder.textColor = [UIColor blackColor];
                ownerLocaCell.placeholder.text = display;
            };
            [self presentViewController:ownerLoca animated:YES completion:nil];
        }else  if (indexPath.row == 1) {
            
            [self initFreeSheet];
            [[UIApplication sharedApplication].keyWindow endEditing:YES];
            [freeSheet show];
            [self addFeeMask];
        }

    }
}

-(void)addFeeMask
{
    mask = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [mask addTarget:self action:@selector(popMask) forControlEvents:UIControlEventTouchUpInside];
    mask.backgroundColor = [UIColor blackColor];
    mask.alpha = 0.3;
    [self.view addSubview:mask];
}
-(void)popMask
{    [freeSheet hide];
    [mask removeFromSuperview];
}
- (void)initFreeSheet
{
    
    
    
    freeSheet = [[LTBounceSheet alloc]initWithHeight:120 bgColor:kGlobalBg];
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 50, 30)];
    //cancelBtn.backgroundColor = [UIColor orangeColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelFreeSheet) forControlEvents:UIControlEventTouchUpInside];
    //cancelBtn.titleLabel.textColor = [UIColor blueColor];
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = kDetailContentFont;
    [freeSheet addView:cancelBtn];
    
    UIButton *freeDoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(250, 0, 50, 30)];
    //cancelBtn.backgroundColor = [UIColor orangeColor];
    [freeDoneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [freeDoneBtn addTarget:self action:@selector(doneFreeSheet) forControlEvents:UIControlEventTouchUpInside];
    //cancelBtn.titleLabel.textColor = [UIColor blueColor];
    [freeDoneBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    freeDoneBtn.titleLabel.font = kDetailContentFont;
    [freeSheet addView:freeDoneBtn];
    
    UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(20, 30, 280, 0.5)];
    seperator.alpha = 0.3;
    seperator.backgroundColor = [UIColor blackColor];
    [freeSheet addView:seperator];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(135, 0, 50, 30)];
    title.text = @"小费";
    title.font = kDetailContentFont;
    [freeSheet addView:title];
    
    freeSlider = [[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(20, 90, 270, 19)];
    freeSlider.maximumValue = 50.0;
    freeSlider.minimumValue = 1.0;
    freeSlider.popUpViewCornerRadius = 20;
    freeSlider.dataSource = self;
    [freeSlider setMaxFractionDigitsDisplayed:0];
    //    freeSlider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    freeSlider.popUpViewColor = kGetColor(234, 128, 16);
    //freeSlider.font = [UIFont fontWithName:@"GillSans-Bold" size:14];
    //freeSlider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
    freeSlider.font = kDetailContentFont;
    [freeSlider showPopUpView];
    freeSlider.textColor = kGlobalBg;
    [freeSheet addView:freeSlider];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:freeSheet];
}
-(void)cancelFreeSheet
{
    [freeSheet hide];
    [self popMask];
}
-(void)doneFreeSheet
{
    feeCell.placeholder.textColor = [UIColor blackColor];
    feeCell.placeholder.text = sliderValueStr;
    
    [freeSheet hide];
    [self popMask];
}
- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value
{
    sliderValueStr = [ NSString stringWithFormat:@"%d",(int)value];
    return sliderValueStr;
}

#pragma mark - 实现datepicker的点击事件方法，且传递其值
-(void)topViewDone:(UIButton *)sender
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    //    sendRoute.fromTime = textViewT1.text;
    //    sendRoute.toTime = textViewT2.text;
    
}
- (NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    
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
    TimeCell.contentText.text = dateStr;
    [TimeCell.placeholder setHidden:YES];
    
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
    [self.tableView setScrollEnabled:YES];
    if (height < 0) {//<0说明，界面不用升降，只用把tableview的大小调一下，以当滑动时，界面都能显示
        [UIView animateWithDuration:animationDuration animations:^{
            self.tableView.frame =CGRectMake(0, 44, 320, 524-keyboardRect.size.height-self.view.frame.origin.y);
            // self.tableView.frame =CGRectMake(0, 44, 320, 524-keyboardRect.size.height-self.view.frame.origin.y);不加self.view.frame.origin.y的话后面先点下面的再点上面的uitextview会导致不对
            
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
            [self.tableView setScrollEnabled:NO];
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

@end
