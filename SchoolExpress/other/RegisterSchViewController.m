//
//  RegisterSchViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-5-9.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "RegisterSchViewController.h"
#import "UIlabelCell.h"
#import "BigSelectSchViewController.h"
@interface RegisterSchViewController ()
{
    UIlabelCell *campusCell;
    NSString *selfUserId;
}
@end

@implementation RegisterSchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _passUserId = ^(NSString *userId){
            selfUserId = userId;
        };
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight =0;
    self.tableView.sectionHeaderHeight = 0;
    self.view.backgroundColor = kGetColor(240, 255, 230);
        UIView *footer = [[UIView alloc]init];
        footer.frame = CGRectMake(0, 0, 300, 70);
        UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
        [send setAllStateBg:@"common_button_big_red.png"];
        [send setTitle:@"完成" forState:UIControlStateNormal];
        send.frame = CGRectMake(10, 10, 300, 44);//footview会自动延伸,处理方法，在底层加了个纯洁的uiview
        [send addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:send];
        self.tableView.tableFooterView = footer;
    [self.view addSubview:self.tableView];
}

-(void)done
{
    NSLog(@"selfCodeid=%@",selfUserId);
   // NSURLRequest *request = [NSURLRequest requestWithPath:kRegistUserPath params:@{@"step" : @"3",@"userId":selfUserId,@"campus":campusCell.contentLabel.text,}];
    NSLog(@"字典%@---%@",selfUserId,campusCell.contentLabel.text);
    
     NSURLRequest *request = [NSURLRequest requestWithPath:kRegistUserPath params:[NSDictionary dictionaryWithObjectsAndKeys:@"3",@"step",selfUserId,@"userId",campusCell.contentLabel.text,@"campus", nil]];
     
    //NSURLRequest *request = [NSURLRequest requestWithPath:kRegistUserPath params:@{@"step":@"1",  @"phone":selfPhone,                                                  }];
    NSHTTPURLResponse *response = nil;
    NSError *error =nil;
    NSLog(@"%@",request);
    NSData *responeData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responesStr = [[NSString alloc]initWithData:responeData encoding:NSUTF8StringEncoding];

    NSLog(@"返回的是%@",responesStr);
    
    if ([responesStr isEqualToString:@"success"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"dismissSelf" object:nil];
            }
}

#pragma mark - uitableviewdelegate 的实现
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
    
        return 1;
   
    
    
    // Return the number of rows in the section.
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier1 = @"campusCell";
        campusCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (campusCell == nil) {
            campusCell = [[UIlabelCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
        }
        campusCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    campusCell.titleLabel.text = @"我的学校";

       
        return campusCell;
        
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BigSelectSchViewController *registerSch = [[BigSelectSchViewController alloc]init];
    __weak BigSelectSchViewController *weakRegisterSch = registerSch;
    registerSch.selectmidSchBlock = ^(int selectSch,NSString *display){
        [weakRegisterSch dismissViewControllerAnimated:YES completion:nil];
        campusCell.contentLabel.text = display;
    };
    [self presentViewController:registerSch animated:YES completion:nil];
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
