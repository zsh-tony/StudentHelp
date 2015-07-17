#import "IdentyOauthViewController.h"
#import "UITextFieldCell.h"
#import "UploadCardPhotoCell.h"

@interface IdentyOauthViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    UITextFieldCell *nameCell;
    UITextFieldCell *identityNumCell;
    UploadCardPhotoCell *uploadPhotoCell;
    UIImagePickerController *IDFaceImagePicker;
     UIImagePickerController *IDBackImagePicker;
    UIImagePickerController *studentIDImagePicker;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation IdentyOauthViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc]initWithFrame:kTableViewFrame style:UITableViewStyleGrouped];
    self.title = @"申请认证";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight =0;
   // self.tableView.sectionHeaderHeight = 0;
    
    UIView *footer = [[UIView alloc]init];
    footer.frame = CGRectMake(0, 0, 300, 64);
    UIButton *send = [UIButton buttonWithType:UIButtonTypeCustom];
    [send setAllStateBg:@"common_button_big_red.png"];
    [send setTitle:@"提交" forState:UIControlStateNormal];
    send.frame = CGRectMake(10, 10, 300, 44);//footview会自动延伸,处理方法，在底层加了个纯洁的uiview
    [send addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:send];
    self.tableView.tableFooterView = footer;
    [self.view addSubview:self.tableView];
    
}
-(void)submit
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  
        return 40;
    
    
    
}
#pragma mark - uitableviewdelegate 的实现
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    //return data.count;
    return 2;//控制有几行显示
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }else{
        return 527;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 2;
    }else{
        return 1;
    }
    // Return the number of rows in the section.
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    if (section == 0) {
        return @"填写真实信息";
    }else{
        return  @"上传证件照片";
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"nameCell";
            nameCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
            if (nameCell == nil) {
                nameCell = [[UITextFieldCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier] ;
            }
            nameCell.selectionStyle = UITableViewCellSelectionStyleNone;
            nameCell.titleLabel.text = @"真实姓名:";
            nameCell.contentText.placeholder = @"请输入真实姓名";
            nameCell.contentText.delegate = self;
            nameCell.contentText.keyboardType = UIKeyboardTypeNamePhonePad;
            
            return nameCell;
            
        }else{
            static NSString *CellIdentifier = @"identityNumCell";
            identityNumCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
            if (identityNumCell == nil) {
                identityNumCell = [[UITextFieldCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier] ;
            }
            identityNumCell.selectionStyle = UITableViewCellSelectionStyleNone;
            identityNumCell.titleLabel.text = @"身份证号:";
            identityNumCell.contentText.placeholder = @"请输入身份证号";
            identityNumCell.contentText.delegate = self;
            identityNumCell.contentText.keyboardType = UIKeyboardTypeNamePhonePad;
            return identityNumCell;
        }
    }else{
        static NSString *CellIdentifier = @"uploadPhotoCell";
        uploadPhotoCell = [tableView                               dequeueReusableCellWithIdentifier:CellIdentifier];
        if (uploadPhotoCell == nil) {
            uploadPhotoCell = [[UploadCardPhotoCell alloc]initWithStyle:UITableViewCellStyleDefault                   reuseIdentifier:CellIdentifier] ;
        }
        __weak IdentyOauthViewController *weakSelf = self;
        __block UIImagePickerController *weakFace = IDFaceImagePicker;
        __block UIImagePickerController *weakBack = IDBackImagePicker;
        uploadPhotoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        uploadPhotoCell.uploadIDFacePhoto = ^(){
           
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
                weakFace = [[UIImagePickerController alloc] init];
                weakFace.delegate = weakSelf;
                weakFace.allowsEditing = YES;
                weakFace.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [weakSelf presentViewController:weakFace animated:YES completion:nil];
            }else{
                NSLog(@"没有摄像头");
            }

            
        };
        
        uploadPhotoCell.uploadIDBackPhoto = ^(){
            
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
                weakBack = [[UIImagePickerController alloc] init];
                weakBack.delegate = weakSelf;
                weakBack.allowsEditing = YES;
                weakBack.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [weakSelf presentViewController:weakBack animated:YES completion:nil];
            }else{
                NSLog(@"没有摄像头");
            }
            
            
        };

        __block UIImagePickerController *weakStudent = studentIDImagePicker;
        uploadPhotoCell.uploadStudentIDPhoto = ^(){
            
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
                weakStudent = [[UIImagePickerController alloc] init];
                weakStudent.delegate = weakSelf;
                weakStudent.allowsEditing = YES;
                weakStudent.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                [weakSelf presentViewController:weakStudent animated:YES completion:nil];
            }else{
                NSLog(@"没有摄像头");
            }
            
            
        };
        return uploadPhotoCell;
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
    if (IDFaceImagePicker != nil) {
        [IDFaceImagePicker dismissViewControllerAnimated:YES completion:nil];
    }
    if (IDBackImagePicker != nil) {
        [IDBackImagePicker dismissViewControllerAnimated:YES completion:nil];
    }
    if (studentIDImagePicker != nil) {
        [studentIDImagePicker dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //[self performSelector:@selector(saveImage: picker:)  withObject:image afterDelay:0.5];
    [self saveImage:image picker:picker];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)saveImage:(UIImage *)image picker:(UIImagePickerController *)picker
{
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
    //NSData *imageData = UIImageJPEGRepresentation(smallImage, 1.0f);
    
 
    
    if (picker == IDFaceImagePicker) {
        [uploadPhotoCell.IDFacePhoto setBackgroundImage:selfPhoto forState:UIControlStateNormal];
    }else if (picker == IDBackImagePicker) {
        [uploadPhotoCell.IDBackPhoto setBackgroundImage:selfPhoto forState:UIControlStateNormal];
    }else{
        [uploadPhotoCell.studentIDPhoto setBackgroundImage:selfPhoto forState:UIControlStateNormal];
    }
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
