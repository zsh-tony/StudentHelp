//
//  SchBtnView.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-13.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchBtnView : UIView
@property (nonatomic,strong) NSArray *btnArray;
+(CGSize)btnSizeWidthCount:(int)count;
@end
