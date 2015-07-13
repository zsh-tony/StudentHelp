//
//  UIButtonCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-29.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "UIButtonCell.h"
#define kBtnHeightMargin 3
#define kTitleHeightMargin 7
#define kWidthMargin 3
#define kTitleWidth 63
#define kIcon 20
#define kTitleHeight 30
#define kContentHeight 40
#define kTextViewFont [UIFont systemFontOfSize:14]
#define kLimitWords 30
@implementation UIButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(kWidthMargin, kTitleHeightMargin+kWidthMargin, kIcon, kIcon)];
        self.iconView.image = [UIImage stretchImageWithName:@"navigationbar_pop_highlighted.png"];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kIcon+2*kWidthMargin, kTitleHeightMargin,kTitleWidth , 30 )];
        //self.titleLabel.text = @"取件时间:";
        //[self.titleLabel sizeToFit];
        self.titleLabel.font = kTextViewFont;
        //self.titleLabel.textColor = [UIColor lightGrayColor];
        //self.textBtn = [[UIButton alloc]initWithFrame:CGRectMake(kIcon+2*kWidthMargin+kTitleWidth+kTitleHeightMargin, kBtnHeightMargin, 320-kIcon-2*kWidthMargin-kTitleWidth-kBtnHeightMargin, kContentHeight)];
        
        self.placeholder = [[UILabel alloc]initWithFrame:CGRectMake(kIcon+2*kWidthMargin+kTitleWidth+kTitleHeightMargin, kBtnHeightMargin, 320-kIcon-2*kWidthMargin-kTitleWidth-kBtnHeightMargin, kContentHeight)];        
        self.placeholder.lineBreakMode = UILineBreakModeWordWrap;
        self.placeholder.numberOfLines = 0;
        self.placeholder.textColor = [UIColor lightGrayColor];
        self.placeholder.font = kTextViewFont;



       
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.placeholder];
           }
    return self;
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
