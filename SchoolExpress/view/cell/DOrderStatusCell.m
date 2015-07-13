//
//  DOrderStatusCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-5-6.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "DOrderStatusCell.h"
#define kWidthMargin 10
#define kHeightMargin 10
#define kTitleWidth 70
#define kTitleHeight 15
#define kTextWidth 80
#define kImageHeight 64
#define kLittleFont [UIFont systemFontOfSize:13]
@implementation DOrderStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _orderIdTitle = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin, kTitleWidth, kTitleHeight)];
        _orderIdTitle.backgroundColor = [UIColor clearColor];
        _orderIdTitle.text =@"订单编号";
        _orderIdTitle.textColor = kTitleColor;
        _orderIdTitle.font = kLittleFont;
        [self.contentView addSubview:_orderIdTitle];
        
        _orderIdText = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin+ _orderIdTitle.frame.origin.x + _orderIdTitle.frame.size.width, kHeightMargin, kTextWidth, kTitleHeight)];
        _orderIdText.backgroundColor = [UIColor clearColor];
        //_orderIdTitle.text =@"订单编号";
        _orderIdText.textColor = kTextColor;
        _orderIdText.font = kLittleFont;
        [self.contentView addSubview:_orderIdText];
        
         CGRect frame = [UIScreen mainScreen].applicationFrame;
        
        UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(kWidthMargin, _orderIdTitle.frame.origin.y +_orderIdTitle.frame.size.height+kHeightMargin, frame.size.width - 2*kWidthMargin , 1 )];
        seperator.backgroundColor = kSeperatorColor;
        [self.contentView addSubview:seperator];
        
       
        
        _orderStatusImage = [[UIImageView alloc]initWithFrame:CGRectMake(kWidthMargin, _orderIdTitle.frame.origin.y+_orderIdTitle.frame.size.height +kHeightMargin, frame.size.width - 2*kWidthMargin  ,kImageHeight)];
        //_orderStatusImage.image = [UIImage imageNamed:@"test.png"];
        [self.contentView addSubview:_orderStatusImage];
        
        
    }
    return self;
}
-(void)setOrder:(Order *)order
{
    if (order.orderTotalType == OrderReleaseType) {
        switch (order.orderStatus) {
            case ReleasedStatus:
                _orderStatusImage.image = [UIImage imageNamed:@"已发布.png"];
                break;
                
            case AppliedStatus:
                _orderStatusImage.image = [UIImage imageNamed:@"已申请.png"];
                break;
                
            case ConfirmedStatus:
                _orderStatusImage.image = [UIImage imageNamed:@"已确认.png"];
                break;
                
            case CompletedStatus:
                _orderStatusImage.image = [UIImage imageNamed:@"已完成.png"];
                break;
                
        }

    }else{
        
        switch (order.orderStatus) {
                
            case AppliedStatus:
                _orderStatusImage.image = [UIImage imageNamed:@"已申请2.png"];
                break;
                
            case ConfirmedStatus:
                _orderStatusImage.image = [UIImage imageNamed:@"已确认2.png"];
                break;
                
            case CompletedStatus:
                _orderStatusImage.image = [UIImage imageNamed:@"已完成2.png"];
                break;
                
        }

        
        
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
