//
//  DetailStatusViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-11.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "DetailStatusViewController.h"
#import "HelpExpress.h"
#import "CampusFood.h"
#import "HelpClass.h"
#import "DOrderInfoCell.h"
#import "DOrderStatusCell.h"
#import "UserCell.h"


#define kWidthMargin 10
#define kHeightMargin 10
#define kTitleHeight 15
#define kTextWidth 80


#define kStatusCellHeight 80
#define kInfoCellHeight 150
#define kTitleFont [UIFont systemFontOfSize:16]
#define kDetailContentFont [UIFont systemFontOfSize:14]
#define kLittleFont [UIFont systemFontOfSize:13]

#define kTitleFont [UIFont systemFontOfSize:16]
#define kDetailContentFont [UIFont systemFontOfSize:14]

@interface DetailStatusViewController ()
{
//    Order *detailOrder;
//    UIButton *userInfoBtn;
//    UIImageView *iconImageView;
//    UILabel *nickNameLabel;
//    UILabel *memberPointLabel;
//    UILabel *pointValueLabel;
//    UIView *statusInfoView;
//    UILabel *titleLabel;
//    UIImageView *feeImage;
//    UILabel *feeLabel;
//    UILabel *creatTime;
//    UILabel *firstTitleLabel;
//    UILabel *firstInfoLabel;
//    UILabel *secondTitleLabel;
//    UILabel *secondInfoLabel;
//    UILabel *thirdTitleLabel;
//    UILabel *thirdInfoLabel;
//    UILabel *forthTitleLabel;
//    UILabel *forthInfoLabel;
//    UILabel *fifthTitleLabel;
//    UILabel *fifthInfoLabel;
    
    DOrderInfoCell *dOrderInfoCell;
    DOrderStatusCell *dOrderStatusCell;
    Order *detailOrder;
    UserCell *releaserCell;
}
@end

@implementation DetailStatusViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[self addSubViews];
        self.detailStatus = ^(Order *order){
            detailOrder = order;
            
//            NSLog(@"%d---%@--",detailOrder.eventType,detailOrder.orderId);
//            
//            switch (order.eventType) {
//                case HelpClassType:
//                    [self dataWithHelpClass:order.helpClass];
//                    break;
//                    
//                case CampusFoodType:
//                    [self dataWithCampusFood:order.campusFood];
//                    break;
//                    
//                case HelpExpressType:
//                    [self dataWithHelpExpress:order.helpExpress];
//                    break;
//                    
//            }
            
//            if ([obj isKindOfClass:[HelpExpress class]]) {
//                [self dataWithHelpExpress:(HelpExpress *)obj];
//            }
//            if ([obj isKindOfClass:[CampusFood class]]) {
//                [self dataWithCampusFood:(CampusFood *)obj];
//            }
//            if ([obj isKindOfClass:[HelpClass class]]) {
//                [self dataWithHelpClass:(HelpClass *)obj];
//            }
        };

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.view.backgroundColor = kGlobalBg;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = kGlobalBg;
    //self.tableView.backgroundView = nil;
    self.tableView.SectionFooterHeight =0;
    self.tableView.sectionHeaderHeight = 5;
    //self.tableView.contentSize = CGSizeMake(320, 800);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //self.tableView.delaysContentTouches = NO;
    [self.tableView setScrollEnabled:NO];
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
        titlleLabel.text = @"  接单申请者";
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
//    if (detailOrder.orderStatus == 1) {
//        if (detailOrder.acceptUser != nil) {
//            if (detailOrder.acceptUser.count != 0) {
//                return 3;
//            }
//        }else{
//            return 2;
//        }
//        return 2;
//    }else{
        return 2;
    //}
    
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
    
