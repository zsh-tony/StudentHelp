//
//  CampusFoodCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-11.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "CampusFoodCell.h"

#define kTitleFont [UIFont systemFontOfSize:18]
#define kExpressContentFont [UIFont systemFontOfSize:15]

@implementation CampusFoodCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)addSubViews
{
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    _titleView.backgroundColor = kGetColor(240, 230, 140);
    [self.contentView addSubview:_titleView];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 200, 31)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.text = @"谁来帮我从食堂带饭回来";
    _titleLabel.font = kTitleFont;
    _titleLabel.textColor = [UIColor whiteColor];
    [_titleView addSubview:_titleLabel];
    
    _freeImage = [[UIImageView alloc]initWithFrame:CGRectMake(240, 2, 20, 30)];
    _freeImage.image = [UIImage imageNamed:@"freeimage.png"];
    [_titleView addSubview:_freeImage];
    
    _freeLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 2, 30, 30)];
    _freeLabel.textColor = [UIColor whiteColor];
    _freeLabel.backgroundColor = [UIColor clearColor];
    _freeLabel.font = kTitleFont;
    [_titleView addSubview:_freeLabel];
    
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(5, 55, 50, 50)];
    [self.contentView addSubview:_icon];
    
    _screenNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 35, 60, 15)];
    _screenNameLabel.backgroundColor = [UIColor clearColor];
    _screenNameLabel.textColor = [UIColor blackColor];
    _screenNameLabel.font = kExpressContentFont;
    [self.contentView addSubview:_screenNameLabel];
    
    _creatTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 52, 60, 12)];
    _creatTimeLabel.backgroundColor = [UIColor clearColor];
    _creatTimeLabel.textColor = [UIColor lightGrayColor];
    _creatTimeLabel.font = kExpressContentFont;
    [self.contentView addSubview:_creatTimeLabel];
    
    _explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 70, 100, 15)];
    _explainLabel.backgroundColor = [UIColor clearColor];
    _explainLabel.font = kExpressContentFont;
    [self.contentView addSubview:_explainLabel];
    
    _explainImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 70, 15, 15)];
    _explainImage.image = [UIImage imageNamed:@"delivery.png"];
    [self.contentView addSubview:_explainImage];
    
    _timeImage = [[UIImageView alloc]initWithFrame:CGRectMake(200, 35, 15, 15)];
    _timeImage.image = [UIImage imageNamed:@"timeImage"];
    [self.contentView addSubview:_timeImage];
    
    _foodTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(218, 35, 100, 15)];
    _foodTimeLabel.backgroundColor = [UIColor clearColor];
    _foodTimeLabel.font = kExpressContentFont;
    [self.contentView addSubview:_foodTimeLabel];
    
    _locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(200, 55, 15, 15)];
    _locationImage.image = [UIImage imageNamed:@"location.png"];
    [self.contentView addSubview:_locationImage];
    
    _messLocationLabel = [[UILabel alloc]initWithFrame:CGRectMake(218, 55, 100, 15)];
    _messLocationLabel.font = kExpressContentFont;
    _messLocationLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_messLocationLabel];
    
    _cpyImage = [[UIImageView alloc]initWithFrame:CGRectMake(200, 75, 15, 15)];
    _cpyImage.image = [UIImage imageNamed:@"cpyimage.png"];
    [self.contentView addSubview:_cpyImage];
    
    _foodNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(218, 75, 100, 15)];
    _foodNameLabel.backgroundColor = [UIColor clearColor];
    _foodNameLabel.font = kExpressContentFont;
    [self.contentView addSubview:_foodNameLabel];
    
    
    _ownerImage = [[UIImageView alloc]initWithFrame:CGRectMake(200, 95, 15, 15)];
    _ownerImage.image = [UIImage imageNamed:@"location.png"];
    [self.contentView addSubview:_ownerImage];
    
    
    _ownerLocationLabel = [[UILabel alloc]initWithFrame:CGRectMake(218, 95, 100, 15)];
    _ownerLocationLabel.backgroundColor = [UIColor clearColor];
    _ownerLocationLabel.font = kExpressContentFont;
    [self.contentView addSubview:_ownerLocationLabel];
    
    
    
}
//-(void)setExpress:(Express *)express
//{
//    _express = express;
//    _icon.image = [UIImage imageNamed:express.user.profileImageUrl];
//    _freeLabel.text = [NSString stringWithFormat:@"%d",express.free];
//    _screenNameLabel.text = express.user.screenName;
//    _creatTimeLabel.text = express.createdAt;
//    _expressTimeLabel.text = express.expressTime;
//    _expressLocationLabel.text = express.expressLocation;
//    _expressCpyLabel.text = express.expressCpy;
//    _explainLabel.text = express.explain;
//    _ownerLocationLabel.text = express.ownerLocation;
//    
//    
//}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
