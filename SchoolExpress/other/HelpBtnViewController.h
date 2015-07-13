//
//  SamplePopupViewController.h
//  CWPopupDemo
//
//  Created by Cezary Wojcik on 8/21/13.
//  Copyright (c) 2013 Cezary Wojcik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpBtnViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic,strong)void (^presentEventVC)();
@end
