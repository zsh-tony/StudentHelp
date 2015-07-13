//
//  MyDetailOrderViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-5-3.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface MyDetailOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy)void (^detailStatus)(Order *order,OrderTotalType orderTotalType);
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)void (^presentCancelVC)();
@end
