//
//  InputLocationVC.h
//  SchoolExpress
//
//  Created by zsh tony on 15-3-19.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputLocationVC : UIViewController<UITextViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic,strong) UIPickerView *pickView;
@property (nonatomic,strong) UIView *locationBar;
@property (nonatomic,strong) UITextView *campusText;
@property (nonatomic,strong) UITextView *detailText;
@property (nonatomic,strong) NSMutableArray *campusArray;
@property (nonatomic,strong) NSMutableArray *eventArray;
@property (nonatomic,strong) NSMutableArray *numberArray;
@property (nonatomic,strong) NSMutableArray *marketArray;
@property (nonatomic,copy)void (^selectedLocation)(NSString *backStr);
@end
