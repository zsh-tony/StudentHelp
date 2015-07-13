//
//  DiscoverViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-10.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverOrderCell.h"
#import "HelpExpress.h"
#import "CampusFood.h"
#import "HelpClass.h"
#import "DetailStatusViewController.h"
#import "MJRefresh.h"
#import "Order.h"
#import "OrderTool.h"
#import "AcceptedOrderViewController.h"
#import "loginViewController.h"
#import "SelectSchViewController.h"

#define kSegmentHeight 35
#define kCellHeight 80
#define kCHD @"长大"
#define kCount 4

@interface DiscoverViewController ()<MJRefreshBaseViewDelegate,DZNSegmentedControlDelegate>
{
    HelpExpress *helpExpress;
    DiscoverOrderCell *discoverOrderCell;
    CampusFood *campusFood;
    HelpClass *helpClass;
    NSMutableArray *dataArray;
    MJRefreshHeaderView *header;
    MJRefreshFooterView *footer;
    NSMutableArray *AllOrders;
    NSMutableArray *HelpClassOrders;
    NSMutableArray *HelpExpressOrders;
    NSMutableArray *CampusFoodOrders;
    NSString *eventFlag;
    NSMutableDictionary *ordersArrayDict;
    UIImageView *bgView;
    
    UIButton *btn;
    int newTag;
    int tmpTag;
    int tag;
    CGRect selecSchFrame;
    SelectSchViewController *selsch;

}
@end

@implementation DiscoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}


- (void)initOrdersArray
{
    AllOrders = [[NSMutableArray alloc]init];
    HelpExpressOrders = [[NSMutableArray alloc]init];
    HelpClassOrders = [[NSMutableArray alloc]init];
    CampusFoodOrders = [[NSMutableArray alloc]init];
    ordersArrayDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:AllOrders,[NSString stringWithFormat:@"%d",AllType],
                       HelpClassOrders,[NSString stringWithFormat:@"%d",HelpClassType],
                       HelpExpressOrders,[NSString stringWithFormat:@"%d",HelpExpressType],
                       CampusFoodOrders,[NSString stringWithFormat:@"%d",CampusFoodType],nil];
//    NSLog(@"%@-%@_%@_%@",AllOrders,HelpExpressOrders,HelpClassOrders,CampusFoodOrders);
//    NSLog(@"%@",ordersArrayDict);
}
-(void)presentAcceptVC:(NSNotification *)notification
{
    AcceptedOrderViewController *accept = [[AcceptedOrderViewController alloc]init];
    [self presentViewController:accept animated:YES completion:nil];
    
}
-(void)presentMyOrderVC:(NSNotification *)notification
{
    //NSLog(@"rereregr");
    if (_changeToProfileVC) {
        _changeToProfileVC();
    }
    
}
-(void)refreshSelf:(NSNotification *)notification
{
    [header beginRefreshing];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentAcceptVC:) name:@"presentAcceptVC" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentMyOrderVC:) name:@"presentMyOrderVC" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentAcceptVC:) name:@"refreshSelf" object:nil];
    
    self.title = @"同学帮";
    self.view.backgroundColor = kGlobalBg;
    //eventFlag = [NSString stringWithFormat:@"%d",HelpExpressType];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kSegmentHeight, self.view.bounds.size.width, self.view.bounds.size.height-kSegmentHeight-108)style:UITableViewStylePlain];
   // CGFloat tes = self.view.frame.size.height;
   // NSLog(@"view的高度%f",tes);
    [self initOrdersArray];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = kGlobalBg;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self.view addSubview:self.contentSegmentView];
    [self.view addSubview:_tableView];
    header = [[MJRefreshHeaderView alloc]init];
    header.scrollView = self.tableView;
    header.backgroundColor =kGlobalBg;
    //header.beginRefreshingBlock = ^(MJRefreshBaseView *view){
    //NSLog(@"fdsf");
    // };
    //[header beginRefreshing];//原因在于此时代理还没有设置，所以出错了
    header.delegate = self;
    [self segmentCtrlValuechange:_contentSegmentView];
    //[header beginRefreshing];

    footer = [[MJRefreshFooterView alloc]init];
    //    footer.beginRefreshingBlock = ^(MJRefreshBaseView *view){
    //        NSLog(@"dgdhdh");
    //    };
    footer.delegate = self;
    footer.scrollView = self.tableView;
    footer.backgroundColor = kGlobalBg;
    [self.tableView reloadData];
    
    
    newTag = 11;
    tmpTag = 100;
    [self addSelectSchBtn];
   //[self setNavigationTheme];
    
}

