//
//  InputLocationVC.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-19.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "InputLocationVC.h"
#define kRightCampusframe CGRectMake(5, 5, 44, 30)
@interface InputLocationVC ()
{
    UIView *navBar;
    UIToolbar * topView;//键盘上面toolbar
    NSString *campusStr;//传递三个地址用的临时字符串
    NSString *eventStr;
    NSString *numberStr;
}
@end

@implementation InputLocationVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    campusStr = @"本部";
    _campusArray = [NSMutableArray arrayWithObjects:@"本部",@"小寨",@"雁塔",@"渭水",nil];
    _eventArray = [NSMutableArray arrayWithObjects:@"自定义",@"超市",@"食堂",@"宿舍", nil];
    _numberArray = [NSMutableArray arrayWithObjects:@"自定义",@"1号",@"2号",@"3号",@"4号",nil];
    _marketArray = [NSMutableArray arrayWithObjects:@"自定义",@"百福乐", nil];
    self.view.backgroundColor = kGlobalBg;
     [self addNavBar];
     [self initPickerView];
    [self initlocationBar];
}
- (void)initlocationBar
{
    // Do any additional setup after loading the view.
    _locationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 44)];
    _locationBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_locationBar];
    UIView *head =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    head.backgroundColor = [UIColor blackColor];
    head.alpha =0.5;
    [_locationBar addSubview:head];
    UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 44, 320, 0.5)];
    foot.backgroundColor = [UIColor blackColor];
    foot.alpha = 0.2;
    [_locationBar addSubview:foot];
    UIButton *downArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    [downArrow setBackgroundImage:[UIImage imageNamed:@"timeline_icon_more.png"] forState:UIControlStateNormal];
    [downArrow setBackgroundImage:[UIImage imageNamed:@"timeline_icon_more.png"] forState:UIControlStateHighlighted];
    downArrow.frame = CGRectMake(50, 10, 24, 24);
    [_locationBar addSubview:downArrow];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    doneBtn.frame = CGRectMake(275, 0, 44, 44);
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [doneBtn addTarget:self action:@selector(doneBack) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_locationBar addSubview:doneBtn];
    
    _campusText = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, 270, 30)];
    _campusText.delegate =self;
    _campusText.inputAccessoryView = topView;
    _campusText.text = @"校区          宿舍楼号等具体方位";
    _campusText.font = [UIFont systemFontOfSize:14];
    _campusText.tag = 0;
    _campusText.textColor = [UIColor lightGrayColor];
    _campusText.inputView = _pickView;
    
    [_locationBar addSubview:_campusText];
}
-(void)doneBack
{
    NSString *backStr = [NSString stringWithFormat:@"%@%@",_campusText.text,_detailText.text];
    if (_selectedLocation) {
        _selectedLocation(backStr);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)initPickerView
{
    UIButton *barDoneBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    barDoneBtn.frame = CGRectMake(260, 7, 40, 30);
    [barDoneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [barDoneBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [barDoneBtn addTarget:self action:@selector(barDone) forControlEvents:UIControlEventTouchUpInside];
    UIButton *cancelBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(260, 7, 40, 30);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(barCancel) forControlEvents:UIControlEventTouchUpInside];
    
    topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButtonItem = [[UIBarButtonItem alloc]initWithCustomView:barDoneBtn];
    UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:cancelButton,btnSpace,doneButtonItem,nil];
    [topView setItems:buttonsArray];
    
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 312, 320, 216)];
    _pickView.backgroundColor = [UIColor lightGrayColor];
    _pickView.delegate = self;
    _pickView.dataSource = self;
}

