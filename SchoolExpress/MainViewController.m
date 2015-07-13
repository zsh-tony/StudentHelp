//
//  zshViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-10.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "MainViewController.h"
#import "Dock.h"
#import "DockItem.h"
#import "HelpBtnItem.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "MessageViewController.h"
#import "ProfileViewController.h"
#import "SliderNavViewController.h"
#import "HelpExpressViewController.h"
#import "CampusFoodViewController.h"
#import "OuterFoodViewController.h"
#import "HelpClassViewController.h"
#import "Account.h"
#import "AccountTool.h"
#import "loginViewController.h"
#import "LTBounceSheet.h"
//#import "HelpBtnViewController.h"

#define kCount 8
#define kBtnY 230
#define kBtnScrollviewFrame CGRectMake(0, 230, 320, 180)
#define kDockHeight 44
#define kContentFrame CGRectMake(0,0 , self.view.frame.size.width, self.view.frame.size.height - kDockHeight);
#define kDockFrame CGRectMake(0, self.view.frame.size.height-kDockHeight,self.view.frame.size.width , kDockHeight)
@interface MainViewController () <UIGestureRecognizerDelegate>
{
    Dock *dock;
    UIScrollView *scrollview;
    UIButton *bgBtn;
    UIPanGestureRecognizer *panRecognizer;
    ProfileViewController *profile;
    LTBounceSheet *requreHelpSheet;
}
@end



@implementation MainViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeHelpBtn:) name:@"removeHelpBtn" object:nil];

    //self.view.backgroundColor = [UIColor whiteColor];
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
//    tapRecognizer.numberOfTapsRequired = 1;
//    tapRecognizer.delegate = self;
//    [self.view addGestureRecognizer:tapRecognizer];
//    self.useBlurForPopup = YES;
       panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backBtn:)];
    [self addDock];
    
   [self creatChildControllers];
    [self selectedControllerAtIndex:0];
    //设置导航栏主题
    //[self setNavigationTheme];
   
    
}




- (void)addDock
{
    dock = [[Dock alloc]init];
   
    dock.frame = kDockFrame;
    [self.view addSubview:dock];
    [dock addItemWithIcon:@"iconfont-home.png" title:@"首页"];
    [dock addItemWithIcon:@"iconfont-message.png" title:@"消息"];
     DockItem *helpItem = [dock addItemWithIcon:@"requreHelp.png"     title:@"求助"];
    [dock addItemWithIcon:@"iconfont-discover.png" title:@"发现"];
    [dock addItemWithIcon:@"iconfont-profile.png" title:@"我的"];
    

     [helpItem setTitleColor:kGetColor(234,128,16) forState:UIControlStateNormal];
    helpItem.titleLabel.font = k11BordFont;

    dock.itemClickBlock = ^(int index){
        
        NSLog(@"index--%d",index);
        if (index != 4) {
            [self selectedControllerAtIndex:index];
        }else{


            [self addBlurBgBtn];
            
            for (int i=0; i<kCount; i++) {
                if (i==0) {
                    [self addHelpBtnWithIndex:i name:@"取快递"];
                }else if(i == 1){
                    [self addHelpBtnWithIndex:i name:@"食堂带饭"];
                }else if(i == 2){
                    [self addHelpBtnWithIndex:i name:@"校外带饭"];
                }else if(i == 3){
                    [self addHelpBtnWithIndex:i name:@"替上课"];
                }else if(i == 4){
                    [self addHelpBtnWithIndex:i name:@"去超市"];
                }else if(i == 5){
                    [self addHelpBtnWithIndex:i name:@"自定义"];
                }else if(i == 6){
                    [self addHelpBtnWithIndex:i name:@"打水"];
                }else
                {
                    [self addHelpBtnWithIndex:i name:@"更多"];
                }
            }

            
            //[self presentPopupViewController:helpBtn animated:YES completion:nil];
            
            
          }
        
    };
}

-(void)selectedControllerAtIndex:(int)index
{
    
    if (index == 0) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"orange2.png"] forBarMetrics:UIBarMetricsDefault];
        //[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        //[navBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background.png"]]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor],
                                         UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero],
                                         UITextAttributeFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]}];
    }else{
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"gray_navbar.png"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
        [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor blackColor],
                                         UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero],
                                         UITextAttributeFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    }
