//
//  MessageViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-10.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "NewMessageCell.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

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
    self.view.backgroundColor = kGetColor(250, 255, 240);
    self.tableView.backgroundColor =kGlobalBg;
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_tableView.backgroundColor = kGetColor(255, 114, 12);
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //[self setNavigationTheme];
    self.title =@"消息";
    
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
    
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    // Return the number of rows in the section.
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"publishMessageCell";
        MessageCell *publishMessageCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
        if (publishMessageCell == nil) {
            publishMessageCell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleSubtitle                   reuseIdentifier:CellIdentifier] ;
        }
       
        
        publishMessageCell.imageView.image = [UIImage imageNamed:@"系统消息.png"];
        publishMessageCell.textLabel.text = @"系统消息";
        publishMessageCell.detailTextLabel.text = @"数据地方就是覅噢电视剧封ID搜破飞机的山坡附近都是反倒是iofj 啥地方 的设计佛的是否啥地方 ";
        publishMessageCell.messageTimeLabel.text = @"5月20日";
        return publishMessageCell;

    }else  if (indexPath.section == 1) {
        static NSString *CellIdentifier2 = @"locationMessageCell";
        MessageCell *locationMessageCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (locationMessageCell == nil) {
            locationMessageCell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleSubtitle                   reuseIdentifier:CellIdentifier2] ;
        }
        
        
        locationMessageCell.imageView.image = [UIImage imageNamed:@"附近消息.png"];
        locationMessageCell.textLabel.text = @"附近消息";
        locationMessageCell.detailTextLabel.text = @"数据地方就是覅噢电视剧封ID搜破飞机的山坡附近都是反倒是iofj 啥地方 的设计佛的是否啥地方 ";
        locationMessageCell.messageTimeLabel.text = @"5月20日";
        return locationMessageCell;
        
    }else{
        static NSString *CellIdentifier3 = @"orderMessageCell";
        MessageCell *orderMessageCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (orderMessageCell == nil) {
            orderMessageCell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleSubtitle                   reuseIdentifier:CellIdentifier3] ;
        }
        
        
        orderMessageCell.imageView.image = [UIImage imageNamed:@"订单跟踪.png"];
        orderMessageCell.textLabel.text = @"订单跟踪";
        orderMessageCell.detailTextLabel.text = @"数据地方就是覅噢电视剧封ID搜破飞机的山坡附近都是反倒是iofj 啥地方 的设计佛的是否啥地方 ";
        orderMessageCell.messageTimeLabel.text = @"5月20日";
        return orderMessageCell;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
