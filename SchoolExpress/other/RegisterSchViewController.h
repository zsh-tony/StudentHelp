//
//  RegisterSchViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-5-9.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterSchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, copy) void (^passUserId)(NSString *userId);
@end
