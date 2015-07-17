//
//  OrderViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-12.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFSegmentView.h"
@interface DetailViewController : UIViewController<RFSegmentViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@end
