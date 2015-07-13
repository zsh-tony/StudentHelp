//
//  HelpBtnItem.m
//  SchoolExpress
//
//  Created by zsh tony on 15-5-9.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "HelpBtnItem.h"
#define kImageRatio 0.6
@implementation HelpBtnItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //1.设置文字属性
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = k13BordFont;
        [self setTitleColor:kGetColor(60,60,60) forState:UIControlStateNormal];
        [self setTitleColor:kGetColor(234,128,16) forState:UIControlStateSelected];
        //2.设置图片属性
        self.backgroundColor = [UIColor clearColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.adjustsImageWhenHighlighted = NO;
        //3.设置选中时的bgimage
        // [self setBackgroundImage:[UIImage imageNamed:@"navigationbar_background@2x.png"] forState:UIControlStateSelected];
        //highted会影响状态，每次 长按时会回到highlighted，为防止此影响，重写父类的高亮方法
        
    }
    return self;
}
//重写父类的方法可以去掉某些从父类继承来的不想要的设置
-(void)setHighlighted:(BOOL)highlighted
{
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
//返回的是按钮内部UILabel的边框，这个UILabel是和button的title相关的
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height * kImageRatio+8, contentRect.size.width,contentRect.size.height * (1-kImageRatio));
    
}

//返回的是按钮内部的UIImageview的边框，和按钮的image相关
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return  CGRectMake(0, 1, contentRect.size.width, contentRect.size.height * 0.7);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
