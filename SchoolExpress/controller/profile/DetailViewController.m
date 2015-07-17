//
//  OrderViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-12.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "DetailViewController.h"
#import "Order.h"
#import "HeaderView.h"
#import "DetailAccountCell.h"
#import "TotalHeadView.h"



@interface DetailViewController ()
{
    RFSegmentView* segmentView;
//    Order *testOrder;
//    Order *testOrder3;
//    Order *testOrder5;
//    NSMutableArray *orderArray;
//    NSMutableArray *testArray1;
//    NSMutableArray *testArray2;
//    NSMutableArray *testArray3;
//    NSMutableArray *totalArray;
   // DetailAccountCell *monthCell;
    NSArray *monthsArray;
    NSDictionary *monthsDict;
    NSArray *daysArray;
    NSDictionary *daysDict;
    NSArray *incomePayArray;
    NSDictionary *accountDict;
}

// 存放所有组的展开\合并状态
// key=组号  value=对应组的状态（1代表展开，0代表合并）
@property (nonatomic, strong) NSMutableDictionary *status;
@end

@implementation DetailViewController

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
    self.title = @"账户明细";

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"account" ofType:@"plist"];
    
    
    accountDict = [NSDictionary dictionaryWithContentsOfFile:path];
    monthsArray = accountDict[@"monthAccounts"];
       self.status = [NSMutableDictionary dictionary];
    monthsDict = [NSDictionary dictionary];
    daysDict = [NSDictionary dictionary];
    daysArray = [NSArray array];
    incomePayArray = [NSArray array];

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    
    TotalHeadView *totalView = [[TotalHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    totalView.accountText.text = [NSString stringWithFormat:@"￥%.2f",[accountDict[@"totalAccount"]floatValue]];
    totalView.incomeText.text = [NSString stringWithFormat:@"%.2f",[ accountDict[@"income"]floatValue]];
    totalView.payText.text = [NSString stringWithFormat:@"%.2f",[accountDict[@"pay"]floatValue]];
    _tableView.tableHeaderView = totalView;
    
    self.tableView.tag = 100;
    self.tableView.backgroundColor =kGlobalBg;
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [_tableView setTableFooterView:view];

        self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

}

- (void)segmentViewSelectIndex:(NSInteger)index
{
    NSLog(@"current index is %ld",(long)index);
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
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [UIView animateWithDuration:1 animations:^{
         [segmentView removeFromSuperview];
    }];
   
}

#pragma mark - 数据源、代理方法
#pragma mark 有多少组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 100) {
        return monthsArray.count;
    }else{
        return 1;
    }
    
}

#pragma mark 每一组中有多少行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"tableviewtag= %d",tableView.tag);
    //if (tableView.tag == 100) {
        // 取出第section组对应的状态
        int result = [self.status[@(section)] intValue];
        
        if (result == 0) { // 合并状态
            return 0;
        } else { // 展开状态
            // 1.先获取这组对应的数据
            monthsDict = monthsArray[section];
            // 2.获取这组里面的好友
            daysArray = monthsDict[@"dayAccounts"];
            return daysArray.count;
        }

    
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    DetailAccountCell *monthCell = [[DetailAccountCell alloc]init];
        monthsDict = monthsArray[indexPath.section];
    monthCell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 2.获取这组里面的好友
        daysArray = monthsDict[@"dayAccounts"];
        NSString *monthStr = monthsDict[@"month"];
    daysDict = daysArray[indexPath.row];
    monthCell.dayLabel.text = daysDict[@"day"];
    
    
    incomePayArray = daysDict[@"incomePay"];
    if (monthCell.setDayTableView) {
        monthCell.setDayTableView(44.0f*[incomePayArray count],incomePayArray);
    }
    
    NSDate* now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit;
    NSDateComponents *dd = [cal components:unitFlags fromDate:now];
    int year = (int)[dd year];
    

    
  monthCell.weekdayLabel.text = [self  weekdayFromDateWithYear:year Month:[monthStr intValue] day:[daysDict[@"day"]intValue]];
                return monthCell;
   
}

#pragma mark 每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        monthsDict = monthsArray[indexPath.section];
        // 2.获取这组里面的好友
        daysArray = monthsDict[@"dayAccounts"];
        
        daysDict = daysArray[indexPath.row];
 
        incomePayArray = daysDict[@"incomePay"];
        return 44.0f * incomePayArray.count;
}
#pragma mark 每一组标题的高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
        return 44;
}

-(NSString *)weekdayFromDateWithYear:(int)year Month:(int)month day:(int)day
{
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:day];
    [_comps setMonth:month];
    [_comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    int weekday = (int)[weekdayComponents weekday];
    NSString *weekdayStr = [[NSString alloc]init];
    switch (weekday) {
        case 1:
            weekdayStr = @"周一";
            break;
            
        case 2:
            weekdayStr = @"周二";
            break;
            
        case 3:
            weekdayStr = @"周三";
            break;
            
        case 4:
            weekdayStr = @"周四";
            break;
            
        case 5:
            weekdayStr = @"周五";
            break;
            
        case 6:
            weekdayStr = @"周六";
            break;
            
        case 7:
            weekdayStr = @"周日";
            break;
    }
    
    return weekdayStr;
}

#pragma mark 第section组对应的标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

        HeaderView *titleView = [HeaderView buttonWithType:UIButtonTypeCustom];
    NSLog(@"titleview%f",titleView.frame.size.height);
        // 设置标题内容
         monthsDict = monthsArray[section];

        titleView.monthText.text = monthsDict[@"month"];
        titleView.incomeText.text =[NSString stringWithFormat:@"收入 %@",monthsDict[@"income"]] ;
        titleView.payText.text  = [NSString stringWithFormat:@"支出 %@",monthsDict[@"pay"]] ;
        titleView.totalText.text =[NSString stringWithFormat:@"%.2f",[monthsDict[@"total"] floatValue]] ;
        // 设置背景颜色
        [titleView setBackgroundColor:kGetColor(232, 232, 232)];
        
        // 设置按钮的tag为组号
        titleView.tag = section;
        
        // 监听标题点击
        [titleView addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 取出第section组的状态
        int result = [self.status[@(section)] intValue];
        // 对状态进行取反
        if (result == 0) {
            titleView.imageView.transform = CGAffineTransformIdentity;
        } else {
            titleView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
        
        return titleView;


}

#pragma mark - 监听标题点击
- (void)titleClick:(UIButton *)btn {
    // 取出标题按钮对应的组号
    int section = (int)btn.tag;
    
    // 取出第section组的状态
    int result = [self.status[@(section)] intValue];
    
    // 对状态进行取反
    if (result == 0) {
        [self.status setObject:@1 forKey:@(section)];
    } else {
        [self.status setObject:@0 forKey:@(section)];
    }
    
    // 刷新数据（会重新给数据源发送消息）
    [self.tableView reloadData];
    
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
