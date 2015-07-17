//
//  SelectFreeViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-22.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "SelectFreeViewController.h"

@interface SelectFreeViewController ()

@end

@implementation SelectFreeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.freeSlider.maximumValue = 255.0;
    self.freeSlider.popUpViewCornerRadius = 0.0;
    [self.freeSlider setMaxFractionDigitsDisplayed:0];
    self.freeSlider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    self.freeSlider.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
    self.freeSlider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)done:(UIButton *)sender {
}

- (IBAction)cancel:(UIButton *)sender {
}
@end
