//
//  UIBTextViewCell.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-30.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBTextViewCell : UITableViewCell<UITextViewDelegate>
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextView *contentText;
@property (nonatomic,strong)UILabel *placeholder;
@property (nonatomic,strong)UIImageView *bgImageview;
@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,copy) void (^returnKey)(UITextView *textView);
@property (nonatomic,copy) void (^keyboardHeight)();
@end
