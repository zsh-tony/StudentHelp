//
//  zshViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-10.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic ,readonly,strong) UINavigationController *selectedController;
@end
