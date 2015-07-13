//
//  ExpressCpyViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-30.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressCpyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) NSMutableDictionary *expresses;

@property (nonatomic, strong) NSMutableArray *keys; //城市首字母
//@property (nonatomic, strong) NSMutableArray *arrayExpresses;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayCommonExpress;
//@property (nonatomic, strong) NSMutableArray *arrayLocationCity;
//@property (nonatomic, strong) NSMutableArray *arrayRecentlyCity;
@property (nonatomic, strong) NSMutableArray *arrayCellHeight;
@property (nonatomic, copy) void (^selectCmpyBlock)(int selectCmpy,NSString *display);
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) NSString *navBarTitle;
@property (nonatomic, strong)UISearchDisplayController *searchController;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) NSMutableArray *allItems;

@end