-(void)barDone
{
    _campusText.text = campusStr;
    _campusText.frame = kRightCampusframe;
    _campusText.textColor = [UIColor blackColor];
    _detailText = [[UITextView alloc]initWithFrame:CGRectMake(75, 5, 200, 30)];
    _detailText.delegate =self;
    _detailText.inputAccessoryView = topView;
    if ([eventStr isEqualToString:@"自定义"]) {
        eventStr = @"   ";
    }
    if ([numberStr isEqualToString:@"自定义"]) {
        numberStr = @"   ";
    }
    _detailText.text = [NSString stringWithFormat:@"%@ %@ ",numberStr,eventStr];
    _detailText.font = [UIFont systemFontOfSize:14];
    _detailText.tag = 0;
    _detailText.textColor = [UIColor blackColor];
    //_detailText.inputView = _pickView;
    //[_detailText setEditable:NO];
    [_locationBar addSubview:_detailText];
     [[UIApplication sharedApplication].keyWindow endEditing:YES];

}
-(void)barCancel
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
- (void)addNavBar
{
	// Do any additional setup after loading the view.
    navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navBar.backgroundColor = kGetColor(245, 245, 245);
    [self.view addSubview:navBar];
    UIButton  *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(10, 30, 30, 20);
    [back setBackgroundImage:[UIImage imageNamed:@"navigationbar_back.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(Pop) forControlEvents:UIControlEventTouchUpInside];
    [navBar addSubview:back];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 25, 160, 34)];
    titleLabel.text = @"输入详细地址";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment =UIControlContentHorizontalAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    //titleLabel.backgroundColor = [UIColor lightGrayColor];
    [navBar addSubview:titleLabel];
}
-(void)Pop
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - uitextviewdelegate实现
#pragma mark 控制textview的光标的位置
- (void)textViewDidChangeSelection:(UITextView *)textView

{
    if (textView == _campusText) {
        NSRange range;
        
        range.location = 0;
        
        range.length = 0;
        
        textView.selectedRange = range;

    }
    
}
#pragma mark - UIPickerView的数据源方法
#pragma mark 返回第component列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.campusArray.count;
    }else if (component == 1) {
        return self.eventArray.count;
    }else{
        if ([pickerView selectedRowInComponent:1] == 1) {
            return self.marketArray.count;
        }else if ([pickerView selectedRowInComponent:1] == 0){
            return 1;
        }
        return self.numberArray.count;
    }

  // return component == 0 ? self.oneCol.count : self.twoCol.count;
}

#pragma mark 返回UIPickerView的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

#pragma mark - UIPickerView的代理方法
#pragma mark 返回第component列第row行显示的字符串数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    { // 如果是第0列，返回oneCol数组中第row行的数据
        return self.campusArray[row];
    }else if(component == 1)
    {
        return self.eventArray[row];
    }else {
        if ([pickerView selectedRowInComponent:1] == 1) {
            return self.marketArray[row];
        }else if ([pickerView selectedRowInComponent:1] == 0){
            return @"自定义";
        }
       return self.numberArray[row];

        // 如果是第1列，返回twoCol数组中第row行的数据
        
    }
    //return @"hahahha";
}

#pragma mark 选中了某一行就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 如果选中了第0列
    if (component == 0)
    {
        // 取出第0列第row行的数据
       campusStr = self.campusArray[row];
        
        // 获得第1列当前选中的行号
        int Row1 = [pickerView selectedRowInComponent:1];
        
        // 取得第1列第rightRow行的数据
        eventStr = self.eventArray[Row1];
        
        int Row2 = [pickerView selectedRowInComponent:2];
        if (Row1 == 1) {
            numberStr = self.marketArray[Row2];
        }else{
        numberStr = self.numberArray[Row2];
        }
      
        
    } else if(component == 1){
        // 如果选中了第1列
        
            [pickerView reloadAllComponents];
        
        eventStr = self.eventArray[row];
        
        // 获得第0列当前选中的行号
        int Row0 = [pickerView selectedRowInComponent:0];
        
        //
        campusStr = self.campusArray[Row0];
        
        int Row2 = [pickerView selectedRowInComponent:2];
        
        if (row == 1) {
            numberStr = self.marketArray[Row2];
        }else{
            numberStr = self.numberArray[Row2];
        }

        
       
    }else{
        int Row1 = [pickerView selectedRowInComponent:1];
        
        eventStr = self.eventArray[Row1];
        
        if (Row1 == 1) {
            numberStr = self.marketArray[row];
        }else{
            numberStr = self.numberArray[row];
        }

        
        
        // 获得第0列当前选中的行号
        int Row0 = [pickerView selectedRowInComponent:0];
        
        //
        campusStr = self.campusArray[Row0];
        
        
        
    
    }
    //NSLog(@"-------row=%d, col=%d", row, component);
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
