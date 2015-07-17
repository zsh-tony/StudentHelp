//
//  TotalHeadView.m
//  SchoolExpress
//
//  Created by lerrruby on 15/5/18.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "TotalHeadView.h"
#define kAccountMargin 12
#define kAccountLabelWidth 40
#define kAccountTextWidth 150
#define kIncomeWidth 100
#define kIncomeMargin 10
@implementation TotalHeadView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(kAccountMargin, kAccountMargin, kAccountTextWidth, 22)];
        _accountLabel.backgroundColor = [UIColor clearColor];
        _accountLabel.textAlignment = NSTextAlignmentLeft;
        _accountLabel.textColor = [UIColor whiteColor];
        _accountLabel.text = @"账户余额";
        _accountLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [self addSubview:_accountLabel];
        
        _accountText = [[UILabel alloc]initWithFrame:CGRectMake(320 -kAccountTextWidth-kAccountMargin, _accountLabel.frame.origin.y, kAccountTextWidth, 22)];
        _accountText.backgroundColor = [UIColor clearColor];
        _accountText.textAlignment = NSTextAlignmentRight;
        _accountText.textColor = [UIColor whiteColor];
        _accountText.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [self addSubview:_accountText];
        
        UIView *seperatorW = [[UIView alloc]initWithFrame:CGRectMake(0, 45, 320, 0.5)];
        seperatorW.backgroundColor = kGetColor(123, 100, 75);
        [self addSubview:seperatorW];
        
        UIView *seperatorH = [[UIView alloc]initWithFrame:CGRectMake(160, 45, 0.5, 35)];
        seperatorH.backgroundColor = kGetColor(123, 100, 75);
        [self addSubview:seperatorH];
        
        _incomeLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, seperatorW.frame.origin.y+kIncomeMargin, 30, 14)];
        _incomeLabel.backgroundColor = [UIColor clearColor];
        _incomeLabel.textAlignment = NSTextAlignmentLeft;
        _incomeLabel.textColor = [UIColor whiteColor];
        _incomeLabel.font = [UIFont systemFontOfSize:14];
        _incomeLabel.text = @"收入";
        [self addSubview:_incomeLabel];
        
        _incomeText = [[UILabel alloc]initWithFrame:CGRectMake(160-kIncomeMargin-kIncomeWidth, seperatorW.frame.origin.y+kIncomeMargin, kIncomeWidth, 14)];
        _incomeText.backgroundColor = [UIColor clearColor];
        _incomeText.textAlignment = NSTextAlignmentRight;
        _incomeText.textColor = [UIColor whiteColor];
        _incomeText.font = [UIFont systemFontOfSize:14];
        [self addSubview:_incomeText];
        
        _payLabel = [[UILabel alloc]initWithFrame:CGRectMake(160+13, seperatorW.frame.origin.y+kIncomeMargin, 30, 14)];
        _payLabel.backgroundColor = [UIColor clearColor];
        _payLabel.textAlignment = NSTextAlignmentLeft;
        _payLabel.textColor = [UIColor whiteColor];
        _payLabel.font = [UIFont systemFontOfSize:14];
        _payLabel.text = @"支出";
        [self addSubview:_payLabel];
        
        _payText = [[UILabel alloc]initWithFrame:CGRectMake(320-kIncomeMargin-kIncomeWidth, seperatorW.frame.origin.y+kIncomeMargin, kIncomeWidth, 14)];
        _payText.backgroundColor = [UIColor clearColor];
        _payText.textAlignment = NSTextAlignmentRight;
        _payText.textColor = [UIColor whiteColor];
        _payText.font = [UIFont systemFontOfSize:14];
        [self addSubview:_payText];
        
        self.backgroundColor = kGetColor(134, 110, 84);
   
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
