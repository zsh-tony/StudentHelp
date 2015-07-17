//
//  DetailStatusViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-11.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface DetailStatusViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy)void (^detailStatus)(Order *order);
@property (nonatomic,strong)UITableView *tableView;
@end
