
//
//  DOrderInfoCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-5-6.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "DOrderInfoCell.h"

#define kWidthMargin 10
#define kHeightMargin 10
#define kLittleHeightMargin 7
#define kLittleMargin 4
#define kTitleWidth 70
#define kTitleHeight 15
#define kTextWidth 80
#define kImageHeight 50
#define kContentWidth 60
#define kContentHeight 15
#define kPTimeWidth 50
#define kPTimeHeight 15
#define kFeeIconLength 15
#define kFeeTextWidth 30
#define kFeeTextHeight 10
#define kFeeX 180
#define kFeeY 60
#define kBigFont [UIFont systemFontOfSize:13]
//#define kLittleFont [UIFont fontWithName:@"Helvetica-Bold" size:12]
#define kLittleFont [UIFont systemFontOfSize:13]
@implementation DOrderInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _orderIdTitle = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin, kTitleWidth, kTitleHeight)];
        _orderIdTitle.backgroundColor = [UIColor clearColor];
        _orderIdTitle.text =@"订单信息";
        _orderIdTitle.textColor = kTitleColor;
        _orderIdTitle.font = kLittleFont;
        [self.contentView addSubview:_orderIdTitle];

        CGRect frame = [UIScreen mainScreen].applicationFrame;
        
        UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(kWidthMargin, _orderIdTitle.frame.origin.y +_orderIdTitle.frame.size.height+kHeightMargin, frame.size.width - 2*kWidthMargin , 1 )];
        seperator.backgroundColor = kSeperatorColor;
        [self.contentView addSubview:seperator];
        
        _firstLineTitle = [[UILabel alloc]initWithFrame:CGRectMake(kWidthMargin,seperator.frame.origin.y + kHeightMargin, kContentWidth, kContentHeight)];
        _firstLineTitle.backgroundColor = [UIColor clearColor];
        _firstLineTitle.textColor = kGrayTextColor;
        _firstLineTitle.font = kLittleFont;
        [self.contentView addSubview:_firstLineTitle];
        
        _firstLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(_firstLineTitle.frame.origin.x +_firstLineTitle.frame.size.width +kLittleMargin, _firstLineTitle.frame.origin.y, kContentWidth, kContentHeight)];
        _firstLineLabel.backgroundColor = [UIColor clearColor];
        _firstLineLabel.textColor = kGrayTextColor;
        _firstLineLabel.font = kLittleFont;
        [self.contentView addSubview:_firstLineLabel];
        
        _secondLineTitle = [[UILabel alloc]initWithFrame:CGRectMake(_firstLineTitle.frame.origin.x, _firstLineTitle.frame.origin.y + _firstLineTitle.frame.size.height + kLittleHeightMargin, kContentWidth, kContentHeight)];
        _secondLineTitle.backgroundColor = [UIColor clearColor];
        _secondLineTitle.textColor = kGrayTextColor;
        _secondLineTitle.font = kLittleFont;
        [self.contentView addSubview:_secondLineTitle];
        
        
        _secondLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(_firstLineLabel.frame.origin.x, _secondLineTitle.frame.origin.y, kContentWidth, kContentHeight)];
        _secondLineLabel.font = kLittleFont;
        _secondLineLabel.backgroundColor = [UIColor clearColor];
        _secondLineLabel.textColor = kGrayTextColor;
        [self.contentView addSubview:_secondLineLabel];
        
        _thirdLineTitle = [[UILabel alloc]initWithFrame:CGRectMake(_secondLineTitle.frame.origin.x, _secondLineTitle.frame.origin.y + _secondLineTitle.frame.size.height + kLittleHeightMargin, kContentWidth, kContentHeight)];
        _thirdLineTitle.backgroundColor = [UIColor clearColor];
        _thirdLineTitle.textColor = kGrayTextColor;
        _thirdLineTitle.font = kLittleFont;
        [self.contentView addSubview:_thirdLineTitle];
        
        _thirdLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(_secondLineLabel.frame.origin.x, _thirdLineTitle.frame.origin.y, kContentWidth, kContentHeight)];
        _thirdLineLabel.backgroundColor = [UIColor clearColor];
        _thirdLineLabel.textColor = kGrayTextColor;
        _thirdLineLabel.font = kLittleFont;
        [self.contentView addSubview:_thirdLineLabel];
        
        
        _forthLineTitle = [[UILabel alloc]initWithFrame:CGRectMake(_thirdLineTitle.frame.origin.x, _thirdLineTitle.frame.size.height + _thirdLineTitle.frame.origin.y+kLittleHeightMargin, kContentWidth, kContentHeight)];
        _forthLineTitle.backgroundColor = [UIColor clearColor];
        _forthLineTitle.textColor = kGrayTextColor;
        _forthLineTitle.font = kLittleFont;
        [self.contentView addSubview:_forthLineTitle];
        
        
        _forthLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(_thirdLineLabel.frame.origin.x, _forthLineTitle.frame.origin.y, kContentWidth, kContentHeight)];
        _forthLineLabel.backgroundColor = [UIColor clearColor];
        _forthLineLabel.textColor = kGrayTextColor;
        _forthLineLabel.font = kLittleFont;
        [self.contentView addSubview:_forthLineLabel];
        
