//
//  inputRoomVC.m
//  SchoolExpress
//
//  Created by zsh tony on 15-4-1.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "inputRoomVC.h"
#define kRightCampusframe CGRectMake(5, 5, 44, 30)
@interface inputRoomVC ()
{
    UIView *navBar;
    UIToolbar * topView;//键盘上面toolbar
    NSString *campusStr;//传递三个地址用的临时字符串
    NSString *buildingStr;
    NSString *floorStr;
    NSString *numberStr;
    NSString *backStr;
    int tag;
}
@end

@implementation inputRoomVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - 初始化
- (void)initData
{
    campusStr = @"本部";
    _campusArray = [NSMutableArray arrayWithObjects:@"本部",@"小寨",@"雁塔",@"渭水",nil];
    _buildingArray = [NSMutableArray arrayWithObjects:@"主楼A区",@"主楼B区",@"信息学院",@"八区教室", nil];
    _numberOneArray = [NSMutableArray arrayWithObjects:@"101",@"102",@"103",@"104",@"自定义",nil];
    _numberTwoArray = [NSMutableArray arrayWithObjects:@"201",@"202",@"203",@"204",@"自定义",nil];
    _numberThreeArray = [NSMutableArray arrayWithObjects:@"301",@"302",@"303",@"304",@"自定义",nil];
     _customArray = [NSMutableArray arrayWithObject:@"自定义"];
    _floorDict = [[NSMutableDictionary alloc]init];
    [_floorDict setObject:_numberOneArray forKey:@"一楼"];
 
    [_floorDict setObject:_numberTwoArray forKey:@"二楼"];

    [_floorDict setObject:_numberThreeArray forKey:@"三楼"];
    [_floorDict setObject:_customArray forKey:@"自定义"];

    _floorOneArray = [NSMutableArray arrayWithObjects:@"一楼",@"二楼",@"自定义",nil];
    _floorTwoArray = [NSMutableArray arrayWithObjects:@"一楼",@"二楼",@"三楼",@"自定义",nil];
    _floorThreeArray =[ NSMutableArray arrayWithObjects:@"一楼",@"二楼",@"自定义",nil];
    _floorFourArray = [NSMutableArray arrayWithObjects:@"一楼",@"二楼",@"三楼",@"自定义",nil];
   
    _buildingDict = [[NSMutableDictionary alloc]init];
    [_buildingDict setObject:_floorOneArray forKey:@"主楼A区"];

    [_buildingDict setObject:_floorTwoArray forKey:@"主楼B区"];

    [_buildingDict setObject:_floorThreeArray  forKey:@"信息学院"];

     [_buildingDict setObject:_floorFourArray  forKey:@"八区教室"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    self.view.backgroundColor = kGlobalBg;
    [self addNavBar];
    [self initPickerView];
    [self initlocationBar];
    tag = 0;
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
    _campusText.text = @"校区          教学楼、楼层、教室房间号";
    _campusText.font = [UIFont systemFontOfSize:14];
    _campusText.tag = 0;
    _campusText.textColor = [UIColor lightGrayColor];
    _campusText.inputView = _pickView;
    
    [_locationBar addSubview:_campusText];
}
-(void)doneBack
{
    if (![_campusText.text isEqualToString:@"校区          教学楼、楼层、教室房间号"]) {
        backStr = [NSString stringWithFormat:@"%@%@",_campusText.text,_detailText.text];
        if (_selectedLocation) {
            _selectedLocation(backStr);
        }
        
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
    _pickView.showsSelectionIndicator = YES;
}

-(void)barDone
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    _campusText.text = campusStr;
    _campusText.frame = kRightCampusframe;
    _campusText.textColor = [UIColor blackColor];
    _detailText = [[UITextView alloc]initWithFrame:CGRectMake(75, 5, 200, 30)];
    _detailText.delegate =self;
    _detailText.inputAccessoryView = topView;
    if ([floorStr isEqualToString:@"自定义"]) {
        floorStr = @"";
    }
    if ([numberStr isEqualToString:@"自定义"]) {
        numberStr = @"";
    }
    _detailText.text = [NSString stringWithFormat:@"%@ %@ %@ ", buildingStr,floorStr,numberStr];
    _detailText.font = [UIFont systemFontOfSize:14];
    _detailText.tag = 0;
    _detailText.textColor = [UIColor blackColor];
    //_detailText.inputView = _pickView;
    //[_detailText setEditable:NO];
    
    [_locationBar addSubview:_detailText];
    if (([floorStr isEqualToString:@""]||[numberStr isEqualToString:@""])&&tag == 0){
        [UIView animateWithDuration:0.5 animations:^{
            [_detailText becomeFirstResponder];
        }];
        tag =1;
    }
    
    
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
    titleLabel.text = @"在哪个教室";
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
        return self.buildingArray.count;
    }else if(component == 2){
        if([pickerView selectedRowInComponent:1] == 0) {
         
                return _floorOneArray.count;
        }else if([pickerView selectedRowInComponent:1] == 1){
            return _floorTwoArray.count;
        }else if([pickerView selectedRowInComponent:1] == 2){
            return _floorThreeArray.count;
        }else{
             return _floorFourArray.count;
        }
     
    }else{
        if([pickerView selectedRowInComponent:1] == 0||[pickerView selectedRowInComponent:1] == 2){
            if([pickerView selectedRowInComponent:2] == 0){
                return _numberOneArray.count;
            }else if([pickerView selectedRowInComponent:2] == 1){
                return _numberTwoArray.count;
            }else{
                return 1;
            }
        }else{
            
        if([pickerView selectedRowInComponent:2] == 0) {
            
            return _numberOneArray.count;
        }else if([pickerView selectedRowInComponent:2] == 1){
            return _numberTwoArray.count;
        }else if([pickerView selectedRowInComponent:2] == 2){
            return _numberThreeArray.count;
        }else{
            return 1;
        }

    
      }
    }
    
    // return component == 0 ? self.oneCol.count : self.twoCol.count;
}

