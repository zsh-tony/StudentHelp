//
//  SamplePopupViewController.m
//  CWPopupDemo
//
//  Created by Cezary Wojcik on 8/21/13.
//  Copyright (c) 2013 Cezary Wojcik. All rights reserved.
//

#import "HelpBtnViewController.h"
#import "HelpExpressViewController.h"
#import "CampusFoodViewController.h"
#import "OuterFoodViewController.h"
#import "HelpClassViewController.h"
#import "HelpBtnItem.h"
#define kCount 8
#define kBtnY 0
#define kBtnScrollviewFrame CGRectMake(0, 230, 320, 180)
@interface HelpBtnViewController ()
{
    UIPanGestureRecognizer *panRecognizer;
}
@end

@implementation HelpBtnViewController

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
    // Do any additional setup after loading the view from its nib.
    // use toolbar as background because its pretty in iOS7
 
    // set size
    
     panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backBtn:)];
    
   
    
    for (int i=0; i<kCount; i++) {
        if (i==0) {
            [self addHelpBtnWithIndex:i name:@"食堂带饭"];
        }else if(i == 1){
            [self addHelpBtnWithIndex:i name:@"取快递"];
        }else if(i == 2){
            [self addHelpBtnWithIndex:i name:@"超市购物"];
        }else if(i == 3){
            [self addHelpBtnWithIndex:i name:@"上课"];
        }else if(i == 4){
            [self addHelpBtnWithIndex:i name:@"校外带饭"];
        }else if(i == 5){
            [self addHelpBtnWithIndex:i name:@"其他"];
        }else if(i == 6){
            [self addHelpBtnWithIndex:i name:@"打水"];
        }else
        {
            [self addHelpBtnWithIndex:i name:@"更多"];
        }
    }


}
- (void)addHelpBtnWithIndex:(int)index name:(NSString *)name
{
    CGSize viewSize = CGSizeMake(320, 200);
    HelpBtnItem *helpBtn = [HelpBtnItem buttonWithType:UIButtonTypeCustom];
    if (index > 5) {
        int row = index > 7? 1:0;
        helpBtn.frame=CGRectMake((index%3)*viewSize.width/3+viewSize.width,kBtnY+row*(viewSize.height/2), viewSize.width/3, viewSize.height/2);
    }else{
        int row = index > 2? 1:0;
        helpBtn.frame=CGRectMake((index%3)*viewSize.width/3,kBtnY + row*(viewSize.height/2), viewSize.width/3, viewSize.height/2);
    }
    if (index==0) {
        //helpBtn.backgroundColor = [UIColor lightGrayColor];
        [helpBtn setImage:[UIImage imageNamed:@"test.png"] forState:UIControlStateNormal];
        [helpBtn setTitle:@"取快递" forState:UIControlStateNormal];
        [helpBtn addTarget:self action:@selector(helpedCampusFood) forControlEvents:UIControlEventTouchUpInside];
        [helpBtn setTitle:name forState:UIControlStateNormal];
    }else if(index == 1){
        helpBtn.backgroundColor = [UIColor orangeColor];
        [helpBtn addTarget:self action:@selector(helpedExpress) forControlEvents:UIControlEventTouchUpInside];
        [helpBtn setTitle:name forState:UIControlStateNormal];
    }else if(index == 2){
        helpBtn.backgroundColor = [UIColor blueColor];
        [helpBtn addTarget:self action:@selector(helpedMarket) forControlEvents:UIControlEventTouchUpInside];
        [helpBtn setTitle:name forState:UIControlStateNormal];
    }else if(index == 3){
        helpBtn.backgroundColor = [UIColor brownColor];
        [helpBtn addTarget:self action:@selector(helpedClass) forControlEvents:UIControlEventTouchUpInside];
        [helpBtn setTitle:name forState:UIControlStateNormal];
    }else if(index == 4){
        helpBtn.backgroundColor = [UIColor grayColor];
        [helpBtn addTarget:self action:@selector(helpedOuterFood) forControlEvents:UIControlEventTouchUpInside];
        [helpBtn setTitle:name forState:UIControlStateNormal];
    }else if(index == 6){
        helpBtn.backgroundColor = [UIColor purpleColor];
        [helpBtn addTarget:self action:@selector(helpedWater) forControlEvents:UIControlEventTouchUpInside];
        [helpBtn setTitle:name forState:UIControlStateNormal];
    }else if(index == 5){
        helpBtn.backgroundColor = [UIColor greenColor];
        [helpBtn addTarget:self action:@selector(custom) forControlEvents:UIControlEventTouchUpInside];
        [helpBtn setTitle:name forState:UIControlStateNormal];
    }else{
        helpBtn.backgroundColor = [UIColor lightGrayColor];
        [helpBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        [helpBtn setTitle:name forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:1 animations:^{
        //[requreHelpSheet addView:helpBtn];
        [self.view addSubview:helpBtn];
    }];
    
    
    
}
-(void)helpedExpress
{
//    HelpExpressViewController *express = [[HelpExpressViewController alloc]init];
//
//        [self presentViewController:express animated:YES completion:nil];
    
    if (_presentEventVC) {
        _presentEventVC();
    }
    
}
-(void)helpedWater
{
    NSLog(@"asds");
}
-(void)helpedMarket
{
    NSLog(@"asds");
}
-(void)helpedCampusFood
{
    CampusFoodViewController *campusFood = [[CampusFoodViewController alloc]init];
    [self presentViewController:campusFood animated:YES completion:nil];
    
    
}
-(void)helpedOuterFood
{
    OuterFoodViewController *outerFood = [[OuterFoodViewController alloc]init];
    [self presentViewController:outerFood animated:YES completion:nil];
}
-(void)helpedClass
{
    HelpClassViewController *helpClass = [[HelpClassViewController alloc]init];
    [self presentViewController:helpClass animated:YES completion:nil];
    
}
-(void)more
{
    for (UIButton *btn in self.view.subviews) {
        [UIView animateWithDuration:0.5 animations:^{
            btn.frame = CGRectMake(btn.frame.origin.x -320, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
        }];
        
        
    }

    [self.view addGestureRecognizer:panRecognizer];
    
}
-(void)custom
{
    NSLog(@"asds");
}
-(void)backBtn:(UIPanGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateEnded:
            
            [self endedDrag:pan];
            
            break;
            
        default:
            
            [self draging:pan];
            break;
    }
    
    
    
}

-(void)endedDrag:(UIPanGestureRecognizer *)pan
{
    //    for (UIButton *btn in bgBtn.subviews) {
    //    [UIView animateWithDuration:0.5 animations:^{
    //        btn.transform = CGAffineTransformMakeTranslation(320, 0);
    //                } completion:^(BOOL finished) {
    //                    btn.transform = CGAffineTransformIdentity;
    //                }];
    //    }
    //
    
    for (UIButton *btn in self.view.subviews) {
        [UIView animateWithDuration:0.5 animations:^{
            btn.transform = CGAffineTransformIdentity;
            btn.frame = CGRectMake(btn.frame.origin.x +320, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
    
    [self.view removeGestureRecognizer:pan];
}
-(void)draging:(UIPanGestureRecognizer *)pan
{
    for (UIButton *btn in self.view.subviews) {
        //        [UIView animateWithDuration:10 animations:^{
        //            btn.frame = CGRectMake(btn.frame.origin.x +320, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
        //        }];
        CGFloat tx = [pan translationInView:self.view].x;
        if (tx < 0) tx = 0;//不能往左拖
        // NSLog(@"%f",tx);
        //        for (UIButton *btn in bgBtn.subviews) {
        //            [UIView animateWithDuration:0.5 animations:^{
        //                btn.frame = CGRectMake(btn.frame.origin.x +tx, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
        //            }];
        //
        //
        //        }
        btn.transform = CGAffineTransformMakeTranslation(tx, 0);
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