//        _PTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(180 , 60, kPTimeWidth, kPTimeHeight)];
//        _PTimeLabel.backgroundColor = [UIColor clearColor];
//        _PTimeLabel.textColor = kGrayTextColor;
//        _PTimeLabel.font = kBigFont;
//        [self.contentView addSubview:_PTimeLabel];
        
        
        _feeImage = [[UIImageView alloc]initWithFrame:CGRectMake(kFeeX,kFeeY,  kFeeIconLength, kFeeIconLength)];
        _feeImage.image = [UIImage imageNamed:@"feeImage.png"];
        [self.contentView addSubview:_feeImage];
        
        _feeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_feeImage.frame.origin.x +_feeImage.frame.size.width , _feeImage.frame.origin.y+2, kFeeTextWidth, kFeeTextHeight)];
        _feeLabel.textColor = kGrayTextColor;
        _feeLabel.backgroundColor = [UIColor clearColor];
        _feeLabel.font = kBigFont;
        [self.contentView addSubview:_feeLabel];
      
        _cancelOrderBtn = [[UIButton alloc]initWithFrame:CGRectMake(190, 90, 90, 30)];
        [_cancelOrderBtn setBackgroundImage:[UIImage stretchImageWithName:@"common_button_big_red.png"] forState:UIControlStateNormal];
        _cancelOrderBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [_cancelOrderBtn setTitle:@"取消求助" forState:UIControlStateNormal];
        [_cancelOrderBtn addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_cancelOrderBtn];
        
        _CompleteOrderBtn = [[UIButton alloc]initWithFrame:CGRectMake(190, 90, 90, 30)];
        [_CompleteOrderBtn setBackgroundImage:[UIImage stretchImageWithName:@"common_button_big_red.png"] forState:UIControlStateNormal];
        _CompleteOrderBtn.hidden = YES;
        _CompleteOrderBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [_CompleteOrderBtn setTitle:@"完成帮助" forState:UIControlStateNormal];
        [_CompleteOrderBtn addTarget:self action:@selector(completeOrder) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_CompleteOrderBtn];
        
    }
    return self;
}

