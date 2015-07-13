//
//  ChargeCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-12.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "ChargeCell.h"

@implementation ChargeCell

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
    QRadioButton *btn1 = [[QRadioButton alloc]initWithDelegate:self groupId:@"groupId1"];
    btn1.frame = CGRectMake(260, 20, 20, 20);
    btn1.tag = 1;
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.contentView addSubview:btn1];
    [btn1 setChecked:YES];
    
    QRadioButton *btn2 = [[QRadioButton alloc]initWithDelegate:self groupId:@"groupId1"];
    btn2.tag = 2;
    btn2.frame = CGRectMake(260, 80, 20, 20);
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.contentView addSubview:btn2];
    
    QRadioButton *btn3 = [[QRadioButton alloc]initWithDelegate:self groupId:@"groupId1"];
    btn3.tag =3;
    btn3.frame = CGRectMake(260, 140, 20, 20);
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn3.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.contentView addSubview:btn3];
    
    UIImageView *icon1 = [[UIImageView alloc]initWithFrame:CGRectMake(25, 10, 40, 40)];
    icon1.image = [UIImage imageNamed:@"avatar_default_big.png"];
    [self.contentView addSubview:icon1];
    
    UIImageView *icon2 = [[UIImageView alloc]initWithFrame:CGRectMake(25, 70, 40, 40)];
    icon2.image = [UIImage imageNamed:@"avatar_default_big.png"];
    [self.contentView addSubview:icon2];
    
    UIImageView *icon3 = [[UIImageView alloc]initWithFrame:CGRectMake(25, 130, 40, 40)];
    icon3.image = [UIImage imageNamed:@"avatar_default_big.png"];
    [self.contentView addSubview:icon3];
    
    
    UIView *seperator1 = [[UIView alloc]initWithFrame:CGRectMake(10, 60, 300, 1)];
    seperator1.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:seperator1];
    
    UIView *seperator2 = [[UIView alloc]initWithFrame:CGRectMake(10, 120, 300, 1)];
    seperator2.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:seperator2];
    
    UILabel *pay1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, 80, 20)];
    pay1.backgroundColor = [UIColor clearColor];
    pay1.font = kDetailContentFont;
    pay1.text = @"支付宝支付";
    [self.contentView addSubview:pay1];
    
    UILabel *pay2 = [[UILabel alloc]initWithFrame:CGRectMake(80, 80, 80, 20)];
    pay2.backgroundColor = [UIColor clearColor];
    pay2.font = kDetailContentFont;
    pay2.text = @"微信支付";
    [self.contentView addSubview:pay2];
    
    
    UILabel *pay3 = [[UILabel alloc]initWithFrame:CGRectMake(80, 140, 80, 20)];
    pay3.backgroundColor = [UIColor clearColor];
    pay3.font = kDetailContentFont;
    pay3.text = @"银联支付";
    [self.contentView addSubview:pay3];
}

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    NSLog(@"did selected radio:%@ groupId:%@", radio.titleLabel.text, groupId);
    if (_radioTag) {
        _radioTag(radio.tag);
    }
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
