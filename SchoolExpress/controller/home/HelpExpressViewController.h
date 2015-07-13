//
//  HelpExpressViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-26.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpExpress.h"
@interface HelpExpressViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)HelpExpress *helpExpress;
@end