-(void)setNavigationTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    //navBar.backgroundColor = kGetColor(255, 114, 12);
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"orange1.png"] forBarMetrics:UIBarMetricsDefault];
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

- (void)addSelectSchBtn
{
    // Do any additional setup after loading the view.
    
    
    tag = 10;//便于后面实现selectsch
    CGSize btnsize = CGSizeMake(50,30);
    CGSize newBtnSize = CGSizeMake(75, 30);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithBg:@"timeline_icon_more.png" title:kCHD size:btnsize target:self action:@selector(selectSchool)];
    
    selsch = [[SelectSchViewController alloc]init];
    selecSchFrame = selsch.view.frame;
    selsch.view.frame = CGRectMake(0, -568, 320, 568);
    [self.view addSubview:selsch.view];
    [self addChildViewController:selsch];
    selsch.MaskViewPop = ^(){
        [self selectSchool];
    };
    selsch.selectmidSchBlock = ^(int selmidsch,NSString *display){
        [self selectSchool];
        
        if ([display isEqualToString:@"全部"]) {
            
            UIBarButtonItem *tmpitem = [UIBarButtonItem barButtonItemWithBg:nil title:kCHD size:btnsize target:self action:@selector(selectSchool)];
            self.navigationItem.rightBarButtonItem = tmpitem;
            
            
        }else{
            
            UIBarButtonItem *tmpitem = [UIBarButtonItem barButtonItemWithBg:@"common_button_white.png" title:[NSString stringWithFormat:@"%@%@",kCHD,display] size:newBtnSize target:self action:@selector(selectSchool)];
            self.navigationItem.rightBarButtonItem = tmpitem;
        }
    };
}
-(void)selectSchool
{
    
    if (tag == 10) {
        [UIView animateWithDuration:0.2 animations:^{
            // [self.view addSubview:selsch.view];
            selsch.view.frame = selecSchFrame;
            tmpTag = newTag;
            newTag = tag;
            tag = tmpTag;
        }];
        
        
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            //[selsch.view removeFromSuperview];
            selsch.view.frame = CGRectMake(0, -568, 320, 568);
            tmpTag = newTag;
            newTag = tag;
            tag = tmpTag;
        }];
        
    }
    
}
-(void)refreshDataWithEventType:(NSString *)eventType OrdersArray:(NSMutableArray *)ordersArray
{
    [bgView removeFromSuperview];
    NSString *sinceId = nil;
    if (ordersArray.count) {
        //status *first =  _orders[0];
         Order *order = ordersArray[0];
        
        sinceId = order.sortId;
        //NSLog(@"wedwewrew%@",sinceId);
    }
    
    [OrderTool ordersWithSinceId:sinceId  eventType:eventType success:^(NSMutableArray *orders) {
        //[_orders addObjectsFromArray:orders];//用这个方法只能加载到后面，所以应该返回来
        //[ self showNewNumberStatusCount:orders.count];
        //NSLog(@"数组%@",orders);
        NSMutableArray *newOrders = [NSMutableArray array];
        for (Order *s in orders) {
          //  NSLog(@"sfregtrhyh%@",s.helpExpress.publishTime);
            [newOrders addObject:s];
        }
        NSMutableArray *tmpArray = [ordersArrayDict objectForKey:eventType];
       // NSLog(@"wefwef----%d",tmpArray.count);
        [newOrders addObjectsFromArray:tmpArray];
        tmpArray = newOrders;
        //[ordersArrayDict removeObjectForKey:eventType];
        [ordersArrayDict setObject:tmpArray forKey:eventType];
       // NSLog(@"4f4tt34---%d",[[ordersArrayDict objectForKey:eventType] count]);
        //NSLog(@"%@---%@",newOrders[0].eventType,ordersArray[0]);
        
        //        [orders addObjectsFromArray:_orders];
        //        _orders = orders;
        
        [self.tableView reloadData];
        
        [header endRefreshing];
        
    } fail:^{
        NSLog(@"刷新失败");
        bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
        bgView.image = [UIImage imageNamed:@"大白.png"];
        [self.tableView addSubview:bgView];
        [header endRefreshing];
        
    }
     ];
    
 
    
    
}
-(void)loadDataWithEventType:(NSString *)eventType OrdersArray:(NSMutableArray *)ordersArray
{
    [bgView removeFromSuperview];
    NSString *maxId = nil;
    if (ordersArray.count) {
               //status *last = [_orders lastObject];
        Order *order = [ordersArray lastObject];
        long long lastlld = [order.sortId longLongValue];
        lastlld--;
        NSLog(@"%@",order.sortId);
        maxId = [NSString stringWithFormat:@"%lld",lastlld];//新浪加载的是<=maxid的微博，所以要-1
        NSLog(@"MAXID----%@",maxId);
    }
    
    [OrderTool ordersWithMaxId:maxId eventType:eventType success:^(NSMutableArray *orders) {
        //[_orders addObjectsFromArray:orders];
        NSMutableArray *newOrders = [NSMutableArray array];
        for (Order *s in orders) {
         
            [newOrders addObject:s];
        }
        [ordersArray addObjectsFromArray:newOrders];
        
        
        [self.tableView reloadData];
        [footer endRefreshing];
        
    } fail:^{
        bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
        bgView.image = [UIImage imageNamed:@"大白.png"];
        [self.tableView addSubview:bgView];
        [footer endRefreshing];
    }
     ];
    
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView//协议名称一般不包括前缀
{
   // NSLog(@"kdjsklfj");
    if (header ==refreshView) {
        [self refreshDataWithEventType:eventFlag OrdersArray:[ordersArrayDict objectForKey:eventFlag]];
    }else{
        [self loadDataWithEventType:eventFlag OrdersArray:[ordersArrayDict objectForKey:eventFlag]];
    }
    
}


-(void)changeIndex:(NSInteger)index
{
//    NSLog(@"%d",_contentSegmentView.selectedSegmentIndex);
//    if (index == 0) {
//        if (_contentSegmentView.selectedSegmentIndex == 0) {
//            orderArray = [NSMutableArray arrayWithArray:testArray1];
//        }else if (_contentSegmentView.selectedSegmentIndex == 1){
//            orderArray = [NSMutableArray arrayWithArray:testArray2];
//        }else{
//            orderArray = [NSMutableArray arrayWithArray:testArray3];
//        }
//    }else{
//        if (_contentSegmentView.selectedSegmentIndex == 0) {
//            orderArray = [NSMutableArray arrayWithArray:testArray2];
//        }else if (_contentSegmentView.selectedSegmentIndex == 1){
//            orderArray = [NSMutableArray arrayWithArray:testArray3];
//        }else{
//            orderArray = [NSMutableArray arrayWithArray:testArray1];
//        }
//    }
}
-(VOSegmentedControl *)contentSegmentView
{
    if (!_contentSegmentView) {
        _contentSegmentView = [[VOSegmentedControl alloc] initWithSegments:@[@{@"text": @"全部"},@{@"text": @"取快递"},
    @{@"text": @"替上课"}, @{@"text": @"食堂带饭"}, @{@"text": @"校外带饭"},
       @{@"text": @"超市购物"},@{@"text": @"其他"}]];
        _contentSegmentView.contentStyle = VOContentStyleTextAlone;
        _contentSegmentView.indicatorStyle = VOSegCtrlIndicatorStyleBottomLine;
        _contentSegmentView.backgroundColor = [UIColor blackColor];
        _contentSegmentView.textColor = [UIColor whiteColor];
        _contentSegmentView.selectedTextColor = [UIColor whiteColor];
        _contentSegmentView.selectedBackgroundColor = [UIColor blackColor];
        _contentSegmentView.selectedIndicatorColor = [UIColor orangeColor];
        _contentSegmentView.allowNoSelection = NO;
        _contentSegmentView.selectedSegmentIndex = 0;
        _contentSegmentView.frame = CGRectMake(0, 0, 320, 44);
        _contentSegmentView.selectedTextFont = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        _contentSegmentView.textFont =[UIFont fontWithName:@"Helvetica-Bold" size:15];
        _contentSegmentView.indicatorThickness = 13;
        _contentSegmentView.indicatorCornerRadius = 5;
        _contentSegmentView.tag = 1;
        _contentSegmentView.scrollBounce =NO;
        [_contentSegmentView setIndexChangeBlock:^(NSInteger index) {
           // NSLog(@"1: block --> %@", @(index));
        }];
        [_contentSegmentView addTarget:self action:@selector(segmentCtrlValuechange:) forControlEvents:UIControlEventValueChanged];
    }
    return _contentSegmentView;
    
}

- (void)segmentCtrlValuechange: (VOSegmentedControl *)segmentCtrl{
	//NSLog(@"%@: value --> %@",@(segmentCtrl.tag), @(segmentCtrl.selectedSegmentIndex));
    switch (segmentCtrl.selectedSegmentIndex) {
        case 0:
            eventFlag = [NSString stringWithFormat:@"%d",AllType];
            break;
        case 1:
            eventFlag = [NSString stringWithFormat:@"%d",HelpExpressType];
            break;
        case 2:
            eventFlag = [NSString stringWithFormat:@"%d",HelpClassType];
            break;
        case 3:
            eventFlag = [NSString stringWithFormat:@"%d",CampusFoodType];
            break;
    }
    [header beginRefreshing];
}


-(void)selectedSegment:(DZNSegmentedControl *)control
{
    //[self changeIndex:testIndex];
    switch (control.selectedSegmentIndex) {
        case 0:
            eventFlag = [NSString stringWithFormat:@"%d",AllType];
            break;
        case 1:
            eventFlag = [NSString stringWithFormat:@"%d",HelpExpressType];
            break;
        case 2:
            eventFlag = [NSString stringWithFormat:@"%d",HelpClassType];
            break;
        case 3:
            eventFlag = [NSString stringWithFormat:@"%d",CampusFoodType];
            break;
    }
    [header beginRefreshing];
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionBottom;
}
#pragma mark - uitableviewdelegate 的实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    //return data.count;
    return [[ordersArrayDict objectForKey:eventFlag] count];//控制有几行显示
    //return dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return kCellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
        return 1;
    
    // Return the number of rows in the section.
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"discoverOrderCell";
    discoverOrderCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
    if (discoverOrderCell == nil) {
        discoverOrderCell = [[DiscoverOrderCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier] ;
    }
    discoverOrderCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage stretchImageWithName:@"common_button_big_red.png"]];
    bg.frame = CGRectMake(0, 0, 320, 90);

    if ([[ordersArrayDict objectForKey:eventFlag] count]!= 0||
        [ordersArrayDict objectForKey:eventFlag] == nil) {
        [bgView removeFromSuperview];
       // NSLog(@"indexpath-section%d",indexPath.section);
        Order *order =  [[ordersArrayDict objectForKey:eventFlag] objectAtIndex:indexPath.section];
//        NSLog(@"wfrwfr5re5%@---%d",order.helpClass.classTime,order.eventType);
//        NSLog(@"wfrwfr5dsfdsfsdre5%@",[ordersArrayDict objectForKey:eventFlag]);
        switch (order.eventType) {
            case HelpClassType:
                discoverOrderCell.helpClass = order.helpClass;

                break;
                
            case HelpExpressType:
                discoverOrderCell.helpExpress = order.helpExpress;
                break;
                
            case CampusFoodType:
                discoverOrderCell.campusFood = order.campusFood;
                break;
                
            default:
                break;
        }

    }else{
       bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height)];
        bgView.image = [UIImage imageNamed:@"大白.png"];
        [self.tableView addSubview:bgView];
    }
    
    return discoverOrderCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([AccountTool sharedAccountTool].currentAccount.userId == nil) {
//        loginViewController *login = [[loginViewController alloc]init];
//        UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:login];
//        
//        [self presentViewController:loginNav animated:YES completion:nil];
//    }else{
    DetailStatusViewController *detail = [[DetailStatusViewController alloc]init];
    if (detail.detailStatus) {
        detail.detailStatus([[ordersArrayDict objectForKey:eventFlag] objectAtIndex:indexPath.section]);
    }
    [self.navigationController pushViewController:detail animated:YES];
   // }
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
