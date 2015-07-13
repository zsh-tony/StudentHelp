//
//  CampusFoodCell.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-11.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampusFoodCell : UITableViewCell
@property (nonatomic,strong)UIView *titleView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *freeImage;
@property (nonatomic,strong)UILabel *freeLabel;
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UILabel *screenNameLabel;
@property (nonatomic,strong)UILabel *creatTimeLabel;
@property (nonatomic,strong)UILabel *foodTimeLabel;
@property (nonatomic,strong)UIImageView *timeImage;
@property (nonatomic,strong)UIImageView *locationImage;
@property (nonatomic,strong)UILabel *messLocationLabel;
@property (nonatomic,strong)UIImageView *ownerImage;
@property (nonatomic,strong)UILabel *ownerLocationLabel;
@property (nonatomic,strong)UIImageView *cpyImage;
@property (nonatomic,strong)UILabel *foodNameLabel;
@property (nonatomic,strong)UIImageView *foodImage;
@property (nonatomic,strong)UILabel *explainLabel;
@property (nonatomic,strong)UIImageView *explainImage;
@property (nonatomic,assign)CGFloat cellHeight;
//@property (nonatomic,strong)Express *express;
@end
