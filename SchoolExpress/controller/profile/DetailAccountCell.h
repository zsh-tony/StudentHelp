//
//  DetailAccountCell.h
//  SchoolExpress
//
//  Created by lerrruby on 15/5/17.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailAccountCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UILabel *dayLabel;
@property (nonatomic,strong)UILabel *weekdayLabel;
@property (nonatomic,strong)UITableView *dayTableView;
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,copy)void (^setDayTableView)(CGFloat tableViewHeight,NSArray *incomePayArray);
@property (nonatomic,strong)NSArray *dataArray;
@end
