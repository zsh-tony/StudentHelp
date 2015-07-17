//
//  SelectSchViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-12.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchBtnScrollView.h"
@interface SelectSchViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic, copy) void (^selectmidSchBlock)(int selectmidSch,NSString *display);
@property (nonatomic, copy) void (^MaskViewPop)();
//@property (nonatomic, copy) void (^SwicthToChangeVC)();
@property (nonatomic,strong) NSString *displayMidSch;
@property (nonatomic,strong) SchBtnScrollView *scrollview;
@property (nonatomic,strong) UIView *middleView;

@end