#pragma mark 返回UIPickerView的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

#pragma mark - UIPickerView的代理方法
#pragma mark 返回第component列第row行显示的字符串数据
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    if (component == 0)
//    { // 如果是第0列，返回oneCol数组中第row行的数据
//        
//        return self.buildingArray[row];
//    }else if(component == 1)
//    {
//        return self.buildingArray[row];
//    }else if(component == 2){
//        if ([pickerView selectedRowInComponent:1] == 0) {
//            return _floorOneArray[row];
//        }else if ([pickerView selectedRowInComponent:1] == 1) {
//            return _floorTwoArray[row];
//        }else if ([pickerView selectedRowInComponent:1] == 2) {
//            return _floorThreeArray[row];
//        }else{
//            return _floorFourArray[row];
//        }
//
//    }else{
//        if ([pickerView selectedRowInComponent:2] == 0) {
//            return _numberOneArray[row];
//        }else if ([pickerView selectedRowInComponent:2] == 1) {
//            return _numberTwoArray[row];
//        }else{
//            return _numberThreeArray[row];
//        }
//    }
//}
//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    
//    
//    if (component == 0)
//    { // 如果是第0列，返回oneCol数组中第row行的数据
//
//        return [self transAttributedString:self.campusArray[row]];
//    }else if(component == 1)
//    {
//        NSLog(@"%@",[self transAttributedString:self.buildingArray[row]]);
//        return [self transAttributedString:self.buildingArray[row]];
//   
//    }else if(component == 2){
//        if ([pickerView selectedRowInComponent:1] == 0) {
//            return [self transAttributedString:_floorOneArray[row]];
//      
//        }else if ([pickerView selectedRowInComponent:1] == 1) {
//            return [self transAttributedString:self.floorTwoArray[row]];
//  
//        }else if ([pickerView selectedRowInComponent:1] == 2) {
//            return [self transAttributedString:self.floorThreeArray[row]];
//
//        }else{
//            return [self transAttributedString:self.floorFourArray[row]];
//       
//        }
//        
//    }else{
//        if ([pickerView selectedRowInComponent:2] == 0) {
//            return [self transAttributedString:self.numberOneArray[row]];
//     
//        }else if ([pickerView selectedRowInComponent:2] == 1) {
//            return [self transAttributedString:self.numberTwoArray[row]];
// 
//        }else{
//            return [self transAttributedString:self.numberThreeArray[row]];
//          
//        }
//    }
//}
//-(NSAttributedString *)transAttributedString:(NSString *)string
//{
//    UIFont *font = [UIFont fontWithName:@"Palatino-Roman" size:12];
//    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
//                                                                forKey:NSFontAttributeName];
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string
//                                                                     attributes:attrsDictionary];
//   //    UILabel *label =  [[UILabel alloc]initWithFrame:CGRectMake(60, 200, 100, 30)];
////    NSString *str = [NSString stringWithFormat:@"我们的加"];
////    label.text = str;
////    
////    NSAttributedString *String = [[NSAttributedString alloc] initWithString:string
////                                                                 attributes:attrsDictionary];
//    
//    return attrString;
//}
#pragma mark 选中了某一行就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    // 如果选中了第0列
    if (component == 0)
    {
        // 取出第0列第row行的数据
        campusStr = self.campusArray[row];
        
        // 获得第1列当前选中的行号
        int Row1 = (int)[pickerView selectedRowInComponent:1];
        
        // 取得第1列第rightRow行的数据
        buildingStr = self.buildingArray[Row1];
        
        int Row2 = (int)[pickerView selectedRowInComponent:2];
        if (Row1 == 1) {
            floorStr = self.floorOneArray[Row2];
        }else if (Row1 == 2){
            floorStr = self.floorTwoArray[Row2];
        }else if (Row1 == 2){
            floorStr = self.floorThreeArray[Row2];
            
        }else{
            floorStr = self.floorFourArray[Row2];
        }
        int Row3 = (int)[pickerView selectedRowInComponent:3];
        if (Row2 == 1) {
            numberStr = self.numberOneArray[Row3];
        }else if (Row2 == 2){
            numberStr = self.numberTwoArray[Row3];
        }else{
            numberStr = self.numberThreeArray[Row3];
        }
        
    } else if(component == 1){
        // 如果选中了第1列
        
        [pickerView reloadAllComponents];
        
        buildingStr = self.buildingArray[row];
        
        // 获得第0列当前选中的行号
        int Row0 = (int)[pickerView selectedRowInComponent:0];
        
        //
        campusStr = self.campusArray[Row0];
        
        int Row2 = (int)[pickerView selectedRowInComponent:2];
        
        if (row == 0) {
            floorStr = self.floorOneArray[Row2];
        }else if (row == 1) {
            floorStr = self.floorTwoArray[Row2];
        }else if (row == 2) {
            floorStr = self.floorThreeArray[Row2];
        }else{
            floorStr = self.floorFourArray[Row2];
        }
        int Row3 = (int)[pickerView selectedRowInComponent:3];
        
        if (Row2 == 0) {
            numberStr = self.numberOneArray[Row3];
        }else if (Row2 == 1) {
            numberStr = self.numberTwoArray[Row3];
        }else{
            numberStr = self.numberThreeArray[Row3];
        }
        
        
    }else if(component == 2){
        [pickerView reloadAllComponents];
        int Row1 = (int)[pickerView selectedRowInComponent:1];
        // 获得第0列当前选中的行号
        int Row0 = (int)[pickerView selectedRowInComponent:0];
        campusStr = self.campusArray[Row0];
        buildingStr = self.buildingArray[Row1];
        
        if (Row1 == 0) {
            floorStr = self.floorOneArray[row];
        }else if (Row1 == 1) {
            floorStr = self.floorTwoArray[row];
        }else if (Row1 == 2) {
            floorStr = self.floorThreeArray[row];
        }else{
            floorStr = self.floorFourArray[row];
        }
        
        
        int Row2 = (int)[pickerView selectedRowInComponent:3];
        if (Row1 == 0 || Row1 == 2) {
            if (row == 0) {
                numberStr = self.numberOneArray[Row2];
            }else if (row == 1) {
                numberStr = self.numberTwoArray[Row2];
                
            }else{
                numberStr = @"自定义";
            }
        }else{
            if (row == 0) {
                numberStr = self.numberOneArray[Row2];
            }else if (row == 1) {
                numberStr = self.numberTwoArray[Row2];
          
            }else if(row == 2){
                numberStr = self.numberThreeArray[Row2];
            }else{
                numberStr = @"自定义";
            }
        }
        
       
        
        
    }else{
        [pickerView reloadAllComponents];
        int Row0 = (int)[pickerView selectedRowInComponent:0];
        
        //
        campusStr = self.campusArray[Row0];
        int Row1 = (int)[pickerView selectedRowInComponent:1];
        
        buildingStr = self.buildingArray[Row1];
        
        NSMutableArray *floor =  [[NSMutableArray alloc]init];
        floor =  [_buildingDict objectForKey:buildingStr];
        
        int Row2 = (int) [pickerView selectedRowInComponent:2];
        floorStr = floor[Row2];
      
            numberStr = [_floorDict objectForKey:floorStr][row];
         
        
        
    }
    //NSLog(@"-------row=%d, col=%d", row, component);
}

