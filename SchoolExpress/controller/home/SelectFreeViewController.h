//
//  SelectFreeViewController.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-22.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASValueTrackingSlider.h"
@interface SelectFreeViewController : UIViewController

@property (strong, nonatomic) IBOutlet ASValueTrackingSlider *freeSlider;
- (IBAction)done:(UIButton *)sender;
- (IBAction)cancel:(UIButton *)sender;

@end