//    if (section == 2) {
//        return detailOrder.acceptUser.count;
//    }else{
        return 1;
   // }
    
    // Return the number of rows in the section.
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"dOrderStatusCell";
        releaserCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
        if (releaserCell == nil) {
            releaserCell = [[UserCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier] ;
            // dOrderStatusCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
//        NSLog(@"rertretregt---%@",detailOrder.acceptUser);
//        if (detailOrder.acceptUser != nil) {
//            releaserCell.user = detailOrder.acceptUser[indexPath.row];
//        }
        releaserCell.refuseBtn.hidden = YES;
        releaserCell.aggreeBtn.hidden = YES;
        switch (detailOrder.eventType) {
            case HelpClassType:
               releaserCell.user = detailOrder.helpClass.user;
                break;
                
            case HelpExpressType:
                releaserCell.user = detailOrder.helpExpress.user;
                break;
                
            case CampusFoodType:
                releaserCell.user = detailOrder.campusFood.user;
                break;
                
        }

        return releaserCell;

        
    }else{
        static NSString *CellIdentifier = @"dOrderInfoCell";
        dOrderInfoCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
        if (dOrderInfoCell == nil) {
            dOrderInfoCell = [[DOrderInfoCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier] ;
        }
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
        dOrderInfoCell.cancelOrderBtn.hidden = YES;
        
       
        UIButton *acceptOrder = [[UIButton alloc]initWithFrame:CGRectMake(230, 70, 50, 50)];
        [acceptOrder setBackgroundImage:[UIImage stretchImageWithName:@"圆按钮红小.png"] forState:UIControlStateNormal];
        
        acceptOrder.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        [acceptOrder setTitle:@"抢" forState:UIControlStateNormal];
        [acceptOrder addTarget:self action:@selector(acceptOrder) forControlEvents:UIControlEventTouchUpInside];
        [dOrderInfoCell.contentView addSubview:acceptOrder];//        if (detailOrder.orderStatus == ConfirmedStatus) {
//            dOrderInfoCell.cancelOrderBtn.hidden = YES;
//            dOrderInfoCell.CompleteOrderBtn.hidden = NO;
//        }
        
        return  dOrderInfoCell;
    }
}
-(void)acceptOrder
{

    
    NSURLRequest *request = [NSURLRequest requestWithPath:kApplyOrdersPath params:@{@"userId": @"1",@"eventType":[NSString stringWithFormat:@"%d",detailOrder.eventType],@"orderId":detailOrder.orderId}];
    NSLog(@"%@",request);

//    
        NSHTTPURLResponse *response = nil;
        NSError *error =nil;
    
        NSData *responeData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
       NSString *responesStr = [[NSString alloc]initWithData:responeData encoding:NSUTF8StringEncoding];
        //NSLog(@"%@----%@",teststr1,teststr);
        NSLog(@"%@",responesStr);
         if ([responesStr isEqualToString:@"success"]) {
        [self.navigationController popViewControllerAnimated:NO];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"presentAcceptVC" object:nil];
        }
    
    
    
}


