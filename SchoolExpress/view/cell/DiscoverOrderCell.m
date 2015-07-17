
//
//  expressCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-10.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "DiscoverOrderCell.h"
#define kWidthMargin 15
#define kHeightMargin 10
#define kLittleHeightMargin 4
#define kLittleMargin 6
#define kIconLength 40
#define kNickNameWith 50
#define kNickNameHeight 15
#define kPTimeWidth 50
#define kPTimeHeight 15
#define kContentWidth 60
#define kContentHeight 10
#define kNoteLongWidth 200
#define kNoteShortWidth 120
#define kNoteHeight 10
#define kFeeIconLength 15
#define kFeeTextWidth 30
#define kFeeTextHeight 10
#define kFeeY 25

//#define kBigFont [UIFont fontWithName:@"Helvetica-Bold" size:15]
#define kBigFont [UIFont systemFontOfSize:13]
//#define kLittleFont [UIFont fontWithName:@"Helvetica-Bold" size:12]
#define kLittleFont [UIFont systemFontOfSize:11]
@implementation DiscoverOrderCell
- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 10;
    frame.size.width -= 20;
    frame.origin.y += 5;
    frame.size.height -= 10;
    [super setFrame:frame];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       // self.backgroundColor = [UIColor whiteColor];
        //self.layer.borderWidth = 3;
        //self.layer.maskesToBounds = YES;
        //self.layer.cornerRadius = 5;
        UIImageView *bg = [[UIImageView alloc]initWithFrame:CGRectMake(-5, -3, 310, 75)];
        bg.image = [UIImage stretchImageWithName:@"common_card_background.png"];
        [self.contentView addSubview:bg];
        self.layer.shadowOffset = CGSizeMake(0, 2);//[水平偏移，垂直偏移]
        self.layer.shadowRadius = 1.0;//阴影半径
        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        self.layer.shadowOpacity = 0.8;
//        self.frame = CGRectMake(40, 0, 260, 70);
       
