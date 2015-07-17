//
//  ChangeSchViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-15.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeSchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) void (^changeCollegeBlock)(int changeCollege,NSString *display);
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong)UISearchDisplayController *searchController;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) NSArray *allItems;
@property (nonatomic, strong) NSString *navBarTitle;

@end
