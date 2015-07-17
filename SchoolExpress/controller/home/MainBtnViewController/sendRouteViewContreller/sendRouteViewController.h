//
//  sendRouteViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-18.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sendRouteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) void (^ExchangeLoction)(NSIndexPath *indexPath);
@end
