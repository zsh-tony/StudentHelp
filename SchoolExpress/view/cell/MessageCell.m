//
//  MessageCell.m
//  SchoolExpress
//
//  Created by lerrruby on 15/5/20.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "MessageCell.h"
#define kWidthMargin 10 
#define kHeightMargin 15
#define kIconLength 50
#define kTimeLabelWidth 100
@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.messageTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width-kTimeLabelWidth - kWidthMargin, kHeightMargin + 3, kTimeLabelWidth, kHeightMargin)];
        self.messageTimeLabel.textColor = kTitleColor;
        self.messageTimeLabel.font = k13Font;
        self.messageTimeLabel.textAlignment = NSTextAlignmentRight;
        self.messageTimeLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.messageTimeLabel];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
  
    [self.imageView setFrame:CGRectMake(kWidthMargin, kHeightMargin, kIconLength, kIconLength)];
    [self.textLabel setFrame:CGRectMake(70, self.imageView.frame.origin.y+7, 100,kHeightMargin)];
    [self.detailTextLabel setFrame:CGRectMake(self.textLabel.frame.origin.x,self.textLabel.frame.origin.y + self.textLabel.frame.size.height + kWidthMargin, 235,kHeightMargin)];
    self.textLabel.font = k17Font;
    self.detailTextLabel.font = k15Font;
    self.detailTextLabel.textColor = kTitleColor;
    //[UIScreen mainScreen].applicationFrame.size.width-kTimeLabelWidth - kWidthMargin
    
    
    UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-0.5, [UIScreen mainScreen].applicationFrame.size.width, 0.5)];
    seperator.backgroundColor = kGetColor(215, 215, 215);
    [self.contentView addSubview:seperator];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