-(UIView *)textTransToUIView:(NSString *)string withWidth:(CGFloat)width
{
   UILabel *myView =[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, width, 30)];
    
    myView.textAlignment = NSTextAlignmentCenter;
    
    myView.text =string;
    
    myView.font = [UIFont systemFontOfSize:16];         //用label来设置字体大小
    
    myView.backgroundColor = [UIColor clearColor];
    
    return myView;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    tag = 0;
    
    if (component == 0){ // 如果是第0列，返回oneCol数组中第row行的数据

        return [self textTransToUIView:_campusArray[row] withWidth:70];
    }else if(component == 1){
        return [self textTransToUIView:_buildingArray[row] withWidth:80];
    }else if(component == 2){
     
        if ([pickerView selectedRowInComponent:1] == 0) {
            
            return [self textTransToUIView:_floorOneArray[row] withWidth:50];
        }else if ([pickerView selectedRowInComponent:1] == 1) {
            return [self textTransToUIView:_floorTwoArray[row] withWidth:50];
        }else if ([pickerView selectedRowInComponent:1] == 2) {
            return [self textTransToUIView:_floorThreeArray[row] withWidth:50];
        }else{
            NSLog(@"复读生···");
             NSLog(@"%d---%d",component,row);
            return [self textTransToUIView:_floorFourArray[row] withWidth:50];
        }
        
    }else{
  
        if ([pickerView selectedRowInComponent:1] == 0||[pickerView selectedRowInComponent:1] == 2) {
            if ([pickerView selectedRowInComponent:2] == 0) {
                return [self textTransToUIView:_numberOneArray[row] withWidth:60];
            }else  if ([pickerView selectedRowInComponent:2] == 1) {
                return [self textTransToUIView:_numberTwoArray[row] withWidth:60];
            }else{
                return [self textTransToUIView:_customArray[0] withWidth:60];
            }
        }else{
            if ([pickerView selectedRowInComponent:2] == 0) {
                return [self textTransToUIView:_numberOneArray[row] withWidth:60];
            }else if ([pickerView selectedRowInComponent:2] == 1) {
                return [self textTransToUIView:_numberTwoArray[row] withWidth:60];
            }else if ([pickerView selectedRowInComponent:2] == 2) {
                return [self textTransToUIView:_numberThreeArray[row] withWidth:60];
            }else{
                return [self textTransToUIView:_customArray[0] withWidth:60];
            }
        }
        
    }
}



    
//    if (component == 0) {
//        
//       
//        return myView;
//        
//    }else if (component == 1) {
//        
//        myView =[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80, 30)];
//        
//        myView.textAlignment = NSTextAlignmentCenter;
//        
//        myView.text = [_buildingArray objectAtIndex:row];
//        
//        bStr = [_buildingArray objectAtIndex:row];
//        NSLog(@"dfgdfg%@",bStr);
//        
//        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
//        
//        myView.backgroundColor = [UIColor clearColor];
//        return myView;
//        
//    }else if (component == 2) {
//        
//        myView =[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80, 30)];
//        
//        myView.textAlignment = NSTextAlignmentCenter;
//        floorArray = [_buildingDict objectForKey:bStr];
//        
//        myView.text = [floorArray objectAtIndex:row];
//        
//        fStr = [floorArray objectAtIndex:row];
//        NSLog(@"%@",fStr);
//        
//        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
//        
//        myView.backgroundColor = [UIColor clearColor];
//        return myView;
//        
//    }else{
//        
//        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80, 30)];
//        
//        numberArray = [_floorDict objectForKey:fStr];
//        
//        myView.text = [numberArray objectAtIndex:row];
//        
//        myView.textAlignment = NSTextAlignmentCenter;
//        
//        myView.font = [UIFont systemFontOfSize:14];
//        
//        myView.backgroundColor = [UIColor clearColor];
//        return myView;
//        
//    }
    
    




- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component

{
    
    CGFloat componentWidth = 0.0;
    
    
    
    if (component == 2){
        
        componentWidth = 50; // 第一个组键的宽度
    
    }else if(component == 1){
        
        componentWidth = 60; // 第2个组键的宽度
    
    }else{
        componentWidth = 70;
    }
    
    return componentWidth;
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    
    return 40.0;
    
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
