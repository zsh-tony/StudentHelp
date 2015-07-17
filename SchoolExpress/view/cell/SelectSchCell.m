//
//  SelectSchCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-13.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "SelectSchCell.h"
#define kBtnWidMargin 20
#define kBtnHighMargin 15
#define kBtnWidth 80
#define kBtnHeight 40


@implementation SelectSchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
        
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
            
            [self.contentView addSubview:btn];
            
        }
    }
    return self;
}
-(void)setBtnArray:(NSArray *)btnArray
{
    
    _btnArray = btnArray;
    
    //这里要遍历子控件，而不是图片数组
    int btnCount = (int)btnArray.count;
    int subviewsCount = (int)self.contentView.subviews.count;
    //NSLog(@"%d---%d",btnCount,subviewsCount);
    for (int i=0; i<subviewsCount; i++) {
        UIButton *childBtn = self.contentView.subviews[i];
        if (btnCount == 0) {
            UILabel *btnlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 100, 40)];
            btnlabel.text = @"定位失败";
            btnlabel.font = [UIFont systemFontOfSize:14];
            [self.contentView addSubview:btnlabel];
            
        }
        if (i>=btnCount) {//i位置对应的控件没有图片
            
            childBtn.hidden = YES;
            
        }else{
            childBtn.hidden = NO;
            
            
            int divide = 3;
            
            int column = i%divide ;
            int row = i/divide;
            int childX = kBtnWidMargin + column * (kBtnWidth + kBtnWidMargin);
            int childY = kBtnHighMargin + row * (kBtnHighMargin+ kBtnHeight);
            
            
            childBtn.frame = CGRectMake(childX, childY, kBtnWidth, kBtnHeight);
            self.cellHeight = (row +1) *(kBtnHeight + kBtnHighMargin) + kBtnHighMargin ;
          

            [childBtn setTitle:btnArray[i] forState:UIControlStateNormal];
            
            [childBtn addTarget:self action:@selector(selectSch:) forControlEvents:UIControlEventTouchUpInside];
            
            //            if (i==self.defaultsch) {
//                // NSLog(@"%d",self.defaultsch);
//                childBtn.selected = YES;
//            }
//            //            BOOL y = childBtn.selected;
//            //            childBtn.userInteractionEnabled = YES;
//            //            [childBtn setTitle:nil  forState:UIControlStateHighlighted];
//            //
//            //            NSLog(@"%hhd",y);
//            
//            
        }
        
        
    }
    
}

-(void)setCellHeight:(CGFloat)cellHeight
{
    _cellHeight = cellHeight;
}

-(void)selectSch:(UIButton *)sender
{
//    if (sender.selected ==YES) {
//        return;
//    }else{
//        for (UIButton *btn in self.subviews) {
//            if ([btn isKindOfClass:[UIButton class]]) {
//                if (btn!=sender) {
//                    btn.selected = NO;
//                }
//            }
//            sender.selected =YES;
//            _defaultsch = sender.tag;
//        }
//    }
    _defaultsch = (int)sender.tag;
   
    if (_selectCityBlock) {
        _displaySch = sender.currentTitle;
        _selectCityBlock(_defaultsch,_displaySch);
   
    }
    //NSLog(@"%@", sender.currentTitle);
    //NSLog(@"%d",_defaultsch);
}



- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    // 即使触摸到的是一个 UIControl (如子类：UIButton), 我们也希望拖动时能取消掉动作以便响应滚动动作
    return YES;
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
