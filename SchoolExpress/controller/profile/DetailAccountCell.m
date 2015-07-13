//
//  DetailAccountCell.m
//  SchoolExpress
//
//  Created by lerrruby on 15/5/17.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "DetailAccountCell.h"
#import "Order.h"
#import "AccessoryView.h"
@implementation DetailAccountCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      
        _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 30, 20)];
        //_dayLabel.text = @"sdfs";
        _dayLabel.backgroundColor =  [UIColor clearColor];
        _dayLabel.font = [UIFont systemFontOfSize:18];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.textColor = kGetColor(121, 123, 126);
        [self.contentView addSubview:_dayLabel];
        
        _weekdayLabel = [[UILabel alloc]initWithFrame:CGRectMake(_dayLabel.frame.origin.x, _dayLabel.frame.size.height + _dayLabel.frame.origin.y , _dayLabel.frame.size.width, 10)];
        //_dayLabel.text = @"sdfs";
        _weekdayLabel.backgroundColor =  [UIColor clearColor];
        _weekdayLabel.font = [UIFont systemFontOfSize:11];
        _weekdayLabel.textAlignment = NSTextAlignmentCenter;
        _weekdayLabel.textColor = kGetColor(128, 130, 133);
        [self.contentView addSubview:_weekdayLabel];
        
        _setDayTableView = ^(CGFloat tableViewHeight,NSArray *incomePayArray){
            _dayTableView = [[UITableView alloc]initWithFrame:CGRectMake(40, 0, 270, tableViewHeight)style:UITableViewStylePlain];
            [_dayTableView setScrollEnabled:NO];
            _dayTableView.delegate = self;
            _dayTableView.dataSource = self;
            _dayTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            _dataArray = incomePayArray;
            [self.contentView addSubview:_dayTableView];
//            UIView *widthSeperator = [[UIView alloc]initWithFrame:CGRectMake(-60, tableViewHeight-1, 70, 1)];
//            
//            widthSeperator.backgroundColor = kGetColor(227, 227, 229);
//            [self.dayTableView addSubview:widthSeperator];
            
            UIView *heightSeperator = [[UIView alloc]initWithFrame:CGRectMake(10, 0, 1, tableViewHeight)];
            heightSeperator.backgroundColor = kGetColor(227, 227, 229);
            [self.dayTableView addSubview:heightSeperator];
        };
        
      
        self.backgroundColor = kGetColor(245, 245, 245);
        
    }
    return self;
}

#pragma mark - 数据源、代理方法
#pragma mark 有多少组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

        return 1;
    
    
}

#pragma mark 每一组中有多少行数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return _dataArray.count;
        
        
    
    
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
            static NSString *ID2 = @"dayCell";
        
        // 1.拿到一个标识先去缓存池中查找对应的Cell
        UITableViewCell  *dayCell = [tableView dequeueReusableCellWithIdentifier:ID2];
        
        // 2.如果缓存池中没有，才需要传入一个标识创建新的Cell
        if (dayCell == nil) {
            dayCell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:ID2] ;
        }
//    UITableViewCell *dayCell = [[UITableViewCell alloc]init];
        dayCell.backgroundColor = kGetColor(245, 245, 245);
    dayCell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        NSDictionary *group = self.allFriends[indexPath.section];
        //        // 2.获取这组里面的好友
        //        NSArray *friends = group[@"friends"];
        //
        //        NSDictionary *group1 = friends[indexPath.section];
        //        // 2.获取这组里面的好友
        //        NSArray *friends1 = group1[@"我"];
    AccessoryView *accessoryView = [[AccessoryView alloc]init];
    
    
    
    dayCell.textLabel.textColor = kGetColor(59, 56, 56);
    dayCell.textLabel.font = k13BordFont;
        NSDictionary *incomePayDict = _dataArray[indexPath.row];
    NSLog(@"%@",incomePayDict);
    EventType eventType = [incomePayDict[@"eventType"] intValue];
    int incomePay = [incomePayDict[@"incomePay"]intValue];
    NSLog(@"%d",incomePay);
    if (incomePay <0) {
        accessoryView.incomePayLabel.textColor = kGetColor(42, 143, 105);
    }else{
        accessoryView.incomePayLabel.textColor = kGetColor(215, 57, 57);
    }
    accessoryView.incomePayLabel.text =  incomePayDict[@"incomePay"];
    UIImage *icon = [[UIImage alloc]init];
   
    
    dayCell.accessoryView = accessoryView;
    switch (eventType) {
        case CampusFoodType:
             icon = [UIImage imageNamed:@"食堂带饭.png"];
            //dayCell.imageView.image = [UIImage imageNamed:@"食堂带饭.png"];
            dayCell.textLabel.text = @"食堂带饭";
           
            break;
            
        case HelpClassType:
            dayCell.textLabel.text = @"替上课";
            icon = [UIImage imageNamed:@"替上课.png"];
             //dayCell.imageView.image = [UIImage imageNamed:@"替上课.png"];
            break;
            
        case HelpExpressType:
            dayCell.textLabel.text = @"取快递";
           icon = [UIImage imageNamed:@"取快递.png"];
             //dayCell.imageView.image = [UIImage imageNamed:@"取快递.png"];
            break;
            
        case OuterFoodType:
            dayCell.textLabel.text = @"校外带饭";
            icon = [UIImage imageNamed:@"校外带饭.png"];
             //dayCell.imageView.image = [UIImage imageNamed:@"校外带饭.png"];
            break;
          
    }
    CGSize itemSize = CGSizeMake(30, 30);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    
    dayCell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
        return dayCell;
    
    
}

#pragma mark 每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
           return 44;
    
    
    
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
