//
//  CancelOrderViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-5-7.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CancelOrderViewController : UIViewController
@property(nonatomic,strong)void (^popMydetailOrderVC)();
@property (nonatomic,strong)UILabel *iconLabel;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *noteImage;
@property (nonatomic,strong)UILabel *noteLabel;
@end
