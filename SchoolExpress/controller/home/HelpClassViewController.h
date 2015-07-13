//
//  HelpClassViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-1.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpClass.h"
@interface HelpClassViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong ) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *messArray;
@property (nonatomic,strong) HelpClass *helpClass;
@end
