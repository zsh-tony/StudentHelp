//
//  personIconCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-11.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "PersonIconCell.h"
#define kTitleFont [UIFont systemFontOfSize:16]
#define kDetailContentFont [UIFont systemFontOfSize:14]
@implementation PersonIconCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews
{
    self.iconImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconImageBtn.frame = CGRectMake(10, 10, 60, 60);
    self.iconImageBtn.backgroundColor = [UIColor clearColor];
//    [self.iconImageBtn addTarget:self action:@selector(addIcon) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.iconImageBtn];
    
    self.nameSexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nameSexBtn.frame = CGRectMake(70, 10, 70, 30);
    self.nameSexBtn.titleLabel.textColor = [UIColor blackColor];
//    [self.nameSexBtn addTarget:self action:@selector(changeNameSex) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.nameSexBtn];
    
    self.nameSexLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 50, 20)];
    self.nameSexLabel.backgroundColor = [UIColor clearColor];
    self.nameSexLabel.font = kTitleFont;
    self.nameSexLabel.textAlignment = NSTextAlignmentCenter;
    [self.nameSexBtn addSubview:self.nameSexLabel];
    
    self.meberPointLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 50, 60, 20)];
    self.meberPointLabel.backgroundColor = [UIColor clearColor];
    self.meberPointLabel.font = kDetailContentFont;
    self.meberPointLabel.text = @"人品币:";
    [self.contentView addSubview:self.meberPointLabel];
    
    self.pointValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 50, 40, 20)];
    self.pointValueLabel.backgroundColor = [UIColor clearColor];
    self.pointValueLabel.font = kDetailContentFont;
    [self.contentView addSubview:self.pointValueLabel];
    
    self.markLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 280, 20)];
    self.markLabel.backgroundColor = [UIColor clearColor];
    self.markLabel.font = kDetailContentFont;
    [self.contentView addSubview:self.markLabel];
    
}
-(void)addIcon
{
    
}

-(void)changeNameSex
{
    
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
