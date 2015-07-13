//
//  AccepterCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-5-7.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "UserCell.h"
#define kWidthMargin 10
#define kHeightMargin 10
#define kIconLength 40
#define kNickLabelWidth 60
#define kNickLabelHeight 15
#define kBigFont [UIFont systemFontOfSize:13]
#define kLittleFont [UIFont fontWithName:@"Helvetica-Bold" size:12]
@implementation UserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin, kIconLength, kIconLength)];
        [self.contentView addSubview:_icon];
        
        _nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_icon.frame.origin.x + _icon.frame.size.width +kWidthMargin, kHeightMargin, kNickLabelWidth, kNickLabelHeight)];
        _nickNameLabel.textColor = kGrayTextColor;
        _nickNameLabel.backgroundColor = [UIColor clearColor];
        _nickNameLabel.font = kBigFont;
        [self.contentView addSubview:_nickNameLabel];
        
        _aggreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(170, 12, 60, 30)];
        [_aggreeBtn setTitle:@"同意接单" forState:UIControlStateNormal];
        [_aggreeBtn setBackgroundImage:[UIImage stretchImageWithName:@"方按钮绿小.png"] forState:UIControlStateNormal];
        _aggreeBtn.titleLabel.font = kLittleFont;
        [_aggreeBtn addTarget: self action:@selector(aggreeOrder) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_aggreeBtn];
        
        _refuseBtn = [[UIButton alloc]initWithFrame:CGRectMake(_aggreeBtn.frame.origin.x + _aggreeBtn.frame.size.width+kWidthMargin, _aggreeBtn.frame.origin.y, 60, 30)];
        [_refuseBtn setTitle:@"拒绝接单" forState:UIControlStateNormal];
        [_refuseBtn setBackgroundImage:[UIImage imageNamed:@"common_button_big_red.png"] forState:UIControlStateNormal];
        _refuseBtn.titleLabel.font = kLittleFont;
        [_refuseBtn addTarget: self action:@selector(refuseOrder) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_refuseBtn];
    }
    return self;
}
-(void)aggreeOrder
{
    
    
    if (_presentAggreeOrderVC) {
        _presentAggreeOrderVC();
    }
}
-(void)refuseOrder
{
    if (_presentRefuseOrderVC) {
        _presentRefuseOrderVC();
    }
    
}
- (void)awakeFromNib
{
    // Initialization code
}
-(void)setUser:(User *)user
{
//    _icon.image = [UIImage imageNamed:@"avatar_default_big.png"];
//    _nickNameLabel.text = @"skopk";

    //_icon.image = [UIImage imageNamed:user.profileImageUrl];
    [_icon setImageWithURL:[NSURL URLWithString:user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default_big.png"] options:SDWebImageLowPriority|SDWebImageRetryFailed];

    _nickNameLabel.text = user.nickName;
}
-(void)setOrder:(Order *)order
{
    _order = order;
    if (order.acceptUser != nil) {
        _icon.image = [UIImage imageNamed:@"avatar_default_big.png"];
                _nickNameLabel.text = @"skopk";
    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
