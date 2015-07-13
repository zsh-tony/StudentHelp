//
//  OrderCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-16.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "MyOrderCell.h"
#define kHeightMargin 7
#define kLargeHeightMargin 10
#define kWidthMargin 15
#define kLabelWidth 60
#define kContentWidth 100
#define kHeightFont 15
#define kImageFloat 50
#define kIndictorWidth 10
#define kIndictorHeight 10
@implementation MyOrderCell

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
    UIImageView *indictor = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width - kWidthMargin-kIndictorWidth, 60, kIndictorWidth,kIndictorHeight)];
    indictor.image = [UIImage imageNamed:@"rightArrow.png"];
    [self.contentView addSubview:indictor];

    self.publishTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin, kLabelWidth, kHeightFont)];
    self.publishTimeLabel.font = kDetailContentFont;
    self.publishTimeLabel.textColor = [UIColor lightGrayColor];
    self.publishTimeLabel.text = @"下单时间";
    [self.contentView addSubview:self.publishTimeLabel];
    
    self.publishTime = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin*2+kLabelWidth, kHeightMargin, 150, kHeightFont)];
    self.publishTime.font = kDetailContentFont;
    self.publishTime.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.publishTime];
    
    UIView *sepearator = [[UIView alloc]initWithFrame:CGRectMake(kWidthMargin, self.publishTime.frame.origin.y + self.publishTime.frame.size.height + kHeightMargin, 320 - kWidthMargin*2, 0.5)];
    sepearator.alpha = 0.3;
    sepearator.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:sepearator];
    
    self.eventImage = [[UIImageView alloc]initWithFrame:CGRectMake(kWidthMargin, self.publishTimeLabel.frame.origin.y+self.publishTimeLabel.frame.size.height+kLargeHeightMargin*2, kImageFloat, kImageFloat)];
    [self.contentView addSubview:self.eventImage];
    
    
    self.eventTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin*2+kImageFloat, self.publishTimeLabel.frame.origin.y+self.publishTimeLabel.frame.size.height+kHeightMargin+kLargeHeightMargin, kLabelWidth, kHeightFont)];
    self.eventTypeLabel.font = kDetailContentFont;
    self.eventTypeLabel.text = @"订单主题";
    self.eventTypeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.eventTypeLabel];
    
    self.eventType = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin*3 + kImageFloat+kLabelWidth, self.publishTimeLabel.frame.origin.y+self.publishTimeLabel.frame.size.height+kHeightMargin+kLargeHeightMargin, kContentWidth, kHeightFont)];
    self.eventType.font = kDetailContentFont;
    self.eventType.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.eventType];
    
    self.feeLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin*2 + kImageFloat, self.eventType.frame.origin.y + self.eventType.frame.size.height+kHeightMargin, kLabelWidth, kHeightFont)];
    self.feeLabel.font = kDetailContentFont;
    self.feeLabel.text = @"订单金额";
    self.feeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.feeLabel];
    
    self.fee = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin*3 + kImageFloat + kLabelWidth, self.feeLabel.frame.origin.y, kContentWidth, kHeightFont)];
    self.fee.font = kDetailContentFont;
    self.fee.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.fee];
    
    self.orderStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin*2 + kImageFloat, self.fee.frame.origin.y + self.fee.frame.size.height + kHeightMargin, kLabelWidth, kHeightFont)];
    self.orderStatusLabel.font = kDetailContentFont;
    self.orderStatusLabel.text = @"订单状态";
    self.orderStatusLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.orderStatusLabel];
    
    self.orderStatusL = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin*3 + kImageFloat + kLabelWidth, self.orderStatusLabel.frame.origin.y, kContentWidth, kHeightFont)];
    self.orderStatusL.font = kDetailContentFont;
    self.orderStatusL.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.orderStatusL];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
-(void)setOrder:(Order *)order
{
    _order = order;
    //self.publishTime.text = baseOrder.publishTime;
    //self.eventType.text = order.eventType;
    //self.fee.text = baseOrder.fee;
    switch (order.eventType) {
        case HelpClassType:
            self.publishTime.text = order.helpClass.publishTime;
            self.eventType.text = @"替上课";
            self.fee.text = order.helpClass.fee;
        
            [self.eventImage setImageWithURL:[NSURL URLWithString:order.helpClass.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default_big.png"] options:SDWebImageLowPriority|SDWebImageRetryFailed];

            break;
            
        case CampusFoodType:
            self.publishTime.text = order.campusFood.publishTime;
            self.eventType.text = @"食堂带饭";
            self.fee.text = order.campusFood.fee;
            [self.eventImage setImageWithURL:[NSURL URLWithString:order.campusFood.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default_big.png"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
        break;
            
        case OuterFoodType:
            self.publishTime.text = order.outerFood.publishTime;
            self.eventType.text = @"校外带饭";
            self.fee.text = order.outerFood.fee;
            [self.eventImage setImageWithURL:[NSURL URLWithString:order.outerFood.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default_big.png"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
            break;
            
        case HelpExpressType:
            self.publishTime.text = order.helpExpress.publishTime;
            self.eventType.text = @"取快递";
            self.fee.text = order.helpExpress.fee;
            [self.eventImage setImageWithURL:[NSURL URLWithString:order.helpExpress.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default_big.png"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
            break;
    }
    
    switch (order.orderStatus) {
     
            
        case ReleasedStatus:
            self.orderStatusL.text = @"已发布";
            break;
            
        case AppliedStatus:
            self.orderStatusL.text = @"已申请接单";
            break;
            
        case ConfirmedStatus:
            self.orderStatusL.text = @"确认申请";
            break;
            
        case CompletedStatus:
            self.orderStatusL.text = @"已完成";
            break;
   
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
