//
//  inputRoomVC.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-1.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface inputRoomVC : UIViewController<UITextViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic,strong) UIPickerView *pickView;
@property (nonatomic,strong) UIView *locationBar;
@property (nonatomic,strong) UITextView *campusText;
@property (nonatomic,strong) UITextView *detailText;
@property (nonatomic,strong) NSMutableArray *campusArray;
@property (nonatomic,strong) NSMutableArray *buildingArray;
@property (nonatomic,strong) NSMutableDictionary *buildingDict;
@property (nonatomic,strong) NSMutableArray *floorOneArray;
@property (nonatomic,strong) NSMutableArray *floorTwoArray;
@property (nonatomic,strong) NSMutableArray *floorThreeArray;
@property (nonatomic,strong) NSMutableArray *floorFourArray;
@property (nonatomic,strong) NSMutableDictionary *floorDict;
@property (nonatomic,strong) NSMutableArray *numberOneArray;
@property (nonatomic,strong) NSMutableArray *numberTwoArray;
@property (nonatomic,strong) NSMutableArray *numberThreeArray;
@property (nonatomic,strong) NSMutableArray *customArray;
@property (nonatomic,copy)void (^selectedLocation)(NSString *backStr);

@end
