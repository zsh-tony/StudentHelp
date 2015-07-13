//
//  DiscoverViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-10.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZNSegmentedControl.h"
#import "VOSegmentedControl.h"
@interface DiscoverViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
//@property (nonatomic,strong)DZNSegmentedControl* contentSegmentView;
@property (nonatomic,strong)VOSegmentedControl *contentSegmentView;
@property (nonatomic,copy)void (^changeToProfileVC)(void);
@end
