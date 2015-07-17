//
//  SchBtnView.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-13.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "SchBtnView.h"
#define kBtnWidMargin 20
#define kBtnHighMargin 15
#define kBtnWidth 80
#define kBtnHeight 40
#define kHeightMargin 30
@implementation SchBtnView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        for (int i=0; i<9; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.backgroundColor = [UIColor grayColor];
            [btn setHighlighted:YES];
            [self addSubview:btn];
        }

        
    }
    return self;
}
-(void)setBtnArray:(NSArray *)btnArray
{
    
    _btnArray = btnArray;
    NSLog(@"%@",btnArray);
    //这里要遍历子控件，而不是图片数组
    int btnCount = (int)btnArray.count;
    int subviewsCount = (int)self.subviews.count;
    NSLog(@"%d---%d",btnCount,subviewsCount);
    for (int i=0; i<subviewsCount; i++) {
        UIButton *childBtn = self.subviews[i];
        if (btnCount == 0) {
            UILabel *btnlabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 100, 100, 40)];
            btnlabel.text = @"此地区无校区";
            btnlabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:btnlabel];
            
        }
        if (i>=btnCount) {//i位置对应的控件没有图片
            
            childBtn.hidden = YES;
            
        }else{
            childBtn.hidden = NO;
            
            
            int divide = 3;
            
            int column = i%divide ;
            int row = i/divide;
            int childX = kBtnWidMargin + column * (kBtnWidth + kBtnWidMargin);
            int childY = kHeightMargin + row * (kBtnHighMargin+ kBtnHeight);
            
            
            childBtn.frame = CGRectMake(childX, childY, kBtnWidth, kBtnHeight);
            
            [childBtn setTitle:btnArray[i] forState:UIControlStateNormal];
            
            //[childBtn addTarget:self action:@selector(TEST) forControlEvents:UIControlEventTouchUpInside];
            childBtn.selected = YES;
            [childBtn setHighlighted:YES];
            BOOL y = childBtn.selected;
            childBtn.userInteractionEnabled =YES;
            [childBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_button_disable.png"] forState:UIControlStateHighlighted];
       
            
            
        }
        
        
    }
    
}



+(CGSize)btnSizeWidthCount:(int)count
{
    
    if (count == 1) {
        return CGSizeMake(320, 240);
    }
    int rows = (count /3)+1;
    
    CGFloat height = rows *kBtnHeight + kBtnHighMargin +2*kHeightMargin;
    
    
    return CGSizeMake(320, height);
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
