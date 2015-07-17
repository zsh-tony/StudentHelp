//
//  MyOrderViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-12.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFSegmentView.h"
#import "DZNSegmentedControl.h"
@interface MyOrderViewController : UIViewController<RFSegmentViewDelegate,DZNSegmentedControlDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)DZNSegmentedControl* contentSegmentView;
@property (nonatomic,strong)void (^acceptNotification)();
@end