//    if (index == 3|| index== 1) {
//        if ([AccountTool sharedAccountTool].currentAccount.userId == nil) {
//            loginViewController *login = [[loginViewController alloc]init];
//            UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:login];
//            
//            [self presentViewController:loginNav animated:YES completion:nil];
//        }else{
//            SliderNavViewController *new = self.childViewControllers[index];
//            
//            if (new == _selectedController) return;
//            
//            [_selectedController.view removeFromSuperview];
//            
//            new.view.frame = kContentFrame;
//            
//            [self.view addSubview:new.view];
//            
//            _selectedController = new;
//        }
//    }else{
 
    SliderNavViewController *new = self.childViewControllers[index];
    
    if (new == _selectedController) return;
    
    [_selectedController.view removeFromSuperview];
    
    new.view.frame = kContentFrame;
    
    [self.view addSubview:new.view];
    
    _selectedController = new;
    //}
    
}

-(void)addChildViewController:(UIViewController *)childController
{
    SliderNavViewController *nav = [[SliderNavViewController alloc]initWithRootViewController:childController];
    
    nav.delegate = self;
    [super addChildViewController:nav];
    
}

//- (void)addBtnScrollerView
//{
//    
//    scrollview=[[UIScrollView alloc]init];
//    //scrollview.frame= self.view.bounds;
//    scrollview.frame = kBtnScrollviewFrame;
//    // NSLog(@"x-%f y-%F w-%F h-%f",scrollview.frame.origin.x,scrollview.frame.origin.y,scrollview.frame.size.width,scrollview.frame.size.height);
//    scrollview.showsHorizontalScrollIndicator = NO;
//    scrollview.pagingEnabled=YES;
//    scrollview.delegate=self;
//    scrollview.contentSize = CGSizeMake(2*scrollview.bounds.size.width, 0);
//    [bgBtn addSubview:scrollview];
//    for (int i=0; i<kCount; i++) {
//        if (i==0) {
//             [self addHelpBtnWithIndex:i name:@"取快递"];
//        }else if(i == 1){
//            [self addHelpBtnWithIndex:i name:@"去超市"];
//        }else if(i == 2){
//            [self addHelpBtnWithIndex:i name:@"打水"];
//        }else if(i == 3){
//            [self addHelpBtnWithIndex:i name:@"食堂带饭"];
//        }else if(i == 4){
//            [self addHelpBtnWithIndex:i name:@"校外带饭"];
//        }else if(i == 5){
//            [self addHelpBtnWithIndex:i name:@"更多"];
//        }else if(i == 6){
//            [self addHelpBtnWithIndex:i name:@"替上课"];
//        }else
//        {
//            [self addHelpBtnWithIndex:i name:@"自定义"];
//        }
//    }
//    
//}

