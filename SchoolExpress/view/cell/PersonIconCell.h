//
//  personIconCell.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-11.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonIconCell : UITableViewCell
@property (nonatomic,strong)UIButton *iconImageBtn;
@property (nonatomic,strong)UIButton *nameSexBtn;
@property (nonatomic,strong)UILabel *nameSexLabel;
@property (nonatomic,strong)UILabel *meberPointLabel;
@property (nonatomic,strong)UILabel *pointValueLabel;
@property (nonatomic,strong)UIImageView *authImage;
@property (nonatomic,strong)UILabel *markLabel;
@end
