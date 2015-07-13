//
//  MyInfoViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-5-8.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;

@end