- (void)addHelpBtnWithIndex:(int)index name:(NSString *)name
{
    CGSize viewSize = CGSizeMake(320, 200);
    HelpBtnItem *helpBtn = [HelpBtnItem buttonWithType:UIButtonTypeCustom];
    if (index > 5) {
        int row = index > 7? 1:0;
            helpBtn.frame=CGRectMake((index%3)*viewSize.width/3+viewSize.width,self.view.frame.size.height+row*(viewSize.height/2),viewSize.width/3, viewSize.height/2);
    }else{
        int row = index > 2? 1:0;
            helpBtn.frame=CGRectMake((index%3)*viewSize.width/3,self.view.frame.size.height + row*(viewSize.height/2), viewSize.width/3, viewSize.height/2);
    }
        if (index==0) {
            [helpBtn addTarget:self action:@selector(helpedExpress) forControlEvents:UIControlEventTouchUpInside];
              [helpBtn setImage:[UIImage imageNamed:@"取快递.png"] forState:UIControlStateNormal];
            [helpBtn setTitle:name forState:UIControlStateNormal];
        }else if(index == 1){
           [helpBtn setImage:[UIImage imageNamed:@"食堂带饭.png"] forState:UIControlStateNormal];
            [helpBtn addTarget:self action:@selector(helpedCampusFood) forControlEvents:UIControlEventTouchUpInside];
            [helpBtn setTitle:name forState:UIControlStateNormal];
        }else if(index == 2){
            [helpBtn setImage:[UIImage imageNamed:@"校外带饭.png"] forState:UIControlStateNormal];
            [helpBtn addTarget:self action:@selector(helpedOuterFood) forControlEvents:UIControlEventTouchUpInside];
            [helpBtn setTitle:name forState:UIControlStateNormal];
        }else if(index == 3){
             [helpBtn setImage:[UIImage imageNamed:@"替上课.png"] forState:UIControlStateNormal];
            [helpBtn addTarget:self action:@selector(helpedClass) forControlEvents:UIControlEventTouchUpInside];
            [helpBtn setTitle:name forState:UIControlStateNormal];
        }else if(index == 4){
            [helpBtn setImage:[UIImage imageNamed:@"去超市.png"] forState:UIControlStateNormal];
         
            [helpBtn addTarget:self action:@selector(helpedMarket) forControlEvents:UIControlEventTouchUpInside];
            [helpBtn setTitle:name forState:UIControlStateNormal];
        }else if(index == 6){
            [helpBtn setImage:[UIImage imageNamed:@"自定义.png"] forState:UIControlStateNormal];
            [helpBtn addTarget:self action:@selector(helpedWater) forControlEvents:UIControlEventTouchUpInside];
            [helpBtn setTitle:name forState:UIControlStateNormal];
        }else if(index == 5){
           [helpBtn setImage:[UIImage imageNamed:@"自定义.png"] forState:UIControlStateNormal];
            [helpBtn addTarget:self action:@selector(custom) forControlEvents:UIControlEventTouchUpInside];
            [helpBtn setTitle:name forState:UIControlStateNormal];
        }else{
            helpBtn.backgroundColor = [UIColor lightGrayColor];
            [helpBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
            [helpBtn setTitle:name forState:UIControlStateNormal];
        }
 
        //[requreHelpSheet addView:helpBtn];
        [self.blurBtn addSubview:helpBtn];


    

    
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            if (index > 5) {
                int row = index > 7? 1:0;
                helpBtn.frame=CGRectMake((index%3)*viewSize.width/3+viewSize.width,kBtnY+row*(viewSize.height/2), viewSize.width/3, viewSize.height/2);
                NSLog(@"btn的Y--%f",helpBtn.frame.origin.y);
            }else{
                int row = index > 2? 1:0;
                helpBtn.frame=CGRectMake((index%3)*viewSize.width/3,kBtnY + row*(viewSize.height/2), viewSize.width/3, viewSize.height/2);
            }
            
        } completion:nil];
    
        
    

    
    
}

-(void)removeHelpBtn:(NSNotification *)notification
{
    CGSize viewSize = CGSizeMake(320, 200);
    for (int i = 0; i< 7; i++) {
        HelpBtnItem *btn = self.blurBtn.subviews[i];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            if (i > 5) {
                int row = i > 7? 1:0;
                btn.frame=CGRectMake((i%3)*viewSize.width/3+viewSize.width,self.view.frame.size.height+row*(viewSize.height/2), viewSize.width/3, viewSize.height/2);
                NSLog(@"btn的Y--%f",btn.frame.origin.y);
            }else{
                int row = i > 2? 1:0;
                btn.frame=CGRectMake((i%3)*viewSize.width/3,self.view.frame.size.height + row*(viewSize.height/2), viewSize.width/3, viewSize.height/2);
            }
            
        } completion:^(BOOL finished) {
            if (i==6) {
                 [self.blurBtn removeFromSuperview];
            }
           
        }];
    }
    
}
-(void)helpedExpress
{
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"removeHelpBtn" object:nil];

    HelpExpressViewController *express = [[HelpExpressViewController alloc]init];
    [self presentViewController:express animated:YES completion:nil];
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
    for (UIButton *btn in self.blurBtn.subviews) {
        [UIView animateWithDuration:0.5 animations:^{
            btn.frame = CGRectMake(btn.frame.origin.x -320, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height);
        }];
        
     
    }
