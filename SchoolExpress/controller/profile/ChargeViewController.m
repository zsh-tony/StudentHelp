//
//  ChargeViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-12.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "ChargeViewController.h"
#import "UITextViewCell.h"
#import "ChargeCell.h"
#define kTableviewFrame CGRectMake(0, 0, 320, 568)
#define kUIViewFrame  CGRectMake(0, 0, 320, 568)
#define kLTextViewFrame CGRectMake(80, 7, 230, 30)
#define kBTextViewFrame CGRectMake(80, 7, 230, 61)


@interface ChargeViewController ()
{
    CGFloat frameHeight;
    int flag;
}
@end

@implementation ChargeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)addKeyobserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addKeyobserver];
    // Do any additional setup after loading the view.
    self.title = @"账户充值";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = 20;
    self.tableView.backgroundColor = kGetColor(240, 255, 230);
    UIView *footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, 0, 300, 70);
    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
    [send setAllStateBg:@"common_button_big_red.png"];
    [send setTitle:@"立即充值" forState:UIControlStateNormal];
    send.frame = CGRectMake(30, 0, 260, 44);//footview会自动延伸,处理方法，在底层加了个纯洁的uiview
    [send addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:send];
    self.tableView.tableFooterView = footer;
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 70)];
    header.backgroundColor = kGetColor(240, 255, 230);
    UILabel *account = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 100, 15)];
    account.backgroundColor = [UIColor clearColor];
    account.font = kDetailContentFont;
    account.text = @"当前用户:  阿邦";
    [header addSubview:account];
    UILabel *accountValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 65, 15)];
    accountValueLabel.backgroundColor = [UIColor clearColor];
    accountValueLabel.text = @"账户余额:";
    accountValueLabel.font = kDetailContentFont;
    [header addSubview:accountValueLabel];
    UILabel *accountValue = [[UILabel alloc]initWithFrame:CGRectMake(75, 50, 60, 15)];
    accountValue.backgroundColor = [UIColor clearColor];
    accountValue.text = @"17.00";
    accountValue.textColor = [UIColor blueColor];
    accountValue.font = kDetailContentFont;
    [header addSubview:accountValue];

    self.tableView.tableHeaderView = header;
    [self.view addSubview:self.tableView];
    
}
-(void)charge
{
    NSLog(@"%d",flag);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return     2;

}
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    
    return 10.0 ;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        return 180;
    }else{
        return 44;
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"    选择充值方式";
    }else{
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier3 = @"accountCell";
        UITextViewCell *amountCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (amountCell == nil) {
            amountCell = [[UITextViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier3] ;
        }
       amountCell.titleLabel.text = @"充值金额";
        amountCell.placeholder.text = @"请输入充值金额";
        amountCell.contentText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        amountCell.returnKey = ^(UITextView *textView){
            [textView resignFirstResponder];
        };
        amountCell.keyboardHeight = ^{
            frameHeight = 90;
        };
        amountCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return amountCell;
        
    }else{
        
            static NSString *CellIdentifier4 = @"chargeCell";
            ChargeCell *chargeCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier4];
            if (chargeCell == nil) {
                chargeCell = [[ChargeCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier4] ;
            }
        chargeCell.radioTag = ^(int tag){
            flag = tag;
        };
           chargeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return chargeCell;

    }
    
    
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
            self.tableView.frame =CGRectMake(0, 0, 320, 568-keyboardRect.size.height-self.view.frame.origin.y);
            // self.tableView.frame =CGRectMake(0, 44, 320, 524-keyboardRect.size.height-self.view.frame.origin.y);不加self.view.frame.origin.y的话后面先点下面的再点上面的uitextview会导致不对
            
        }];
        
    }
    if (height > 0) {//大于0时说明界面要升降，
        [UIView animateWithDuration:animationDuration animations:^{
           // navBar.frame = CGRectMake(0, height, 320, 64);
            
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
            //[self.tableView setScrollEnabled:NO];
            //navBar.frame = kNavBarFrame;
            self.tableView.frame = kTableviewFrame;
            //self.view.frame = kUIViewFrame;
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