//-(void)dataWithCampusFood:(CampusFood *)campusFood
//{
//    iconImageView.image = [UIImage imageNamed:campusFood.user.profileImageUrl];
//    nickNameLabel.text = campusFood.user.nickName;
//    feeLabel.text = campusFood.fee;
//    feeImage.image = [UIImage imageNamed:@"feeimage.png"];
//    pointValueLabel.text = @"17";
//    titleLabel.text = @"ssdjflsjk;";
//    firstTitleLabel.text = @"上课时间:";
//    firstInfoLabel.text = campusFood.foodTime;
//    secondTitleLabel.text = @"教室地址:";
//    secondInfoLabel.text = campusFood.messLocation;
//    thirdTitleLabel.text = @"课程名称:";
//    thirdInfoLabel.text = campusFood.foodName;
//    forthInfoLabel.text = campusFood.ownerLocation;
//    forthTitleLabel.text = @"送回地址:";
//    fifthInfoLabel.text = campusFood.note;
//    fifthTitleLabel.text = @"补充说明:";
//    creatTime.text = campusFood.publishTime;
//}
//-(void)dataWithHelpClass:(HelpClass *)helpClass
//{
//    iconImageView.image = [UIImage imageNamed:helpClass.user.profileImageUrl];
//    nickNameLabel.text = helpClass.user.nickName;
//    feeLabel.text = helpClass.fee;
//    feeImage.image = [UIImage imageNamed:@"feeimage.png"];
//    pointValueLabel.text = @"17";
//    titleLabel.text = @"ssdjflsjk;";
//    firstTitleLabel.text = @"上课时间:";
//    firstInfoLabel.text = helpClass.classTime;
//    secondTitleLabel.text = @"教室地址:";
//    secondInfoLabel.text = helpClass.roomLocation;
//    thirdTitleLabel.text = @"课程名称:";
//    thirdInfoLabel.text = helpClass.className;
//    forthTitleLabel.text = @"补充说明:";
//    forthInfoLabel.text = helpClass.note;
//    creatTime.text = helpClass.publishTime;
//}
//-(void)dataWithHelpExpress:(HelpExpress *)helpExpress
//{
//    iconImageView.image = [UIImage imageNamed:helpExpress.user.profileImageUrl];
//    nickNameLabel.text = helpExpress.user.nickName;
//    feeLabel.text = helpExpress.fee;
//    feeImage.image = [UIImage imageNamed:@"feeimage.png"];
//    pointValueLabel.text = @"17";
//    titleLabel.text = @"ssdjflsjk;";
//    firstInfoLabel.text = helpExpress.expressTime;
//    firstTitleLabel.text = @"上课时间:";
//    secondInfoLabel.text = helpExpress.expressLocation;
//    secondTitleLabel.text = @"教室地址:";
//    thirdInfoLabel.text = helpExpress.companyName;
//    thirdTitleLabel.text = @"课程名称:";
//    forthInfoLabel.text = helpExpress.ownerLocation;
//    forthTitleLabel.text = @"送回地址:";
//    fifthInfoLabel.text = helpExpress.note;
//    fifthTitleLabel.text = @"补充说明:";
//    creatTime.text = helpExpress.publishTime;
//}
//
//
//-(void)addSubViews
//{
//    userInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    userInfoBtn.backgroundColor = kGetColor(250, 255, 240);
//    userInfoBtn.frame = CGRectMake(5, 5, 310, 60);
//    [self.view addSubview:userInfoBtn];
//    
//    iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
//    [userInfoBtn addSubview:iconImageView];
//    
//    nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 50, 20)];
//    nickNameLabel.font = kTitleFont;
//    nickNameLabel.backgroundColor = [UIColor clearColor];
//    [userInfoBtn addSubview:nickNameLabel];
//    
//    memberPointLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 40, 60, 15)];
//    memberPointLabel.font = kDetailContentFont;
//    memberPointLabel.backgroundColor = [UIColor clearColor];
//    memberPointLabel.text = @"人品值";
//    [userInfoBtn addSubview:memberPointLabel];
//    
//    pointValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 40, 20, 15)];
//    pointValueLabel.font = kDetailContentFont;
//    pointValueLabel.backgroundColor = [UIColor clearColor];
//    [userInfoBtn addSubview:pointValueLabel];
//    
//    statusInfoView = [[UIView alloc]initWithFrame:CGRectMake(5, 70, 310, 160)];
//    statusInfoView.backgroundColor = kGetColor(250, 255, 240);
//    [self.view addSubview:statusInfoView];
//    
//    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(55, 5, 200, 15)];
//    titleLabel.font = kDetailContentFont;
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.backgroundColor = [UIColor clearColor];
//    [statusInfoView addSubview:titleLabel];
//    
//    feeImage = [[UIImageView alloc]initWithFrame:CGRectMake(155, 25, 30, 20)];
//    [statusInfoView addSubview:feeImage];
//    
//    feeLabel = [[UILabel alloc]initWithFrame:CGRectMake(190, 27, 20, 15)];
//    feeLabel.backgroundColor = [UIColor clearColor ];
//    feeLabel.font = kDetailContentFont;
//    [statusInfoView addSubview:feeLabel];
//    
//    creatTime = [[UILabel alloc]initWithFrame:CGRectMake(240, 25, 60, 20)];
//    creatTime.backgroundColor = [UIColor clearColor];
//    creatTime.font = kTitleFont;
//    [statusInfoView addSubview:creatTime];
//    
//    UIButton *acceptBtn = [UIButton buttonWithType: UIButtonTypeCustom];
//    acceptBtn.frame = CGRectMake(190, 60, 100, 20);
//    acceptBtn.backgroundColor = [UIColor redColor];
//    [acceptBtn setTitle:@"抢单" forState:UIControlStateNormal];
//    [acceptBtn addTarget:self action:@selector(acceptOrder) forControlEvents:UIControlEventTouchUpInside];
//    acceptBtn.titleLabel.font = kDetailContentFont;
//    [statusInfoView addSubview:acceptBtn];
//    
//    firstTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 40, 80, 15)];
//    firstTitleLabel.backgroundColor = [UIColor clearColor];
//    firstTitleLabel.font = kDetailContentFont;
//    [statusInfoView addSubview:firstTitleLabel];
//    
//    firstInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, 80, 15)];
//    firstInfoLabel.backgroundColor = [UIColor clearColor];
//    firstInfoLabel.font = kDetailContentFont;
//    [statusInfoView addSubview:firstInfoLabel];
//    
//    secondTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 60, 80, 15)];
//    secondTitleLabel.backgroundColor = [UIColor clearColor];
//    secondTitleLabel.font = kDetailContentFont;
//    [statusInfoView addSubview:secondTitleLabel];
//    
//    secondInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 60, 80, 15)];
//    secondInfoLabel.backgroundColor = [UIColor clearColor];
//    secondInfoLabel.font = kDetailContentFont;
//    [statusInfoView addSubview:secondInfoLabel];
//    
//    thirdTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 80, 80, 15)];
//    thirdTitleLabel.backgroundColor = [UIColor clearColor];
//    thirdTitleLabel.font = kDetailContentFont;
//    [statusInfoView addSubview:thirdTitleLabel];
//    
//    thirdInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 80, 80, 15)];
//    thirdInfoLabel.backgroundColor = [UIColor clearColor];
//    thirdInfoLabel.font = kDetailContentFont;
//    [statusInfoView addSubview:thirdInfoLabel];
//    
//    forthTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 100, 80, 15)];
//    forthTitleLabel.backgroundColor = [UIColor clearColor];
//    forthTitleLabel.font = kDetailContentFont;
//    [statusInfoView addSubview:forthTitleLabel];
//    
//    forthInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 100, 80, 15)];
//    forthInfoLabel.backgroundColor = [UIColor clearColor];
//    forthInfoLabel.font = kDetailContentFont;
//    [statusInfoView addSubview:forthInfoLabel];
//    
//    fifthTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 120, 80, 15)];
//    fifthTitleLabel.backgroundColor = [UIColor clearColor];
//    fifthTitleLabel.font = kDetailContentFont;
//    [statusInfoView addSubview:fifthTitleLabel];
//    
//    fifthInfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 120, 80, 15)];
//    fifthInfoLabel.backgroundColor = [UIColor clearColor];
//    fifthInfoLabel.font = kDetailContentFont;
//    [statusInfoView addSubview:fifthInfoLabel];
//    
//}
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
