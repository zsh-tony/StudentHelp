//
//  HomeViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-10.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "HomeViewController.h"
#import "SliderNavViewController.h"
#import "SelectSchViewController.h"
#import "sendRouteViewController.h"


#define kCHD @"长大"
#define kCount 4
#define kAdScrollviewFrame CGRectMake(0, 0, 320, 120)
#define kScrollviewHeight 200
#define kMiddleviewHeight 120

@interface HomeViewController ()
{

    UIScrollView *scrollview;
    UIPageControl *pageControl;
 

}
@end

@implementation HomeViewController

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
    self.view.backgroundColor =kGlobalBg;
    self.title = @"发现";

    //[self addMainBtn];
    [self addAdScrollerView];
    //[self addSelectSchBtn];
    
    //[self setNavigationTheme];
    

     
    
}
-(void)setNavigationTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    //navBar.backgroundColor = kGetColor(255, 114, 12);
   // [navBar setBackgroundImage:[UIImage imageNamed:@"orange1.png"] forBarMetrics:UIBarMetricsDefault];
    //控制器上面的导航栏会默认影响状态栏的颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //[navBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background.png"]]];
    [navBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor],
                                     UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero],
                                     UITextAttributeFont:[UIFont systemFontOfSize:20]}];
    
    
    NSString *icon = @"navigationbar_button_background.png";
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:[icon filenameAppend:@"_pushed"]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [barItem setBackgroundImage:[UIImage imageNamed:[icon filenameAppend:@"_disable"]] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    
    NSDictionary *barItemTextAttr =@{
                                     UITextAttributeTextColor:[UIColor whiteColor],
                                     UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero],
                                     UITextAttributeFont:[UIFont systemFontOfSize:13]};
    
    [barItem setTitleTextAttributes:barItemTextAttr forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:barItemTextAttr forState:UIControlStateHighlighted];
    
    [self.navigationController.navigationBar setTranslucent:NO];
}


//- (void)addSelectSchBtn
//{
//    // Do any additional setup after loading the view.
//  
//    
//     tag = 10;//便于后面实现selectsch
//    CGSize btnsize = CGSizeMake(50,30);
//    CGSize newBtnSize = CGSizeMake(75, 30);
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithBg:@"timeline_icon_more.png" title:kCHD size:btnsize target:self action:@selector(selectSchool)];
//    
//    selsch = [[SelectSchViewController alloc]init];
//     selecSchFrame = selsch.view.frame;
//    selsch.view.frame = CGRectMake(0, -568, 320, 568);
//    [self.view addSubview:selsch.view];
//    [self addChildViewController:selsch];
//    selsch.MaskViewPop = ^(){
//        [self selectSchool];
//    };
//    selsch.selectmidSchBlock = ^(int selmidsch,NSString *display){
//        [self selectSchool];
//        
//        if ([display isEqualToString:@"全部"]) {
//            
//            UIBarButtonItem *tmpitem = [UIBarButtonItem barButtonItemWithBg:nil title:kCHD size:btnsize target:self action:@selector(selectSchool)];
//            self.navigationItem.rightBarButtonItem = tmpitem;
//            
//            
//        }else{
//            
//            UIBarButtonItem *tmpitem = [UIBarButtonItem barButtonItemWithBg:@"common_button_white.png" title:[NSString stringWithFormat:@"%@%@",kCHD,display] size:newBtnSize target:self action:@selector(selectSchool)];
//            self.navigationItem.rightBarButtonItem = tmpitem;
//        }
//    };
//}
//-(void)selectSchool
//{
//    
//    if (tag == 10) {
//        [UIView animateWithDuration:0.2 animations:^{
//           // [self.view addSubview:selsch.view];
//            selsch.view.frame = selecSchFrame;
//            tmpTag = newTag;
//            newTag = tag;
//            tag = tmpTag;
//        }];
//        
//        
//    }else{
//        [UIView animateWithDuration:0.2 animations:^{
//            //[selsch.view removeFromSuperview];
//            selsch.view.frame = CGRectMake(0, -568, 320, 568);
//            tmpTag = newTag;
//            newTag = tag;
//            tag = tmpTag;
//        }];
//        
//    }
//    
//}
- (void)addAdScrollerView
{
    
    scrollview=[[UIScrollView alloc]init];
    //scrollview.frame= self.view.bounds;
    scrollview.frame = kAdScrollviewFrame;
   // NSLog(@"x-%f y-%F w-%F h-%f",scrollview.frame.origin.x,scrollview.frame.origin.y,scrollview.frame.size.width,scrollview.frame.size.height);
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled=YES;
    scrollview.delegate=self;
    scrollview.contentSize = CGSizeMake(kCount*scrollview.bounds.size.width, 0);
    [self.view addSubview:scrollview];
    for (int i=0; i<kCount; i++) {
        
        [self addImageViewAtIndex:i];
        
    }
    pageControl = [[UIPageControl alloc]init];
    pageControl.center = CGPointMake(scrollview.frame.size.width*0.5, scrollview.frame.size.height*0.9);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.numberOfPages = kCount;
    pageControl.userInteractionEnabled = NO;
    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point@2x.png"]];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point@2x.png"]];
    
    [self.view  addSubview:pageControl];
}

- (void)addImageViewAtIndex:(int)index
{
    CGSize viewSize = scrollview.frame.size;
    NSString *imagestr= [NSString stringWithFormat:@"new_%d.jpg",index+1];
    
    UIImageView *imageview =[[UIImageView alloc]initWithImage:[UIImage fullscreenImageWithName:imagestr]];
    imageview.frame=CGRectMake(index*viewSize.width, 0, viewSize.width, viewSize.height);
    //NSLog(@"%f",imageview.frame.origin.y);
    //NSLog(@"x-%f y-%F w-%F h-%f",imageview.frame.origin.x,imageview.frame.origin.y,imageview.frame.size.width,imageview.frame.size.height);
    [scrollview addSubview:imageview];
}

-(void)addMainBtn
{
    UIButton *sendRouteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendRouteBtn.frame = CGRectMake(5, 125, 125, 80);
    [sendRouteBtn setBackgroundColor:kGetColor(176, 244, 230)];
    [sendRouteBtn addTarget:self action:@selector(sendRoute) forControlEvents:UIControlEventTouchUpInside];
    sendRouteBtn.alpha = 0.8;
    [self.view addSubview:sendRouteBtn];
    
    UIButton *helpingBringBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    helpingBringBtn.frame = CGRectMake(135, 125, 185, 80);
    [helpingBringBtn setBackgroundColor:kGetColor(255, 99, 71)];
    [helpingBringBtn addTarget:self action:@selector(helpingBring) forControlEvents:UIControlEventTouchUpInside];
    helpingBringBtn.alpha = 0.8;
    [self.view addSubview:helpingBringBtn];
    

}
-(void)sendRoute
{
    sendRouteViewController *sendRoute = [[sendRouteViewController alloc]init];
    [self presentViewController:sendRoute animated:YES completion:nil];
    
}
-(void)helpingBring
{
   
    if (_whoHelp) {
        _whoHelp();
    }
    
}
-(void)bgBack:(UIButton *)sender
{
    [sender removeFromSuperview];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    NSLog(@"fsfd");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)addChildViewController:(UIViewController *)childController
//{
//    SliderNavViewController *nav = [[SliderNavViewController alloc]initWithRootViewController:childController];
//    
//    nav.delegate = self;
//    [super addChildViewController:nav];
//    
//}


#pragma mark scrollviewdelgate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControl.currentPage = scrollview.contentOffset.x/self.view.bounds.size.width;
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

@end
