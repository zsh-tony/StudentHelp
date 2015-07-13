//
//  ExchangeLocationCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-19.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "ExchangeLocationCell.h"

@implementation ExchangeLocationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.fromLocation = [[UILabel alloc]init];
        self.fromLocation.frame = CGRectMake(15, 10, 60, 30);
        self.fromLocation.font = [UIFont systemFontOfSize:15];
        self.fromLocation.text = @"出发地:";
        [self.contentView addSubview:self.fromLocation];
        
        self.toLocation = [[UILabel alloc]init];
        self.toLocation.frame = CGRectMake(15, 54, 60, 30);
        self.toLocation.font = [UIFont systemFontOfSize:15];
        self.toLocation.text = @"目的地:";
        [self.contentView addSubview:self.toLocation];
        
        self.seperatorView = [[UIView alloc]initWithFrame:CGRectMake(15, 44, 230, 0.5)];
        self.seperatorView.alpha = 0.3;
        self.seperatorView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.seperatorView];
        
        self.exchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.exchangeBtn setBackgroundImage:[UIImage imageNamed:@"arrow_up-down_alt.png"] forState:UIControlStateNormal];
        //[self.exchangeBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.exchangeBtn.frame =CGRectMake(260, 22, 40, 40);
        [self.exchangeBtn addTarget:self action:@selector(exchange) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.exchangeBtn];
        
        self.fromBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.fromBtn.frame = CGRectMake(80, 2, 165, 40);
        [self.fromBtn setTitle:@"" forState:UIControlStateNormal];
        [self.fromBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.fromBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.fromBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.fromBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 0, 0, 0);
        [self.fromBtn addTarget:self action:@selector(detailLocation:) forControlEvents:UIControlEventTouchUpInside];
        self.fromBtn.tag = 1;
        [self.contentView addSubview:self.fromBtn];
        
        self.toBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.toBtn.frame = CGRectMake(80, 46, 165, 40);
        [self.toBtn setTitle:@"" forState:UIControlStateNormal];
        [self.toBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.toBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.toBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.toBtn.contentEdgeInsets = UIEdgeInsetsMake(6, 0, 0, 0);
        self.toBtn.tag = 2;
        [self.toBtn addTarget:self action:@selector(detailLocation:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.toBtn];
        
    }
    return self;
}
-(void)detailLocation:(UIButton *)sender
{
    if (_pushInputVC) {
        _pushInputVC(sender.tag);
    }
    
    
}
-(void)exchange
{
    NSString *tmpstr1 = self.fromBtn.currentTitle;
    NSString *tmpstr2 = self.toBtn.currentTitle;
    [self.fromBtn setTitle:tmpstr2 forState:UIControlStateNormal];
    [self.toBtn setTitle:tmpstr1 forState:UIControlStateNormal];
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
- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    // 即使触摸到的是一个 UIControl (如子类：UIButton), 我们也希望拖动时能取消掉动作以便响应滚动动作
    return YES;
}
@end
