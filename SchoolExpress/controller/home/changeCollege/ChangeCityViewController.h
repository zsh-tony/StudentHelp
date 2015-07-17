//
//  ChangeCityViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-15.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeCityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) NSMutableDictionary *cities;

@property (nonatomic, strong) NSMutableArray *keys; //城市首字母
@property (nonatomic, strong) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayHotCity;
@property (nonatomic, strong) NSMutableArray *arrayLocationCity;
@property (nonatomic, strong) NSMutableArray *arrayRecentlyCity;
@property (nonatomic, strong) NSMutableArray *arrayCellHeight;
@property (nonatomic, copy) void (^changeCityBlock)(int changeCity,NSString *display);
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) NSString *navBarTitle;
@property (nonatomic, strong)UISearchDisplayController *searchController;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) NSMutableArray *allItems;

@end
