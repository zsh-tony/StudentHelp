//
//  ProfileViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-10.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "ProfileViewController.h"
#import "PersonIconCell.h"
#import "MessageCell.h"
#import "AccountViewController.h"
#import "MyOrderViewController.h"
#import "IdentyOauthViewController.h"
#import "InviteFriendViewController.h"
#import "AdviceViewController.h"
#import "AccountTool.h"
#import "Account.h"
#import "loginViewController.h"
#import "MyInfoViewController.h"
@interface ProfileViewController ()
{
    PersonIconCell *personIconCell;
    MessageCell *messageCell;
}
@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
      __weak  ProfileViewController *weakSelf = self;
        self.pushMyOrderVC = ^(){
            NSLog(@"refhhtrhreregr");
            MyOrderViewController *myOrder = [[MyOrderViewController alloc]init];
            myOrder.acceptNotification = ^(){
                [[NSNotificationCenter defaultCenter]  postNotificationName:@"displayOrder" object:nil];
            };
            [weakSelf.navigationController pushViewController: myOrder animated:YES];
            
            
        };

    }
    return self;
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-108) style:UITableViewStyleGrouped];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight =0;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.backgroundColor = kGlobalBg;
    UIView *footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, 0, 300, 70);
    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
    [send setAllStateBg:@"common_button_big_red.png"];
    [send setTitle:@"退出当前账号" forState:UIControlStateNormal];
    send.frame = CGRectMake(10, 10, 300, 44);//footview会自动延伸,处理方法，在底层加了个纯洁的uiview
    [send addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:send];
    self.tableView.tableFooterView = footer;
    [self.view addSubview:self.tableView];
}
-(void)pushMyOrderVC:(NSNotification *)notification
{
    NSLog(@"refhhtrhreregr");
    MyOrderViewController *myOrder = [[MyOrderViewController alloc]init];
    [self.navigationController pushViewController: myOrder animated:YES];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的";
    [self initTableView];
     //NSLog(@"userId=%@",[AccountTool sharedAccountTool].currentAccount.userId);
  
    
}

-(void)setNavigationTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    //navBar.backgroundColor = kGetColor(255, 114, 12);
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
    //控制器上面的导航栏会默认影响状态栏的颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //[navBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background.png"]]];
    [navBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor],
                                     UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero],
                                     UITextAttributeFont:[UIFont systemFontOfSize:20]}];
    
    
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
    
    [self.navigationController.navigationBar setTranslucent:NO];
}

-(void)send
{
    
}
#pragma mark - uitableviewdelegate 的实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return     4;

}
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    
    return 20.0 ;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 110;
 
    }else{
        return 44;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
    return 2;
    }
    // Return the number of rows in the section.
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier1 = @"personIconCell";
        personIconCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (personIconCell == nil) {
            personIconCell = [[PersonIconCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
        }
        personIconCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        personIconCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [personIconCell.iconImageBtn setImage:[UIImage imageNamed:@"同学帮@2x.png"] forState:UIControlStateNormal];
        
        personIconCell.nameSexLabel.text = @"阿邦♂";
        
        [personIconCell.iconImageBtn addTarget:self action:@selector(addIcon) forControlEvents:UIControlEventTouchUpInside];
        [personIconCell.nameSexBtn addTarget:self action:@selector(changeNameSex) forControlEvents:UIControlEventTouchUpInside];
        
        personIconCell.pointValueLabel.text = [NSString stringWithFormat:@"%d",17];
        personIconCell.markLabel.text = @"个性签名:我要攒人品！！！！！";
        return personIconCell;

    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString *CellIdentifier3 = @"accountCell";
         UITableViewCell *accountCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier3];
            if (accountCell == nil) {
                accountCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier3] ;
            }
            accountCell.textLabel.text = @"我的账户";
            accountCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            accountCell.textLabel.font = kTitleFont;
            accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return accountCell;

        }else{
            static NSString *CellIdentifier4 = @"orderCell";
           UITableViewCell *orderCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier4];
            if (orderCell == nil) {
                orderCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier4] ;
            }
            orderCell.textLabel.text = @"我的订单";
            orderCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            orderCell.textLabel.font = kTitleFont;
            orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return orderCell;
        }
        
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            static NSString *CellIdentifier5 = @"currentCell";
            UITableViewCell *currentCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier5];
            if (currentCell == nil) {
                currentCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier5] ;
            }
            currentCell.textLabel.text = @"当前认证:未认证";
            // currentCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            currentCell.textLabel.font = kTitleFont;
            currentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return currentCell;
            
        }else{
            static NSString *CellIdentifier6 = @"oauthCell";
            UITableViewCell *oauthCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier6];
            if (oauthCell == nil) {
                oauthCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier6] ;
            }
            oauthCell.textLabel.text = @"申请认证";
            oauthCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            oauthCell.textLabel.font = kTitleFont;
            oauthCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return oauthCell;
        }
        
        
    }else{
        
        if (indexPath.row == 0) {
            static NSString *CellIdentifier7 = @"inviteCell";
            UITableViewCell *inviteCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier7];
            if (inviteCell == nil) {
                inviteCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier7] ;
            }
            inviteCell.textLabel.text = @"邀请好友送人品币";
            inviteCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            inviteCell.textLabel.font = kTitleFont;
            inviteCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return inviteCell;
            
        }else{
            static NSString *CellIdentifier8 = @"adviceCell";
            UITableViewCell *adviceCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier8];
            if (adviceCell == nil) {
                adviceCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier8] ;
            }
            adviceCell.textLabel.text = @"建议与反馈";
            adviceCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            adviceCell.textLabel.font = kTitleFont;
            adviceCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return adviceCell;
        }
    }
   
   
    
}
-(void)addIcon
{
    NSLog(@"fsdfsd");
}

-(void)changeNameSex
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MyInfoViewController *myInfo = [[MyInfoViewController alloc]init];
        [self.navigationController pushViewController:myInfo animated:YES ];
    }
    if(indexPath.section == 1){
        if (indexPath.row == 0) {
            AccountViewController *account = [[AccountViewController alloc]init];
            [self.navigationController pushViewController:account animated:YES];
        }
        if (indexPath.row == 1) {
            MyOrderViewController *myOrder = [[MyOrderViewController alloc]init];
            [self.navigationController pushViewController:myOrder animated:YES];
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 1) {
            IdentyOauthViewController *identy = [[IdentyOauthViewController alloc]init];
            [self.navigationController pushViewController:identy animated:YES];
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            InviteFriendViewController *invite = [[InviteFriendViewController alloc]init];
            [self.navigationController pushViewController:invite animated:YES];
        }else{
            AdviceViewController *advice = [[AdviceViewController alloc]init];
            [self.navigationController pushViewController:advice animated:YES];
        }
    }
    
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
