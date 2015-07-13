//
//  messageCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-12.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "SignntureCell.h"

@implementation SignntureCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    [self addSubviews];
    return self;
}

-(void)addSubviews
{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 20)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.text = @"个人留言";
    self.titleLabel.font = kTitleFont;
    [self.contentView addSubview:self.titleLabel];
    
    self.countLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, 50, 40)];
    self.countLabel.backgroundColor = [UIColor clearColor];
    self.countLabel.font = [UIFont systemFontOfSize:25];
    [self.contentView addSubview:self.countLabel ];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(90,10, 60, 60)];
    [self.contentView addSubview:self.iconImageView];
    
    self.summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 10, 140, 30)];
    self.summaryLabel.backgroundColor = [UIColor clearColor];
    self.summaryLabel.font = kDetailContentFont;
    [self.contentView addSubview:self.summaryLabel];
    
    self.creatAtLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 50, 60, 15)];
    self.creatAtLabel.font = kDetailContentFont;
    self.creatAtLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.creatAtLabel];
    
    
}


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
