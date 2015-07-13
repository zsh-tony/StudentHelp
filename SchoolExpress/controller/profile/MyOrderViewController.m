//
//  MyOrderViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-12.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderCell.h"
#import "MJRefresh.h"
#import "Order.h"
#import "OrderTool.h"
#import "MyDetailOrderViewController.h"
#import "CancelOrderViewController.h"

#define kContentSegmentHeight 35

@interface MyOrderViewController ()<MJRefreshBaseViewDelegate>
{
     RFSegmentView* titleSegmentView;
    Order *testOrder;
    Order *testOrder3;
    Order *testOrder5;
    NSInteger testIndex;
    NSMutableArray *releasedUnderwayArray;
    NSMutableArray *releasedCompletedArray;
    NSMutableArray *releasedFailArray;
    NSMutableArray *acceptedUnderwayArray;
    NSMutableArray *acceptedCompletedArray;
    NSMutableArray *acceptedFailArray;
    NSMutableDictionary *releasedDict;
    NSMutableDictionary *acceptedDict;
    NSMutableDictionary *ordersDict;
    MJRefreshHeaderView *header;
    MJRefreshFooterView *footer;
    //NSMutableArray *ordersArray;
    NSString *orderTotalTypeFlag;
    NSString *orderTypeFlag;
    UIImageView *bgView;
    
    
    
}
@end

@implementation MyOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
           [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayOrder:) name:@"displayOrder" object:nil];
                // Custom initialization
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshFailOrder:) name:@"refreshFailOrder" object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAcceptOrder:) name:@"refreshAcceptOrder" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCompleteOrder:) name:@"refreshCompleteOrder" object:nil];
    }
    return self;
}

-(void)displayOrder:(NSNotification *)notification
{
    NSLog(@"oujiojij");
    [titleSegmentView selectItemSelectedWith:1];
    [self changeIndex:1];
}

-(void)refreshFailOrder:(NSNotification *)notification
{
    NSLog(@"刷新了failorder");
    _contentSegmentView.selectedSegmentIndex = 2;
    [self selectedSegment:_contentSegmentView];
}

-(void)refreshAcceptOrder:(NSNotification *)notification
{
    NSLog(@"刷新了acceptorder");
    _contentSegmentView.selectedSegmentIndex = 0;
    [self selectedSegment:_contentSegmentView];

}

-(void)refreshCompleteOrder:(NSNotification *)notification
{
    NSLog(@"刷新了completeorder");
    _contentSegmentView.selectedSegmentIndex = 1;
    [self selectedSegment:_contentSegmentView];
    
}

- (void)initOrderData
{
    releasedUnderwayArray = [NSMutableArray array];
    releasedCompletedArray = [NSMutableArray array];
    releasedFailArray = [NSMutableArray array];
    acceptedUnderwayArray = [NSMutableArray array];
    acceptedCompletedArray = [NSMutableArray array];
    acceptedFailArray = [NSMutableArray array];
    
    releasedDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:releasedUnderwayArray,[NSString stringWithFormat:@"%d",UnderwayOrder],releasedCompletedArray,[NSString stringWithFormat:@"%d",CompletedOrder],releasedFailArray,[NSString stringWithFormat:@"%d",FailOrder], nil];
    
    acceptedDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:acceptedUnderwayArray,[NSString stringWithFormat:@"%d",UnderwayOrder],acceptedCompletedArray,[NSString stringWithFormat:@"%d",CompletedOrder],acceptedFailArray,[NSString stringWithFormat:@"%d",FailOrder], nil];
    ordersDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:releasedDict,[NSString stringWithFormat:@"%d",OrderReleaseType],acceptedDict,[NSString stringWithFormat:@"%d",OrderAcceptType], nil];
}

- (void)addTtileSegmentView
{
    titleSegmentView = [[RFSegmentView alloc] initWithFrame:CGRectMake(80, 0, 160, 44) items:@[@"我发布的",@"我接单的"]];
    titleSegmentView.tintColor = [UIColor orangeColor];
    titleSegmentView.delegate = self;
 
    
    self.navigationItem.titleView = titleSegmentView;
    
}

- (void)viewDidLoad
{
 
    [super viewDidLoad];
    [self addTtileSegmentView];
    [self initOrderData];
    orderTypeFlag = [NSString stringWithFormat:@"%d",UnderwayOrder];
    orderTotalTypeFlag = [NSString stringWithFormat:@"%d",ReleasedStatus];

    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kContentSegmentHeight, 320, 524) style:UITableViewStyleGrouped];
    //self.tableView.tableHeaderView = self.contentSegmentView;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
     [self changeIndex:0];
    //self.view.backgroundColor = kGetColor(250, 255, 240);
    header = [[MJRefreshHeaderView alloc]init];
    header.backgroundColor = kGlobalBg;
    header.scrollView = self.tableView;
    
    if (_acceptNotification) {
        _acceptNotification();
    }
    NSLog(@"我接受的%@",orderTotalTypeFlag);
    header.delegate = self;
    [header beginRefreshing];
    //® [header endRefreshing];
    footer = [[MJRefreshFooterView alloc]init];
    //    footer.beginRefreshingBlock = ^(MJRefreshBaseView *view){
    //        NSLog(@"dgdhdh");
    //    };
    footer.delegate = self;
    footer.backgroundColor = kGlobalBg;
    footer.scrollView = self.tableView;
    
   [self.view addSubview:self.contentSegmentView];
    

    

    
}

