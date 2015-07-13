//
//  SchBtnScrollView.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-13.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchBtnScrollView : UIScrollView
@property (nonatomic,strong) NSArray *btnArray;
@property (nonatomic,assign) int defaultsch;
@property (nonatomic,strong) NSString *displaySch;
@property (nonatomic, copy) void (^selectSchBlock)(int selectSch,NSString *display);
+(CGSize)btnSizeWidthCount:(int)count;
@end
