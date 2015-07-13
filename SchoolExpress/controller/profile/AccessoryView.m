//
//  AccessoryView.m
//  SchoolExpress
//
//  Created by lerrruby on 15/5/18.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "AccessoryView.h"

@implementation AccessoryView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _incomePayLabel = [[UILabel alloc]initWithFrame:CGRectMake(-40,-10, 40, 20)];
        _incomePayLabel.font = k15BordFont;
        _incomePayLabel.textAlignment = NSTextAlignmentRight;
        _incomePayLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_incomePayLabel];
        
        _indictorImage = [[UIImageView alloc]initWithFrame:CGRectMake(_incomePayLabel.frame.origin.x + _incomePayLabel.frame.size.width , _incomePayLabel.frame.origin.y, 20, _incomePayLabel.frame.size.height)];
        //_indictorImage.contentMode = UIViewContentModeScaleAspectFit;
        _indictorImage.image = [UIImage imageNamed:@"accessoryIndictor.png"];
        [self addSubview:_indictorImage];
        
        self.backgroundColor = [UIColor clearColor];
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
