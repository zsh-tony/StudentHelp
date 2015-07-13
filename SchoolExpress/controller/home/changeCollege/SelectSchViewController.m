//
//  SelectSchViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-12.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "SelectSchViewController.h"
#import "SelectSchCell.h"
#import "ChangeCityViewController.h"
#import "ChangeSchViewController.h"

#import "SchBtnView.h"

#define kScrollviewHeight 200
#define kMiddleviewHeight 120
#define ktempHeight 64
#define kSchBtnHeight 30
#define kSchBtnMargin 20
@interface SelectSchViewController ()
{
    NSArray *btnArrayData;
    ChangeCityViewController *changeCityViewControl;
    UIButton *schBtn;
    UIButton *cityBtn;
    NSMutableArray *collegeArray;
    NSString *newCollege;
    
}
@end

@implementation SelectSchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)addScrollView
{
    //    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 320, kScrollviewHeight)];
    //    SchBtnView *btnview = [[SchBtnView alloc]init];
    //    btnview.btnArray = btnArrayData;
    //    scrollview.delegate = self;
    //    scrollview.contentSize = [SchBtnView btnSizeWidthCount:btnArrayData.count];
    //    scrollview.delaysContentTouches = NO;
    ////    CGSize btnviewsize = [SchBtnView btnSizeWidthCount:btnArrayData.count];
    ////    CGRect frame = scroview.frame;
    ////    frame = CGRectMake(0,44,btnviewsize.width,btnviewsize.height) ;
    ////    scroview.frame = frame;
    //    [scrollview addSubview:btnview];
    //    [self.view addSubview:scrollview];
    _scrollview = [[SchBtnScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, kScrollviewHeight)];
    _scrollview.defaultsch = 3;
    _scrollview.btnArray = btnArrayData;
    
    //NSLog(@"%d",_scrollview.defaultsch);
    _scrollview.selectSchBlock = ^(int selectSch,NSString *display){
        //1、传递defaultsch参数
        if (_selectmidSchBlock) {
            _selectmidSchBlock(selectSch,display);
            
        }
    };
    [_scrollview setBackgroundColor:kGetColor(243, 241, 230)];
    _scrollview.delegate = self;
    _scrollview.delaysContentTouches = NO;
    _scrollview.contentSize = [SchBtnScrollView btnSizeWidthCount:btnArrayData.count];
    //NSLog(@"%f",_scrollview.frame.size.height);
   // NSLog(@"%f",_scrollview.frame.origin.y);
    [self.view addSubview:_scrollview];
}

- (void)addOtherView
{
    //self.view.alpha = 0.2;
    //    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 256)];
    //    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    tableview.delegate = self;
    //    tableview.dataSource = self;
    //    [self.view addSubview:tableview];
    CGRect scrollviewFrame = _scrollview.frame;
    _middleView = [[UIView alloc]initWithFrame:CGRectMake(0, scrollviewFrame.size.height, 320, kMiddleviewHeight)];
    _middleView.backgroundColor = kGetColor(243, 241, 230);
    UIView *seperatorView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, 280, 1)];
    seperatorView.backgroundColor = kGetColor(220, 220, 220);
    [_middleView addSubview:seperatorView];
    
    schBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    schBtn.frame = CGRectMake(kSchBtnMargin, kSchBtnMargin, 280, kSchBtnHeight);
    [schBtn setBackgroundImage:[UIImage stretchImageWithName:@"common_card_background.png"] forState:UIControlStateNormal];
    schBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [schBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [schBtn setTitle:@"当前学校：长大" forState:UIControlStateNormal];
    schBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    schBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [schBtn addTarget:self action:@selector(selectCollege) forControlEvents:UIControlEventTouchUpInside];
    [_middleView addSubview:schBtn];
    
    
    cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cityBtn.frame = CGRectMake(kSchBtnMargin, 2*kSchBtnMargin+kSchBtnHeight, 280, kSchBtnHeight);
    cityBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cityBtn setBackgroundImage:[UIImage stretchImageWithName:@"common_card_background.png"] forState:UIControlStateNormal];
    [cityBtn setTitle:@"当前城市：西安" forState:UIControlStateNormal];
    cityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    cityBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    [cityBtn addTarget:self action:@selector(selectCity) forControlEvents:UIControlEventTouchUpInside];
    [_middleView addSubview:cityBtn];
  
    
    
    [self.view addSubview:_middleView];
    
    
    
    
    CGFloat maskviewHeight = 568 - _middleView.frame.origin.y-_middleView.frame.size.height;
    UIButton *maskview = [[UIButton alloc]initWithFrame:CGRectMake(0, _middleView.frame.origin.y+_middleView.frame.size.height, 320, maskviewHeight)];
    maskview.alpha =0.2;
    maskview.backgroundColor = [UIColor blackColor];
    [maskview addTarget:self action:@selector(maskViewPop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:maskview];
}
-(void)maskViewPop
{
    if (_MaskViewPop) {
        _MaskViewPop();
    }
    
}
-(void)selectCollege
{
    ChangeSchViewController *changeCollegeController = [[ChangeSchViewController alloc]init];
    changeCollegeController.navBarTitle = cityBtn.currentTitle;
    changeCollegeController.changeCollegeBlock = ^(int changeCollege,NSString *display){
        
        for (NSDictionary *dict in collegeArray) {
            if ([dict objectForKey:display]) {
                 newCollege =   [dict objectForKey:display];
            }
        }
        
        [schBtn setTitle:[NSString stringWithFormat:@"当前学校：%@",newCollege] forState:UIControlStateNormal];
        //NSLog(@"%@",display);
    };
    [self presentViewController:changeCollegeController animated:YES completion:nil];
}
-(void)selectCity
{
    changeCityViewControl = [[ChangeCityViewController alloc]init];
    changeCityViewControl.navBarTitle = cityBtn.currentTitle;
    changeCityViewControl.changeCityBlock = ^(int changeCity,NSString *display){
        
        [cityBtn setTitle:[NSString stringWithFormat:@"当前城市：%@",display] forState:UIControlStateNormal];
        //NSLog(@"%@",display);
    };

    [self presentViewController:changeCityViewControl animated:YES completion:^(void){
        
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SwicthToChangeVC:) name:@"SwicthToChangeVC" object:nil];
    NSDictionary *dict1 = [NSDictionary dictionaryWithObject:@"长大" forKey:@"长安大学"];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObject:@"西交大" forKey:@"西安交通大学'"];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObject:@"西大" forKey:@"西北大学"];
    NSDictionary *dict4 = [NSDictionary dictionaryWithObject:@"西工大" forKey:@"西北工业大学"];
    NSDictionary *dict5 = [NSDictionary dictionaryWithObject:@"音乐学院" forKey:@"西安音乐学院"];
    collegeArray = [NSMutableArray arrayWithObjects:dict1,dict2,dict3,dict4,dict5,nil];
    btnArrayData = @[@"全部",@"本部",@"雁塔",@"小寨",@"渭水"];
    
    [self addScrollView];

    [self addOtherView];
    
    
}
-(void)SwicthToChangeVC:(NSNotification *)notification
{
    [self selectCollege];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 1;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
//(NSIndexPath *)indexPath
//{
//    static NSString *cellIdentifier = @"cell";
//    SelectSchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (cell ==nil) {
//        cell = [[SelectSchCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
//        
//    }
//    cell.btnArray = btnArrayData;
//    return cell;
//    
//}

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
