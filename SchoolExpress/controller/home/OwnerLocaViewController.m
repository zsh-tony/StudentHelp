//
//  OwnerLocaViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-1.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "OwnerLocaViewController.h"
#import "SelectSchCell.h"

@interface OwnerLocaViewController ()
{
    CGFloat cellHeight;
}
@end

@implementation OwnerLocaViewController

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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, 524) style:UITableViewStylePlain];
    _tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    //_tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.delaysContentTouches = NO;
    _tableView.userInteractionEnabled = YES;
    
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"信息学院",@"交通科技大厦",@"6号公寓",@"先拿着，稍后联系", nil];
    [self.view addSubview:_tableView];
    [self addNavBar];
    
}
- (void)addNavBar
{
	// Do any additional setup after loading the view.
    UIView *navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:navBar];
    UIButton  *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(10, 30, 30, 20);
    [back setBackgroundImage:[UIImage imageNamed:@"navigationbar_back.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(Pop) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:back];
    UIButton  *addLoca = [UIButton buttonWithType:UIButtonTypeCustom];
    addLoca.frame = CGRectMake(260, 33, 50, 20);
    [addLoca setTitle:@"新增" forState:UIControlStateNormal];
    [addLoca setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addLoca setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    addLoca.titleLabel.font = [UIFont systemFontOfSize:15];
    [addLoca addTarget:self action:@selector(addLocation) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:addLoca];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 25, 160, 34)];
    titleLabel.text = @"快递送到哪";
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
-(void)addLocation
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入新增地址" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //得到输入框
    
    UITextField *tf=[alertView textFieldAtIndex:0];
    if (buttonIndex == 1) {
        NSLog(@"%@",tf.text);
        if (![tf.text isEqualToString:@""]) {
            [_dataArray addObject:tf.text];
            [self.tableView reloadData];
            
        }
        
    }

    
}
#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifierid = @"expressLocationCell";//这两个标识不能一样，因为这个标识是循环用的，所以最好用类名来进行区别
    UITableViewCell *ownerLocaCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierid];
    if (ownerLocaCell ==nil) {
        ownerLocaCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:cellIdentifierid];
        
    }
    ownerLocaCell.textLabel.text = _dataArray[indexPath.row];
    ownerLocaCell.selectionStyle  =  UITableViewCellSelectionStyleNone;
    
    return ownerLocaCell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectOwnerLoca) {
        _selectOwnerLoca(_dataArray[indexPath.row]);
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
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
