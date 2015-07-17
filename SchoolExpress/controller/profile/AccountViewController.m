//
//  AccountViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-12.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "AccountViewController.h"
#import "ChargeViewController.h"
#import "DetailViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

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
    self.title = @"我的账户";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.view.backgroundColor = kGetColor(240, 255, 230);
    UIView *footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, 0, 300, 70);
    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
    [send setAllStateBg:@"common_button_big_red.png"];
    [send setTitle:@"充值" forState:UIControlStateNormal];
    send.frame = CGRectMake(10, 10, 300, 44);//footview会自动延伸,处理方法，在底层加了个纯洁的uiview
    [send addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:send];
    self.tableView.tableFooterView = footer;
    [self.view addSubview:self.tableView];
    
}
-(void)charge
{
    ChargeViewController *charge = [[ChargeViewController alloc]init];
    [self.navigationController pushViewController:charge animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return     1;

}
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    
    return 20.0 ;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

        return 44;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        return 2;
    
    // Return the number of rows in the section.
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *CellIdentifier3 = @"accountCell";
        UITableViewCell *accountCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (accountCell == nil) {
            accountCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier3] ;
        }
        accountCell.textLabel.text = @"账户金额";
        accountCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        accountCell.textLabel.font = kTitleFont;
        accountCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc]init];
        label.text = @"17.00";
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor grayColor];
        label.bounds = CGRectMake(0, 0, 60, 30);
        accountCell.accessoryView =label;
        return accountCell;
        
    }else{
        static NSString *CellIdentifier4 = @"detailCell";
        UITableViewCell *detailCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (detailCell == nil) {
            detailCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier4] ;
        }
        detailCell.textLabel.text = @"账户明细";
        detailCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        detailCell.textLabel.font = kTitleFont;
        detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return detailCell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (indexPath.row == 1) {
            DetailViewController *detailAccount = [[DetailViewController alloc]init];
            [self.navigationController pushViewController:detailAccount animated:YES];
        }
    
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
