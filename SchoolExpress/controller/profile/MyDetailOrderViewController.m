//
//  MyDetailOrderViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-5-3.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "MyDetailOrderViewController.h"
#import "HelpExpress.h"
#import "CampusFood.h"
#import "HelpClass.h"
#import "DOrderInfoCell.h"
#import "DOrderStatusCell.h"
#import "UserCell.h"
#import "CancelOrderViewController.h"
#import "AggreeOrderViewController.h"
#import "CompleteOrderViewController.h"

#define kWidthMargin 10
#define kHeightMargin 10
#define kTitleHeight 15
#define kTextWidth 80


#define kStatusCellHeight 99
#define kInfoCellHeight 150
#define kTitleFont [UIFont systemFontOfSize:16]
#define kDetailContentFont [UIFont systemFontOfSize:14]
#define kLittleFont [UIFont systemFontOfSize:13]
@interface MyDetailOrderViewController ()<UIAlertViewDelegate>
{
    UIButton *userInfoBtn;
    UIImageView *iconImageView;
    UILabel *nickNameLabel;
    UILabel *memberPointLabel;
    UILabel *pointValueLabel;
    UIView *statusInfoView;
    UILabel *titleLabel;
    UIImageView *feeImage;
    UILabel *feeLabel;
    UILabel *creatTime;
    UILabel *firstTitleLabel;
    UILabel *firstInfoLabel;
    UILabel *secondTitleLabel;
    UILabel *secondInfoLabel;
    UILabel *thirdTitleLabel;
    UILabel *thirdInfoLabel;
    UILabel *forthTitleLabel;
    UILabel *forthInfoLabel;
    UILabel *fifthTitleLabel;
    UILabel *fifthInfoLabel;
    DOrderInfoCell *dOrderInfoCell;
    DOrderStatusCell *dOrderStatusCell;
    Order *detailOrder;
    UserCell *accepterCell;
    
    UIAlertView *alert1;
    UIAlertView *alert2;
    OrderTotalType orderTotalTypeFlag;
}

@end

@implementation MyDetailOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.detailStatus = ^(Order *order,OrderTotalType orderTotalType){
            detailOrder = order;
            orderTotalTypeFlag = orderTotalType;
        };
        
        // Custom initialization
