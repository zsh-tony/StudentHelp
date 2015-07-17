//
//  MyInfoViewController.m
//  SchoolExpress
//
//  Created by zsh tony on 15-5-8.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyIconCell.h"
#import "UITextViewCell.h"
#import "UILabelCell.h"
#import "BigSelectSchViewController.h"
#import "AlterPhoneViewController.h"
#import "AlterPwdViewController.h"

@interface MyInfoViewController ()<UIAlertViewDelegate>
{
    UIActionSheet* imageSheet;
    UIImagePickerController *imagePicker;
    UIActionSheet* sexSheet;
    MyIconCell *myIconCell;
    UIlabelCell *sexCell;
    UIlabelCell *nickNameCell;
    UIAlertView *nickNameText;
    UIAlertView *changePhoneAlert;
    UIAlertView *changePhoneAlert2;
    
    UIlabelCell *campusCell;
    LPPopup *popup;
}

@end

@implementation MyInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)initTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.SectionFooterHeight =0;
    self.tableView.sectionHeaderHeight = 0;
    self.view.backgroundColor = kGetColor(240, 255, 230);
//    UIView *footer = [[UIView alloc]init];
//    footer.frame = CGRectMake(0, 0, 300, 70);
//    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
//    [send setAllStateBg:@"common_button_big_red.png"];
//    [send setTitle:@"退出当前账号" forState:UIControlStateNormal];
//    send.frame = CGRectMake(10, 10, 300, 44);//footview会自动延伸,处理方法，在底层加了个纯洁的uiview
//    [send addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
//    [footer addSubview:send];
//    self.tableView.tableFooterView = footer;
    [self.view addSubview:self.tableView];
}

#pragma UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex = [%d]",buttonIndex);
    
    if (actionSheet == sexSheet) {
        switch (buttonIndex) {
            case 0:
                sexCell.contentLabel.text = @"男";
                break;
            case 1:
                sexCell.contentLabel.text = @"女";
                break;
            default:
                break;
        }
       
    }else{
    switch (buttonIndex) {
        case 0://照相机
        {
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
            imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            }else{
                NSLog(@"没有摄像头");
            }
        }
            break;
        case 1://相册
        {
            imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                        //            [self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;

        default:
            break;
    }
    }
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(260, 7, 40, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelPick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:cancelBtn];
    [viewController.navigationItem setRightBarButtonItem:rightItem animated:NO];
   
}
-(void)cancelPick
{
    NSLog(@"sadf") ;
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:image afterDelay:0.5];
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)saveImage:(UIImage *)image {
    //    NSLog(@"保存头像！");
    //    [userPhotoButton setImage:image forState:UIControlStateNormal];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
    NSLog(@"imageFile->>%@",imageFilePath);
    success = [fileManager fileExistsAtPath:imageFilePath];
    if(success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
        UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    //UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93, 93)];
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    //    [userPhotoButton setImage:selfPhoto forState:UIControlStateNormal];
    
   // NSError *imageError = nil;
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 1.0f);
    Byte *bytes = (Byte*)[imageData bytes];
    
    NSLog(@"byte====%s",bytes);
    NSString *urlStr = [NSString stringWithFormat:@"http://202.117.77.156:8088/Favours/UploadImage?&userId=1"];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *Url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:Url];
    
    NSMutableString *body = [[NSMutableString alloc]init];
    
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //要上传的图片
  
    //http body的字符串


    
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"selfphoto.jpg\"\r\n"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:imageData];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [req setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
//    //设置http body
//    NSMutableData *data= [NSMutableData dataWithData:imageData];
//    //[data replaceBytesInRange:NSMakeRange(1, [data length]-2) withBytes:NULL];
    NSLog(@"image=%@",imageData);
//    NSLog(@"data=%@",data);
    [req setHTTPBody:myRequestData];
    //http method
    [req setHTTPMethod:@"POST"];
 
    NSLog(@"request=%@",req);
    
    NSHTTPURLResponse *response = nil;
    NSError *error0 =nil;
    NSData *responeData = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error0];
    // NSDictionary *testdict= [NSJSONSerialization JSONObjectWithData:responeData options:0 error:&jsonParseError];
    
    
    NSString *teststr = [[NSString alloc]initWithData:responeData encoding:NSUTF8StringEncoding];
    NSLog(@"返回的---%@",teststr);

    if ([teststr isEqualToString:@"success"]) {
        myIconCell.iconImage.image = selfPhoto;
        popup = [LPPopup popupWithText:@"上传成功!"];
       

    }else{
        popup = [LPPopup popupWithText:@"上传失败!"];
    }
    popup.popupColor = [UIColor blackColor];
    popup.alpha = 0.8;
    popup.textColor = [UIColor whiteColor];
    popup.font = kDetailContentFont;
    [popup showInView:self.view
        centerAtPoint:self.view.center
             duration:1.5f
           completion:nil];
    
}

// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    [self initTableView];
    
}
#pragma mark - uitableviewdelegate 的实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return     4;
    // Return the number of sections.
    //return data.count;
    //return dataArray.count;//控制有几行显示
}
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    
    return 20.0 ;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0&&indexPath.row == 0) {
        
            return 120;
        
        
        
    }else{
        return 44;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return 1;
    }else{
        return 2;
    }
    
    
    // Return the number of rows in the section.
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    if (indexPath.row == 0) {
        static NSString *CellIdentifier1 = @"myIconCell";
        myIconCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (myIconCell == nil) {
            myIconCell = [[MyIconCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier1] ;
        }
        myIconCell.selectionStyle = UITableViewCellSelectionStyleNone;
        myIconCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return myIconCell;
    }else{
        static NSString *CellIdentifier2 = @"sexCell";
        sexCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (sexCell == nil) {
            sexCell = [[UIlabelCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier2] ;
        }
        sexCell.selectionStyle = UITableViewCellSelectionStyleNone;
        sexCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        sexCell.titleLabel.text = @"性别 :";
        sexCell.contentLabel.text = @"男";
        return sexCell;
    }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString *CellIdentifier3 = @"myCell";
            nickNameCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier3];
            if (nickNameCell == nil) {
                nickNameCell = [[UIlabelCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier3] ;
            }
            nickNameCell.selectionStyle = UITableViewCellSelectionStyleNone;
            nickNameCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            nickNameCell.titleLabel.text = @"昵称 :";
            nickNameCell.contentLabel.text = @"阿邦";
            return nickNameCell;
        }else{
            static NSString *CellIdentifier4 = @"campusCell";
            campusCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier4];
            if (campusCell == nil) {
                campusCell = [[UIlabelCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier4] ;
            }
            campusCell.selectionStyle = UITableViewCellSelectionStyleNone;
            campusCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            campusCell.titleLabel.text = @"校区 :";
            campusCell.contentLabel.text = @"长安大学校本部";
            return campusCell;
        }
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            static NSString *CellIdentifier5 = @"trueNameCell";
            UIlabelCell *trueNameCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier5];
            if (trueNameCell == nil) {
                trueNameCell = [[UIlabelCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier5] ;
            }
            trueNameCell.selectionStyle = UITableViewCellSelectionStyleNone;
            trueNameCell.titleLabel.text = @"真实姓名 :";
            trueNameCell.contentLabel.text = @"小帅";
            return trueNameCell;
        }else{
            static NSString *CellIdentifier6 = @"phoneNumberCell";
            UIlabelCell *phoneNumberCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier6];
            if (phoneNumberCell == nil) {
                phoneNumberCell = [[UIlabelCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier6] ;
            }
            phoneNumberCell.selectionStyle = UITableViewCellSelectionStyleNone;
            phoneNumberCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            phoneNumberCell.titleLabel.text = @"电话 :";
            phoneNumberCell.contentLabel.text = @"13259807852";
            return phoneNumberCell;
        }

    }else{
        static NSString *CellIdentifier6 = @"alterpwdCell";
        UIlabelCell *alterpwdCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier6];
        if (alterpwdCell == nil) {
            alterpwdCell = [[UIlabelCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier6] ;
        }
        alterpwdCell.selectionStyle = UITableViewCellSelectionStyleNone;
        alterpwdCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        alterpwdCell.titleLabel.text = @"修改密码";
      
        return alterpwdCell;

    }
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSLog(@"sdfsf");
            
            imageSheet = [[UIActionSheet alloc]
                          initWithTitle:nil
                          delegate:self
                          cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                          otherButtonTitles:@"照相机",@"本地相册",nil];

            [imageSheet showInView:self.view];
        }else{
            sexSheet = [[UIActionSheet alloc]
                          initWithTitle:nil
                          delegate:self
                          cancelButtonTitle:@"取消"
                          destructiveButtonTitle:nil
                          otherButtonTitles:@"男",@"女",nil];
            
            [sexSheet showInView:self.view];

        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            nickNameText = [[UIAlertView alloc]init];
            nickNameText.alertViewStyle = UIAlertViewStylePlainTextInput;
            nickNameText.title = @"请输入新昵称";
            nickNameText.delegate = self;
            [nickNameText addButtonWithTitle:@"取消"];
            [nickNameText addButtonWithTitle:@"确定"];
            [nickNameText show];
        }else{
            BigSelectSchViewController *selectsch = [[BigSelectSchViewController alloc]init];
            __weak BigSelectSchViewController *weakSelf = selectsch;

            selectsch.selectmidSchBlock = ^(int selmidsch,NSString *display){
                [weakSelf.navigationController popViewControllerAnimated:YES];
                if ([display isEqualToString:@"全部"]) {
                    
                    campusCell.contentLabel.text = @"长安大学";
                    
                }else{
                    NSLog(@"%@",display);
                    campusCell.contentLabel.text = [NSString stringWithFormat:@"长安大学%@",display];
                    }
            };

     
            [self.navigationController pushViewController:selectsch animated:YES];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 1) {
            changePhoneAlert = [[UIAlertView alloc]initWithTitle:nil message:@"确定更改绑定号码吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [changePhoneAlert show];
            
        }
    }else{
        AlterPwdViewController *alterPwd = [[AlterPwdViewController alloc]init];
        [self.navigationController pushViewController:alterPwd animated:YES];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView ==  nickNameText) {
        if (buttonIndex == 1) {
            nickNameCell.contentLabel.text = [nickNameText textFieldAtIndex:0].text;
        }

    }

    else{
        AlterPhoneViewController  *alter = [[AlterPhoneViewController alloc]init];
        [self.navigationController pushViewController:alter animated:YES];
    }
    NSLog(@"%d",buttonIndex);
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

@end
