//
//  HomeViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-10.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic,copy)void (^whoHelp)();
@end