//    for (UIButton *btn in bgBtn.subviews) {
//        [UIView animateWithDuration:0.5 animations:^{
//            btn.transform = CGAffineTransformMakeTranslation(-320, 0);
//        }];
//
//    }
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
    
    for (UIButton *btn in self.blurBtn.subviews) {
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
    for (UIButton *btn in self.blurBtn.subviews) {
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
//- (void)dismissPopup {
//    if (self.popupViewController != nil) {
//        [self dismissPopupViewControllerAnimated:YES completion:^{
//            NSLog(@"popup view dismissed");
//        }];
//    }
//}
//
//#pragma mark - gesture recognizer delegate functions
//
//// so that tapping popup view doesnt dismiss it
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    return touch.view != self.popupViewController.view;
//}


-(void)creatChildControllers
{
   
    
    
    DiscoverViewController *discover = [[DiscoverViewController alloc]init];
    discover.changeToProfileVC = ^(){
        
        [self selectedControllerAtIndex:3];
        if (profile.pushMyOrderVC) {
            profile.pushMyOrderVC();
        }
        [[NSNotificationCenter defaultCenter]  postNotificationName:@"pushMyOrderVC" object:nil];
    };
    [self addChildViewController:discover];
    
    
    MessageViewController *message = [[MessageViewController alloc]init];
    
    [self addChildViewController:message];
    
    
    
    HomeViewController *home = [[HomeViewController alloc]init];
    home.whoHelp = ^(){
        
        //        WhoHelpViewController *who = [[WhoHelpViewController alloc]init];
        //
        //        [self presentPopupViewController:who animated:YES completion:nil];
        
        bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        bgBtn.frame = CGRectMake(0, 0, 320, 568);
        bgBtn.alpha = 0.95;
        bgBtn.backgroundColor = [UIColor whiteColor];
        [bgBtn addTarget:self action:@selector(bgBack:) forControlEvents:UIControlEventTouchUpInside];
        [UIView animateWithDuration:0.2 animations:^{
            [self.view insertSubview:bgBtn atIndex:[self.view subviews].count];
        } completion:^(BOOL finished) {
            for (int i=0; i<kCount; i++) {
                if (i==0) {
                    [self addHelpBtnWithIndex:i name:@"食堂带饭"];
                }else if(i == 1){
                    [self addHelpBtnWithIndex:i name:@"取快递"];
                }else if(i == 2){
                    [self addHelpBtnWithIndex:i name:@"打水"];
                }else if(i == 3){
                    [self addHelpBtnWithIndex:i name:@"上课"];
                }else if(i == 4){
                    [self addHelpBtnWithIndex:i name:@"校外带饭"];
                }else if(i == 5){
                    [self addHelpBtnWithIndex:i name:@"更多"];
                }else if(i == 6){
                    [self addHelpBtnWithIndex:i name:@"去超市购物"];
                }else
                {
                    [self addHelpBtnWithIndex:i name:@"自定义"];
                }
            }
            
        }];
        
    };
    [self addChildViewController:home];
   
    
    profile = [[ProfileViewController alloc]init];
    
    [self addChildViewController:profile];
    
}
-(void)bgBack:(UIButton *)sender
{
    [sender removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 导航控制器代理方法
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    


    
    UIViewController *root = navigationController.viewControllers[0];

    if (viewController != root) {
        
              //每当导航控制器即将显示一个子控制器的时候调用
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithIcon:@"navigationbar_back.png" target:self action:@selector(back)];
        //右边首页
        
        
        navigationController.view.frame = self.view.bounds;
        [dock removeFromSuperview];
        CGRect dockFrame = dock.frame;
        //改变dock的Y值，不改的话，添加是添加上去了，但是被遮住了
//        if ([root.view isKindOfClass:[UIScrollView class]]) {
//            UIScrollView *scrollview = (UIScrollView *)root.view;
//            dockFrame.origin.y = scrollview.contentOffset.y + root.view.frame.size.height - kDockHeight;
//        } else {
        if (viewController==navigationController.childViewControllers[1]) {
             dockFrame.origin.y -=64;
           
        }else if (viewController==navigationController.childViewControllers[2]) {
            dockFrame.origin.y +=64;
            
        }else if (viewController==navigationController.childViewControllers[3]) {
            dockFrame.origin.y -=64;
            
        }else if (viewController==navigationController.childViewControllers[4]) {
            dockFrame.origin.y +=64;
            
        }
           //因为home的view与self的viewY值不一样
       // }
        
        dock.frame = dockFrame;
        
        
        [root.view addSubview:dock];
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"gray_navbar.png"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        
        [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor blackColor],
                                                               UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero],
                                                               UITextAttributeFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]}];
       
    }else{
        
       
    }
            //}else{
//    
//            //dock.hidden = NO;
//    
//            navigationController.view.frame = kContentFrame;
            
           // dock.frame = kDockFrame;
            //[self.view addSubview:dock];
    
       //}
    //    如果这样的话，回来的时候还是不能同步，只能通过下面的方法。当它回来之后再添加进去
    
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    UIViewController *root = navigationController.viewControllers[0];
    if (viewController == root) {
        navigationController.view.frame = kContentFrame;
        [dock removeFromSuperview];

        dock.frame = kDockFrame;
        
        
        
        [self.view addSubview:dock];
    }
    
}

-(void)home
{
    
}
-(void)back
{
    [_selectedController popViewControllerAnimated:YES];
}

@end
