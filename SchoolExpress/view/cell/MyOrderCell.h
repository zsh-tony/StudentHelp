//
//  OrderCell.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-16.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface MyOrderCell : UITableViewCell
@property(nonatomic,strong)UIImageView *eventImage;
@property(nonatomic,strong)UILabel *publishTimeLabel;
@property(nonatomic,strong)UILabel *eventTypeLabel;
@property(nonatomic,strong)UILabel *feeLabel;
@property(nonatomic,strong)UILabel *orderStatusLabel;
@property(nonatomic,strong)UILabel *publishTime;
@property(nonatomic,strong)UILabel *eventType;
@property(nonatomic,strong)UILabel *fee;
@property(nonatomic,strong)UILabel *orderStatusL;
@property(nonatomic,strong)Order *order;
@end