//        [self addSubViews];
//        self.detailStatus = ^(NSObject *obj){
//            if ([obj isKindOfClass:[HelpExpress class]]) {
//                [self dataWithHelpExpress:(HelpExpress *)obj];
//            }
//            if ([obj isKindOfClass:[CampusFood class]]) {
//                [self dataWithCampusFood:(CampusFood *)obj];
//            }
//            if ([obj isKindOfClass:[HelpClass class]]) {
//                [self dataWithHelpClass:(HelpClass *)obj];
//            }
//        };
        

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kGlobalBg;
    //self.tableView.backgroundView = nil;
    self.tableView.sectionFooterHeight =0;
    self.tableView.sectionHeaderHeight = 5;
    //self.tableView.contentSize = CGSizeMake(320, 800);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //self.tableView.delaysContentTouches = NO;
   // [self.tableView setScrollEnabled:NO];
    //    UIView *footer = [[UIView alloc]init];
    //    footer.frame = CGRectMake(0, 0, 300, 70);
    //    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [send setAllStateBg:@"common_button_big_red.png"];
    //    [send setTitle:@"发布" forState:UIControlStateNormal];
    //    send.frame = CGRectMake(10, 5, 300, 45);//footview会自动延伸,处理方法，在底层加了个纯洁的uiview
    //    [send addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    //    [footer addSubview:send];
    //    self.tableView.tableFooterView = footer;
    
    [self.view addSubview:_tableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 30;
    }else{
    return 10;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {

        UILabel *titlleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin+kWidthMargin+200, kHeightMargin, kTextWidth, kTitleHeight)];
        titlleLabel.textColor = kTitleColor;
        titlleLabel.backgroundColor = [UIColor clearColor];
        titlleLabel.font = kLittleFont;
        if (orderTotalTypeFlag == 1) {
            titlleLabel.text = @"  订单发布者";
        }else{
        titlleLabel.text = @"  接单申请者";
        }
        return titlleLabel;
    }else{
        return nil;
    }
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0;
//}
#pragma mark - uitableviewdelegate 的实现


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (orderTotalTypeFlag == 1) {
    
            return 3;
        

    }else{
    if (detailOrder.orderStatus == 1) {
        if (detailOrder.acceptUser != nil) {
            if (detailOrder.acceptUser.count != 0) {
                return 3;
            }
        }else{
            return 2;
        }
        return 2;
    }else{
        return 2;
    }
    }
    // Return the number of sections.
    //return data.count;
    //控制有几行显示
    //return dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kStatusCellHeight;
    }else if (indexPath.section == 1){
        return kInfoCellHeight;
    }else{
        return 60;
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if (section == 2) {
        if (orderTotalTypeFlag == 1) {
            return 1;
        }else{
        return detailOrder.acceptUser.count;
        }
    }else{
    return 1;
    }
    
    // Return the number of rows in the section.
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"dOrderStatusCell";
        dOrderStatusCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
        if (dOrderStatusCell == nil) {
            dOrderStatusCell = [[DOrderStatusCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier] ;
           // dOrderStatusCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        dOrderStatusCell.order = detailOrder;
        return dOrderStatusCell;
        
    }else if (indexPath.section == 1){
        static NSString *CellIdentifier = @"dOrderInfoCell";
        dOrderInfoCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
        if (dOrderInfoCell == nil) {
            dOrderInfoCell = [[DOrderInfoCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier] ;
        }
        __weak MyDetailOrderViewController *weakSelf = self;
        dOrderInfoCell.presentCancelVC = ^(int tag){
            //[self.navigationController popViewControllerAnimated:NO];
            
            CancelOrderViewController *cancel = [[CancelOrderViewController alloc]init];
            if (tag == 10) {
                cancel.iconLabel.text = @"成功取消接单";
                cancel.titleLabel.text = @"成功取消接单";
                cancel.noteImage.hidden = YES;
                cancel.noteLabel.hidden = YES;
            }
            

            cancel.popMydetailOrderVC =^(){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshFailOrder" object:nil];
                [weakSelf.navigationController popViewControllerAnimated:NO];
                
            };
            NSLog(@"%@",cancel.titleLabel.text);
            [weakSelf presentViewController:cancel animated:YES completion:nil];
//            if (_presentCancelVC) {
//                _presentCancelVC();
//            }
        };
        
        dOrderInfoCell.presentCompleteVC = ^(){
            CompleteOrderViewController *complete = [[CompleteOrderViewController alloc]init];
            complete.popToMyOrderVC = ^(){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshCompleteOrder" object:nil];
                [weakSelf.navigationController popViewControllerAnimated:NO];
            };
            
            [weakSelf presentViewController:complete animated:YES completion:nil];
        };
        
            switch (detailOrder.eventType) {
                case HelpClassType:
                    dOrderInfoCell.helpClass = detailOrder.helpClass;
//       NSLog(@"iktyuuyr%@-%@-%@--%@-%@-%@-%@-%@-%@", order.helpClass.className,order.helpClass.classTime,order.helpClass.publishTime,order.helpClass.roomLocation,order.helpClass.titleText,order.helpClass.user.nickName,order.helpClass.user.userId,order.helpClass.fee,order.helpClass.note);
                    break;
                    
                case HelpExpressType:
                    dOrderInfoCell.helpExpress = detailOrder.helpExpress;
                    break;
                    
                case CampusFoodType:
                    dOrderInfoCell.campusFood = detailOrder.campusFood;
                    break;
                    
            }
        if (orderTotalTypeFlag == 1) {
            [dOrderInfoCell.cancelOrderBtn setTitle:@"取消接单" forState:UIControlStateNormal];
            dOrderInfoCell.cancelOrderBtn.tag = 10;
        }
        
        if (detailOrder.orderStatus == ConfirmedStatus) {
            dOrderInfoCell.cancelOrderBtn.hidden = YES;
            if (orderTotalTypeFlag == 0) {
                dOrderInfoCell.CompleteOrderBtn.hidden = NO;
            }
            
        }
    
        return  dOrderInfoCell;
    }else{
        static NSString *CellIdentifier = @"dOrderStatusCell";
        accepterCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
        if (accepterCell == nil) {
            accepterCell = [[UserCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier] ;
            // dOrderStatusCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        NSLog(@"rertretregt---%@",detailOrder.acceptUser);
        User *u = detailOrder.acceptUser[0];
        NSLog(@"抢单的id%@",u.userId);
        accepterCell.tag = (int)indexPath.row;
        if (orderTotalTypeFlag == 1) {
            switch (detailOrder.eventType) {
                case HelpClassType:
                    accepterCell.user = detailOrder.helpClass.user;

                    break;
                    
                case HelpExpressType:
                    accepterCell.user = detailOrder.helpExpress.user;
                    break;
                    
                case CampusFoodType:
                    accepterCell.user = detailOrder.campusFood.user;
                    break;
                    
            }

            accepterCell.aggreeBtn.hidden = YES;
            accepterCell.refuseBtn.hidden = YES;
            
        }else{
        if (detailOrder.acceptUser != nil) {
            accepterCell.user = detailOrder.acceptUser[indexPath.row];
        }
            __block UIAlertView *weakAlert = alert1;
        accepterCell.presentAggreeOrderVC = ^(){
            
            weakAlert = [[UIAlertView alloc]initWithTitle:@"确认提醒" message:@"取快递需要快递主人的取件信息,确认后我们将发送您的电话、姓名以及快递公司名称发送给接单者,若不同意发送，我们将反馈给您接单者的联系方式，请您稍后与TA联系" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"同意发送",@"不同意", nil];
            [weakAlert show];
        
        };
        accepterCell.presentRefuseOrderVC = ^(){
            NSLog(@"已经拒绝了");
            [tableView reloadData];
        };
        }
        return accepterCell;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
    if (alertView == alert1) {
        if (buttonIndex == 1) {
            AggreeOrderViewController *aggree = [[AggreeOrderViewController alloc]init];
            
            
            User *u = detailOrder.acceptUser[accepterCell.tag];
            NSLog(@"测试抢单ID%@",u.userId);
            //    //NSLog(@"%@",accessUrlstr);
            NSURLRequest *request = [NSURLRequest requestWithPath:kConfirmOrdersPath params:@{@"userId":u.userId ,@"eventType":[NSString stringWithFormat:@"%d",detailOrder.eventType],@"orderId":detailOrder.orderId}];
            
            NSHTTPURLResponse *response = nil;
            NSError *error =nil;
            NSLog(@"抢单%@",request);
            NSData *responeData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSString *responesStr = [[NSString alloc]initWithData:responeData encoding:NSUTF8StringEncoding];
            //NSLog(@"%@----%@",teststr1,teststr);
            NSLog(@"%@",responesStr);
            
            if ([responesStr isEqualToString:@"success"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshAcceptOrder" object:nil];
                aggree.popMydetailOrderVC = ^(){
                    [self.navigationController popViewControllerAnimated:NO];
                };
                
                [self presentViewController:aggree animated:YES completion:nil];
            }

            
        }else if(buttonIndex == 2){
            alert2 = [[UIAlertView alloc]initWithTitle:nil message:@"确认成功后,我们将以短信形式将接单者联系方式发送给您,希望您及时与TA进行联系" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert2 show];
            
            
            
        }

    }else{
        AggreeOrderViewController *aggree = [[AggreeOrderViewController alloc]init];
        
        
        User *u = detailOrder.acceptUser[accepterCell.tag];
        NSLog(@"测试抢单ID%@",u.userId);
        //    //NSLog(@"%@",accessUrlstr);
        NSURLRequest *request = [NSURLRequest requestWithPath:kConfirmOrdersPath params:@{@"userId":u.userId ,@"eventType":[NSString stringWithFormat:@"%d",detailOrder.eventType],@"orderId":detailOrder.orderId}];
        
        NSHTTPURLResponse *response = nil;
        NSError *error =nil;
        
        NSData *responeData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *responesStr = [[NSString alloc]initWithData:responeData encoding:NSUTF8StringEncoding];
        //NSLog(@"%@----%@",teststr1,teststr);
        NSLog(@"%@",responesStr);
        
        if ([responesStr isEqualToString:@"success"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshAcceptOrder" object:nil];
            aggree.popMydetailOrderVC = ^(){
                [self.navigationController popViewControllerAnimated:NO];
            };
            
            [self presentViewController:aggree animated:YES completion:nil];
        }
        
        

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
