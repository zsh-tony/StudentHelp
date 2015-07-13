//
//  UIButtonCell.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-29.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonCell : UITableViewCell

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIButton *textBtn;
@property (nonatomic,strong)UIImageView *bgImageview;
@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong)UILabel *placeholder;
@end
