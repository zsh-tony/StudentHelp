//
//  AccepterCell.h
//  SchoolExpress
//
//  Created by zsh tony on 15-5-7.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface UserCell : UITableViewCell
@property (nonatomic,strong)Order *order;
@property (nonatomic,strong)User *user;
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UILabel *nickNameLabel;
@property (nonatomic,strong)UIButton *aggreeBtn;
@property (nonatomic,strong)UIButton *refuseBtn;
@property (nonatomic,strong)void (^presentAggreeOrderVC)();
@property (nonatomic,strong)void (^presentRefuseOrderVC)();
@property (nonatomic,assign)int tag;
@end
