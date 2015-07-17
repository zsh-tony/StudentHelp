//
//  CampusFoodViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-29.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CampusFood;

@interface CampusFoodViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic,strong) UIPickerView *pickView;
@property (nonatomic,strong ) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *messArray;
@property (nonatomic,strong) CampusFood *campusFood;
@end
