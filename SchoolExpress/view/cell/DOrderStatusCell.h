//
//  DOrderStatusCell.h
//  SchoolExpress
//
//  Created by zsh tony on 15-5-6.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface DOrderStatusCell : UITableViewCell
@property (nonatomic,strong)UILabel *orderIdTitle;
@property (nonatomic,strong)UILabel *orderIdText;
@property (nonatomic,strong)UIImageView *orderStatusImage;
@property (nonatomic,strong)Order *order;
@end
