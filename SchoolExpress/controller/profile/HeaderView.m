//
//  HeaderView.m
//  02-QQ好友列表
//
//  Created by apple on 13-7-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "HeaderView.h"
#define kHeightMargin 5
#define kWidthMargin 10
#define kTotalTextWidth 100
#define kTotalLabelWidth 30
@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _monthText = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 28, 30)];
        _monthText.backgroundColor = [UIColor clearColor];
        _monthText.font = [UIFont systemFontOfSize:22];
        _monthText.textAlignment = NSTextAlignmentRight;
        _monthText.textColor = kGetColor(121, 123, 126);
        [self addSubview:_monthText];
        
        _monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(_monthText.frame.origin.x + _monthText.frame.size.width+3, _monthText.frame.origin.y+3, 15, _monthText.frame.size.height)];
        _monthLabel.backgroundColor = [UIColor clearColor];
        _monthLabel.font = k11Font;
        _monthLabel.text = @"月";
         _monthLabel.textAlignment = NSTextAlignmentLeft;
        _monthLabel.textColor = kGetColor(172, 172, 172);
        [self addSubview:_monthLabel];
        
        _incomeText = [[UILabel alloc]initWithFrame:CGRectMake(_monthLabel.frame.origin.x +_monthLabel.frame.size.width +kHeightMargin, kHeightMargin, 150, 14)];
        _incomeText.backgroundColor =[UIColor clearColor];
        _incomeText.font = k11BordFont;
        _incomeText.textColor = kGetColor(215, 57, 57);
        [self addSubview:_incomeText];
        
        _payText = [[UILabel alloc]initWithFrame:CGRectMake(_incomeText.frame.origin.x, _incomeText.frame.origin.y + _incomeText.frame.size.height +kHeightMargin, _incomeText.frame.size.width, _incomeText.frame.size.height)];
        _payText.backgroundColor =[UIColor clearColor];
        _payText.font = k11BordFont;
        _payText.textColor = kGetColor(42, 143, 105);
        [self addSubview:_payText];
        
        UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(0, 43, 320, 0.5)];
        seperator.backgroundColor = kGetColor(211, 211, 211);
        [self addSubview:seperator];
        //self.frame.size.width - kHeightMargin-kTotalLabelWidth
        _totalLabel = [[UILabel alloc]initWithFrame:CGRectMake(320 - kWidthMargin-kTotalLabelWidth, kHeightMargin, kTotalLabelWidth, 14)];
        _totalLabel.textColor = kGetColor(93, 96, 101);
        _totalLabel.backgroundColor = [UIColor clearColor];
        _totalLabel.font = k11BordFont;
         _totalLabel.textAlignment = NSTextAlignmentRight;
        _totalLabel.text = @"结余";
        [self addSubview:_totalLabel];
        _totalText = [[UILabel alloc]initWithFrame:CGRectMake(320 - kTotalTextWidth - kWidthMargin , _totalLabel.frame.origin.y+_totalLabel.frame.size.height + kHeightMargin, kTotalTextWidth, 44 - _totalLabel.frame.origin.y-_totalLabel.frame.size.height - kHeightMargin*2)];
        _totalText.backgroundColor = [UIColor clearColor];
        _totalText.textAlignment = NSTextAlignmentRight;
        _totalText.textColor = kGetColor(121, 123, 126);
        _totalText.font = k16Font;
        [self addSubview:_totalText];
        
    }
    
    return self;
}

@end