-(void)cancelOrder
{
    if (_presentCancelVC) {
        _presentCancelVC(_cancelOrderBtn.tag);
    }
    
}
-(void)completeOrder
{
    if (_presentCompleteVC) {
        _presentCompleteVC();
    }
}
-(void)setHelpExpress:(HelpExpress *)helpExpress
{
    _helpExpress = helpExpress;
    //    _titleView.backgroundColor = kGetColor(240, 230, 140);
    //    _titleLabel.text = @"谁来帮我取下快递";
    
    _firstLineTitle.text = @"取件时间 : ";
    _secondLineTitle.text = @"取件地点 : ";
    _thirdLineTitle.text = @"收件地址 : ";
    _forthLineTitle.text = @"补充说明 : ";
    //_icon.image = [UIImage imageNamed:helpExpress.user.profileImageUrl];
    _feeLabel.text = helpExpress.fee;
    //_nickNameLabel.text = helpExpress.user.nickName;
    
    _PTimeLabel.text = helpExpress.publishTime;
    _firstLineLabel.text = helpExpress.expressTime;
    _secondLineLabel.text = helpExpress.expressLocation;
    _thirdLineLabel.text = helpExpress.ownerLocation;
    _forthLineLabel.text = helpExpress.note;
    _feeLabel.text = [NSString stringWithFormat:@" :%@",helpExpress.fee];
    
    //_forthLineLabel.text = helpExpress.ownerLocation;
    
    NSLog(@"%@--%@-%@-%@-%@-%@-%@-%@-%@",helpExpress.expressLocation,helpExpress.expressTime,helpExpress.publishTime,helpExpress.ownerLocation,helpExpress.titleText,helpExpress.user.nickName,helpExpress.user.userId,helpExpress.fee,helpExpress.note);
    
    
    
}

-(void)setCampusFood:(CampusFood *)campusFood
{
    _campusFood = campusFood;
    //    _titleView.backgroundColor = kGetColor(255, 192, 203);
    //    _titleLabel.text = @"谁来帮我从食堂带饭";
    _firstLineTitle.text = @"送达时间 : ";
    _secondLineTitle.text = @"带饭食堂 : ";
    _thirdLineTitle.text = @"美食名称 : ";
    _forthLineTitle.text = @"送达地址 : ";
   // _noteLabel.frame = CGRectMake(_icon.frame.origin.x,_icon.frame.origin.y +_icon.frame.size.height+kHeightMargin,  kNoteShortWidth, kNoteHeight);
    //_icon.image = [UIImage imageNamed:campusFood.user.profileImageUrl];
    _feeLabel.text = [NSString stringWithFormat:@" :%@",campusFood.fee];
   // _nickNameLabel.text = campusFood.user.nickName;
    _PTimeLabel.text = campusFood.publishTime;
    _firstLineLabel.text = campusFood.foodTime;
    _secondLineLabel.text = campusFood.messLocation;
    _thirdLineLabel.text = campusFood.foodName;
    _forthLineLabel.text = campusFood.note;
    _forthLineLabel.text = campusFood.ownerLocation;
    NSLog(@"%@--%@-%@-%@-%@-%@-%@-%@-%@",campusFood.foodName,campusFood.foodTime,campusFood.publishTime,campusFood.messLocation,campusFood.titleText,campusFood.user.nickName,campusFood.user.userId,campusFood.fee,campusFood.note);
    
}

-(void)setHelpClass:(HelpClass *)helpClass
{
    _helpClass = helpClass;
    _firstLineTitle.text = @"上课时间 : ";
    _secondLineTitle.text = @"上课教室 : ";
    _thirdLineTitle.text = @"课程名称 : ";
    _forthLineTitle.text = @"补充说明 : ";
    //_forthLineImage.image = [UIImage imageNamed:@"location.png"];
    //_icon.image = [UIImage imageNamed:helpClass.user.profileImageUrl];
    _feeLabel.text = [NSString stringWithFormat:@" :%@",helpClass.fee];
    //_nickNameLabel.text = helpClass.user.nickName;
    _PTimeLabel.text = helpClass.publishTime;
    _firstLineLabel.text = helpClass.classTime;
    _secondLineLabel.text = helpClass.roomLocation;
    _thirdLineLabel.text = helpClass.className;
    _forthLineLabel.text = helpClass.note;
    //_forthLineLabel.text = helpClass.ownerLocaton;
    NSLog(@"%@-%@-%@--%@-%@-%@-%@-%@-%@", helpClass.className,helpClass.classTime,helpClass.publishTime,helpClass.roomLocation,helpClass.titleText,helpClass.user.nickName,helpClass.user.userId,helpClass.fee,helpClass.note);
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
