//
//  SchBtnScrollView.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-13.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "SchBtnScrollView.h"
#define kBtnWidMargin 20
#define kBtnHighMargin 15
#define kBtnWidth 80
#define kBtnHeight 40
#define kHeightMargin 30
@implementation SchBtnScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
    
        // Initialization code
        for (int i=0; i<12; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            //[btn setBackgroundImage:[UIImage imageNamed:@"common_card_background.png"] forState:UIControlStateNormal];
            //[btn setBackgroundImage:[UIImage imageNamed:@"toolbar_button_highlighted.png"] forState:UIControlStateHighlighted ];
            [btn setBackgroundImage:[UIImage stretchImageWithName:@"common_card_background.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage stretchImageWithName:@"common_button_white_highlighted.png"] forState:UIControlStateSelected];
            
            btn.adjustsImageWhenHighlighted = NO;
            [btn setTitleColor:kGetColor(50 , 50, 50) forState:UIControlStateNormal];
            btn.titleLabel.font = kSelectSchBtnFont;
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
           
            [self addSubview:btn];
            
        }
    }
    return self;
}
-(void)setBtnArray:(NSArray *)btnArray
{
    
    _btnArray = btnArray;
    
    //这里要遍历子控件，而不是图片数组
    int btnCount = (int)btnArray.count;
    int subviewsCount = (int)self.subviews.count;
    //NSLog(@"%d---%d",btnCount,subviewsCount);
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
            
            [childBtn addTarget:self action:@selector(selectSch:) forControlEvents:UIControlEventTouchUpInside];
            if (i==self.defaultsch) {
               // NSLog(@"%d",self.defaultsch);
                childBtn.selected = YES;
            }

            
            
        }
        
        
    }
    
}

-(void)setDefaultsch:(int)defaultsch
{
    _defaultsch = defaultsch;
}
-(void)selectSch:(UIButton *)sender
{
    if (sender.selected ==YES) {
        return;
            }else{
        for (UIButton *btn in self.subviews) {
            if ([btn isKindOfClass:[UIButton class]]) {
                if (btn!=sender) {
                    btn.selected = NO;
                }
            }
            sender.selected =YES;
            _defaultsch = (int)sender.tag;
        }
    }
    if (_selectSchBlock) {
        _selectSchBlock(_defaultsch,sender.currentTitle);
        _displaySch = sender.currentTitle;
    }
    //NSLog(@"%@", sender.currentTitle);
    //NSLog(@"%d",_defaultsch);
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
- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    // 即使触摸到的是一个 UIControl (如子类：UIButton), 我们也希望拖动时能取消掉动作以便响应滚动动作
    return YES;
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