//       
        
    }
    [self addSubViews];
    return self;
}
-(void)addSubViews
{
//    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
//  
//    [self.contentView addSubview:_titleView];
//    
//    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 2, 200, 31)];
//    _titleLabel.backgroundColor = [UIColor clearColor];
//    
//    _titleLabel.font = kTitleFont;
//    _titleLabel.textColor = [UIColor whiteColor];
//    [_titleView addSubview:_titleLabel];
    

    
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(kWidthMargin, kHeightMargin, kIconLength, kIconLength)];
    [self.contentView addSubview:_icon];
    
    _nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_icon.frame.origin.x +_icon.frame.size.width+kWidthMargin,kHeightMargin, kNickNameWith, kNickNameHeight)];
    _nickNameLabel.backgroundColor = [UIColor clearColor];
    _nickNameLabel.textColor = kTextColor;
    _nickNameLabel.font = kBigFont;
    [self.contentView addSubview:_nickNameLabel];
    
    _PTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nickNameLabel.frame.origin.x, _nickNameLabel.frame.origin.y +_nickNameLabel.frame.size.height+kHeightMargin, kPTimeWidth, kPTimeHeight)];
    _PTimeLabel.backgroundColor = [UIColor clearColor];
    _PTimeLabel.textColor = [UIColor grayColor];
    _PTimeLabel.font = kBigFont;
    [self.contentView addSubview:_PTimeLabel];
    
    _noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(_icon.frame.origin.x,_icon.frame.origin.y +_icon.frame.size.height+kLittleHeightMargin,  kNoteLongWidth, kNoteHeight)];
    _noteLabel.backgroundColor = [UIColor clearColor];
    _noteLabel.textColor = kTitleColor;
    _noteLabel.font = kLittleFont;
    [self.contentView addSubview:_noteLabel];
    
    
    _firstLineTitle = [[UILabel alloc]initWithFrame:CGRectMake(_nickNameLabel.frame.origin.x + _nickNameLabel.frame.size.width + kWidthMargin, kHeightMargin, kContentWidth, kContentHeight)];
    _firstLineTitle.backgroundColor = [UIColor clearColor];
    _firstLineTitle.textColor = kGrayTextColor;
    _firstLineTitle.font = kLittleFont;
    [self.contentView addSubview:_firstLineTitle];
    
    _firstLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(_firstLineTitle.frame.origin.x +_firstLineTitle.frame.size.width-kLittleMargin , kHeightMargin, 150, kContentHeight)];
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
    
    
    _forthLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(_thirdLineTitle.frame.origin.x + _thirdLineTitle.frame.size.width, _forthLineTitle.frame.origin.y, kContentWidth, kContentHeight)];
    _forthLineLabel.backgroundColor = [UIColor clearColor];
    _forthLineLabel.textColor = kGrayTextColor;
    _forthLineLabel.font = kLittleFont;
    [self.contentView addSubview:_forthLineLabel];

    
    _feeImage = [[UIImageView alloc]initWithFrame:CGRectMake(_thirdLineLabel.frame.origin.x + _thirdLineLabel.frame.size.width +2*kLittleHeightMargin, kFeeY, kFeeIconLength, kFeeIconLength)];
    _feeImage.image = [UIImage imageNamed:@"feeImage.png"];
    [self.contentView addSubview:_feeImage];
    
    _feeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_feeImage.frame.origin.x + _feeImage.frame.size.width, kFeeY+2, kFeeTextWidth, kFeeTextHeight)];
    _feeLabel.textColor = kGrayTextColor;
    _feeLabel.backgroundColor = [UIColor clearColor];
    _feeLabel.font = kBigFont;
    [self.contentView addSubview:_feeLabel];
    
    
 
    
}
-(void)setHelpExpress:(HelpExpress *)helpExpress
{
    _helpExpress = helpExpress;
//    _titleView.backgroundColor = kGetColor(240, 230, 140);
//    _titleLabel.text = @"谁来帮我取下快递";

    _firstLineTitle.text = @"取件时间 :";
    _secondLineTitle.text = @"取件地点 :";
    _thirdLineTitle.text = @"收件地址 :";
    _icon.image = [UIImage imageNamed:helpExpress.user.profileImageUrl];
    _feeLabel.text = helpExpress.fee;
    _nickNameLabel.text = helpExpress.user.nickName;
   
    _PTimeLabel.text = helpExpress.publishTime;
    NSLog(@"%@",helpExpress.publishTime);
    _firstLineLabel.text = helpExpress.expressTime;
    _secondLineLabel.text = helpExpress.expressLocation;
    _thirdLineLabel.text = helpExpress.ownerLocation;
    _noteLabel.text = helpExpress.note;
    _feeLabel.text = [NSString stringWithFormat:@" :%@",helpExpress.fee];
    
    //_forthLineLabel.text = helpExpress.ownerLocation;
 
//    NSLog(@"%@--%@-%@-%@-%@-%@-%@-%@-%@",helpExpress.expressLocation,helpExpress.expressTime,helpExpress.publishTime,helpExpress.ownerLocation,helpExpress.titleText,helpExpress.user.nickName,helpExpress.user.userId,helpExpress.fee,helpExpress.note);
    
       [_icon setImageWithURL:[NSURL URLWithString:helpExpress.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default_big.png"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    
}

-(void)setCampusFood:(CampusFood *)campusFood
{
    _campusFood = campusFood;
//    _titleView.backgroundColor = kGetColor(255, 192, 203);
//    _titleLabel.text = @"谁来帮我从食堂带饭";
    _firstLineTitle.text = @"送达时间 :";
    _secondLineTitle.text = @"带饭食堂 :";
    _thirdLineTitle.text = @"美食名称 :";
    _forthLineTitle.text = @"送达地址 :";
    _noteLabel.frame = CGRectMake(_icon.frame.origin.x,_icon.frame.origin.y +_icon.frame.size.height+kHeightMargin,  kNoteShortWidth, kNoteHeight);
    _icon.image = [UIImage imageNamed:campusFood.user.profileImageUrl];
    _feeLabel.text = [NSString stringWithFormat:@" :%@",campusFood.fee];
    _nickNameLabel.text = campusFood.user.nickName;
    _PTimeLabel.text = campusFood.publishTime;
    _firstLineLabel.text = campusFood.foodTime;
    _secondLineLabel.text = campusFood.messLocation;
    _thirdLineLabel.text = campusFood.foodName;
    _noteLabel.text = campusFood.note;
    _forthLineLabel.text = campusFood.ownerLocation;
//    NSLog(@"%@--%@-%@-%@-%@-%@-%@-%@-%@",campusFood.foodName,campusFood.foodTime,campusFood.publishTime,campusFood.messLocation,campusFood.titleText,campusFood.user.nickName,campusFood.user.userId,campusFood.fee,campusFood.note);
    [_icon setImageWithURL:[NSURL URLWithString:campusFood.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default_big.png"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    
}

-(void)setHelpClass:(HelpClass *)helpClass
{
    _helpClass = helpClass;
    _firstLineTitle.text = @"上课时间 :";
    _secondLineTitle.text = @"上课教室 :";
    _thirdLineTitle.text = @"课程名称 :";
    //_forthLineImage.image = [UIImage imageNamed:@"location.png"];
    _icon.image = [UIImage imageNamed:helpClass.user.profileImageUrl];
    _feeLabel.text = [NSString stringWithFormat:@" :%@",helpClass.fee];
    _nickNameLabel.text = helpClass.user.nickName;
    _PTimeLabel.text = helpClass.publishTime;
    _firstLineLabel.text = helpClass.classTime;
    _secondLineLabel.text = helpClass.roomLocation;
    _thirdLineLabel.text = helpClass.className;
    _noteLabel.text = helpClass.note;
    //_forthLineLabel.text = helpClass.ownerLocaton;
//       NSLog(@"%@-%@-%@--%@-%@-%@-%@-%@-%@", helpClass.className,helpClass.classTime,helpClass.publishTime,helpClass.roomLocation,helpClass.titleText,helpClass.user.nickName,helpClass.user.userId,helpClass.fee,helpClass.note);
    [_icon setImageWithURL:[NSURL URLWithString:helpClass.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"avatar_default_big.png"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    
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