-(void)refreshDataWithOrderTotalType:(NSString *)orderTotalType OrderType:(NSString *)orderType OrdersArray:(NSMutableArray *)ordersArray
{
    [bgView removeFromSuperview];
    NSString *sinceId = nil;
    if (ordersArray.count) {
        //status *first =  _orders[0];
        Order *order = ordersArray[0];
        
        sinceId = order.sortId;
    }
    
    [OrderTool ordersWithSinceId:sinceId  orderType:(NSString *)orderType orderTotalType:(NSString *)orderTotalType
 success:^(NSMutableArray *orders) {
        //[_orders addObjectsFromArray:orders];//用这个方法只能加载到后面，所以应该返回来
        //[ self showNewNumberStatusCount:orders.count];
        
        NSMutableArray *newOrders = [NSMutableArray array];
        for (Order *s in orders) {
            NSLog(@"%@",s.helpClass.publishTime);
            NSLog(@"dsfds%d",s.orderStatus);
            [newOrders addObject:s];
        }
   
        
        //        [orders addObjectsFromArray:_orders];
        //        _orders = orders;
     
     NSMutableArray *tmpArray = [[ordersDict objectForKey:orderTotalType] objectForKey:orderType];
     // NSLog(@"wefwef----%d",tmpArray.count);
     [newOrders addObjectsFromArray:tmpArray];
     tmpArray = newOrders;
     //[ordersArrayDict removeObjectForKey:eventType];
     [[ordersDict objectForKey:orderTotalType]  setObject:tmpArray forKey:orderType];

     
    // NSLog(@"%@",ordersArray);
        [self.tableView reloadData];
        
        [header endRefreshing];
        
    } fail:^{
        bgView = [[UIImageView alloc]initWithFrame:self.view.frame];
        bgView.image = [UIImage imageNamed:@"大白高.png"];
        [self.tableView addSubview:bgView];
        [header endRefreshing];
        
    }
     ];
    
}
-(void)loadDataWithOrderTotalType:(NSString *)orderTotalType OrderType:(NSString *)orderType OrdersArray:(NSMutableArray *)ordersArray
{

    [bgView removeFromSuperview];
    NSString *maxId = nil;
    if (ordersArray.count) {
        //status *last = [_orders lastObject];
        Order *order = [ordersArray lastObject];
        long long lastlld = [order.sortId longLongValue];
        NSLog(@"lastlld%lld",lastlld);
        lastlld--;
        maxId = [NSString stringWithFormat:@"%lld",lastlld];//新浪加载的是<=maxid的微博，所以要-1
    }
    [OrderTool ordersWithMaxId:maxId orderType:orderType orderTotalType:orderTotalType success:^(NSMutableArray *orders) {
        //[_orders addObjectsFromArray:orders];
        NSMutableArray *newOrders = [NSMutableArray array];
        for (Order *s in orders) {
            // NSLog(@"时间%@---状态%d",s.helpExpress.publishTime, s.orderStatus);
            [newOrders addObject:s];
        }
        [ordersArray addObjectsFromArray:newOrders];
        
        
        [self.tableView reloadData];
        [footer endRefreshing];
        
    } fail:^{
        bgView = [[UIImageView alloc]initWithFrame:self.view.frame];
        bgView.image = [UIImage imageNamed:@"大白高.png"];
        [self.tableView addSubview:bgView];
        [footer endRefreshing];
    }
     ];
    
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView//协议名称一般不包括前缀
{
    if (header ==refreshView) {
       // [self refreshData];
        [self refreshDataWithOrderTotalType:orderTotalTypeFlag OrderType:orderTypeFlag OrdersArray:[[ordersDict objectForKey:orderTotalTypeFlag] objectForKey:orderTypeFlag]];
    }else{
        //[self loadData];
        [self loadDataWithOrderTotalType:orderTotalTypeFlag OrderType:orderTypeFlag OrdersArray:[[ordersDict objectForKey:orderTotalTypeFlag] objectForKey:orderTypeFlag]];
    }
    
}



-(void)changeIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)_contentSegmentView.selectedSegmentIndex);
    if (index == 0) {
        orderTotalTypeFlag = [NSString stringWithFormat:@"%d",OrderReleaseType];
        if (_contentSegmentView.selectedSegmentIndex == 0) {
            //orderArray = [NSMutableArray arrayWithArray:testArray1];
            orderTypeFlag = [NSString stringWithFormat:@"%d",UnderwayOrder];
        }else if (_contentSegmentView.selectedSegmentIndex == 1){
            //orderArray = [NSMutableArray arrayWithArray:testArray2];
            orderTypeFlag = [NSString stringWithFormat:@"%d",CompletedOrder];
        }else{
            //orderArray = [NSMutableArray arrayWithArray:testArray3];
            orderTypeFlag =[NSString stringWithFormat:@"%d",FailOrder];
        }
    }else{
        orderTotalTypeFlag = [NSString stringWithFormat:@"%d",OrderAcceptType];
        if (_contentSegmentView.selectedSegmentIndex == 0) {
            //orderArray = [NSMutableArray arrayWithArray:testArray2];
            orderTypeFlag = [NSString stringWithFormat:@"%d",UnderwayOrder];
        }else if (_contentSegmentView.selectedSegmentIndex == 1){
            //orderArray = [NSMutableArray arrayWithArray:testArray3];
            orderTypeFlag = [NSString stringWithFormat:@"%d",CompletedOrder];
        }else{
            //orderArray = [NSMutableArray arrayWithArray:testArray1];
            orderTypeFlag = [NSString stringWithFormat:@"%d",FailOrder];
        }
    }
}
- (DZNSegmentedControl *)contentSegmentView
{
    if (!_contentSegmentView)
    {
        _contentSegmentView = [[DZNSegmentedControl alloc] initWithItems:@[@"进行中",@"已完成",@"已失效"]];
        _contentSegmentView.backgroundColor = kGlobalBg;
        _contentSegmentView.delegate = self;
        _contentSegmentView.selectedSegmentIndex = 0;
        _contentSegmentView.bouncySelectionIndicator = YES;
        _contentSegmentView.showsCount = NO;
        _contentSegmentView.height = kContentSegmentHeight;
        //        _contentSegmentView.showsGroupingSeparators = YES;
        //        _contentSegmentView.inverseTitles = YES;
        //   _contentSegmentView.backgroundColor = [UIColor lightGrayColor];
           _contentSegmentView.tintColor = kGetColor(255, 114, 12);
        //    _contentSegmentView.hairlineColor = [UIColor purpleColor];
        //        _contentSegmentView.autoAdjustSelectionIndicatorWidth = NO;
        //        _contentSegmentView.selectionIndicatorHeight = _contentSegmentView.intrinsicContentSize.height;
        //        _contentSegmentView.adjustsFontSizeToFitWidth = YES;
        [_contentSegmentView setTitleColor:kGetColor(255, 114, 12) forState:UIControlStateSelected];
        [_contentSegmentView addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
    }
    return _contentSegmentView;
}

//- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
//{
//    
//    return 0 ;
//    
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0 ;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
    // Return the number of rows in the section.
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
        return 20;
    
}
//- (CGFloat)tableView:(UITableView *)tableView footForHeaderInSection:(NSInteger)section
//{
//    return 0;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
    return [[[ordersDict objectForKey:orderTotalTypeFlag] objectForKey:orderTypeFlag] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *CellIdentifier3 = @"myOrderCell";
        MyOrderCell *myOrderCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (myOrderCell == nil) {
            myOrderCell = [[MyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier3] ;
        }
    //testCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    Order *s  = [[ordersDict objectForKey:orderTotalTypeFlag] objectForKey:orderTypeFlag][indexPath.section];
    if ([[ordersDict objectForKey:orderTotalTypeFlag] objectForKey:orderTypeFlag][indexPath.section] == nil||[[[ordersDict objectForKey:orderTotalTypeFlag] objectForKey:orderTypeFlag] count] ==0) {
        bgView = [[UIImageView alloc]initWithFrame:self.view.frame];
        bgView.image = [UIImage imageNamed:@"大白高.png"];
        [self.tableView addSubview:bgView];
    }else{
        [bgView removeFromSuperview];
    //NSLog(@"时间%@---状态%d",s.helpExpress.publishTime, s.orderStatus);
    myOrderCell.Order = [[ordersDict objectForKey:orderTotalTypeFlag] objectForKey:orderTypeFlag][indexPath.section];
    }
        return myOrderCell;
        
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyDetailOrderViewController *myOrderDetail = [[MyDetailOrderViewController alloc]init];
    myOrderDetail.presentCancelVC = ^(){
        CancelOrderViewController *cancel = [[CancelOrderViewController alloc]init];
        [self addTtileSegmentView];
        [self presentViewController:cancel animated:YES completion:nil];
    };
    if (myOrderDetail.detailStatus) {
        myOrderDetail.detailStatus([[ordersDict objectForKey:orderTotalTypeFlag] objectForKey:orderTypeFlag][indexPath.section],[orderTotalTypeFlag intValue]);
        
    }
    [self.navigationController pushViewController:myOrderDetail animated:YES];
}
-(void)selectedSegment:(DZNSegmentedControl *)control
{
    [self changeIndex:testIndex];
    //[self.tableView reloadData];
    [header beginRefreshing];
}

- (void)segmentViewSelectIndex:(NSInteger)index
{
    testIndex = index;
    [self changeIndex:testIndex];
    //[self.tableView reloadData];
    [header beginRefreshing];
    NSLog(@"current index is %d",index);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [UIView animateWithDuration:1 animations:^{
        [titleSegmentView removeFromSuperview];
    }];
    
}
- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionBottom;
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
