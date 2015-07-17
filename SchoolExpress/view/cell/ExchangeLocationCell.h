//
//  ExchangeLocationCell.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-19.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeLocationCell : UITableViewCell
@property (nonatomic,strong)UILabel *fromLocation;
@property (nonatomic,strong)UILabel *toLocation;
@property (nonatomic,strong)UIButton *exchangeBtn;
@property (nonatomic,strong)UIView *seperatorView;
@property (nonatomic,strong)UIButton *fromBtn;
@property (nonatomic,strong)UIButton *toBtn;
@property (nonatomic,copy)void (^pushInputVC)(int tag);
@end
