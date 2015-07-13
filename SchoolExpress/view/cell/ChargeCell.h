//
//  ChargeCell.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-12.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"
@interface ChargeCell : UITableViewCell<QRadioButtonDelegate>
@property (nonatomic,copy)void (^radioTag)(int tag);
@end
