//
//  OwnerLocaViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-1.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnerLocaViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,copy)void (^selectOwnerLoca) (NSString *display);


@end
