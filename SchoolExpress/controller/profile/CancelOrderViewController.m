#import "CancelOrderViewController.h"
#define kWidthMargin 10
#define kHeightMargin 20
#define kIconX 30
#define KIconLength 20
#define kIconLabelLength 120
#define kNavbarHeight 64
#define kBgHeight 70
#define kLabelWidthMargin 10
#define kLabelHeightMargin 10
#define kOrderTitleWidth 70
#define kOrderHeight 15
#define kOrderTextWidth 80
#define kBtnHeight 30
#define kBtnWidth 250
#define kNoteImageLength 20
#define kNoteLabelHeight 40

#define kBtnFont [UIFont fontWithName:@"Helvetica-Bold" size:16]
#define kOrderFont [UIFont systemFontOfSize:14]
#define kLabelFont [UIFont systemFontOfSize:16]
@interface CancelOrderViewController ()
{
    UIView *navBar;
    
}
@end

@implementation CancelOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addNavBar];
        [self addSubViews];
    }
    
    return self;
}

- (void)addSubViews
{
    // Do any additional setup after loading the view.
    
    UIImageView *iconAccepted = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - KIconLength - kWidthMargin - kIconLabelLength)/2,kNavbarHeight + kHeightMargin, KIconLength, KIconLength)];
    iconAccepted.image = [UIImage imageNamed:@"对号.png"];
    [self.view addSubview:iconAccepted];
    
    _iconLabel = [[UILabel alloc]initWithFrame:CGRectMake(iconAccepted.frame.origin.x + iconAccepted.frame.size.width + kWidthMargin, iconAccepted.frame.origin.y, kIconLabelLength, KIconLength)];
    _iconLabel.text = @"成功取消订单!";
    _iconLabel.textColor = kGetColor(117, 114, 110);
    [self.view addSubview:_iconLabel ];
    
    UIView *contentBgView = [[UIView alloc]initWithFrame:CGRectMake(0, _iconLabel.frame.origin.y + _iconLabel.frame.size.height + kHeightMargin, self.view.frame.size.width, kBgHeight)];
    contentBgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:contentBgView];
    
    UILabel *orderNumberTitle = [[UILabel alloc]initWithFrame:CGRectMake(kLabelWidthMargin, kLabelHeightMargin, kOrderTitleWidth, kOrderHeight)];
    orderNumberTitle.text = @"订单单号:";
    orderNumberTitle.backgroundColor = [UIColor clearColor];
    orderNumberTitle.textColor = kGetColor(153, 153, 153);
    orderNumberTitle.font = kOrderFont;
    [contentBgView addSubview:orderNumberTitle];
    
    UILabel *orderNumberText = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - kLabelWidthMargin * 2 - kOrderTextWidth , orderNumberTitle.frame.origin.y, kOrderTextWidth, kOrderHeight)];
    orderNumberText.text = @"1561";
    orderNumberText.backgroundColor = [UIColor clearColor];
    orderNumberText.textColor = kTextColor;
    orderNumberText.font = kOrderFont;
    [contentBgView addSubview:orderNumberText];
    
    UIView *sepeator = [[UIView alloc]initWithFrame:CGRectMake(kLabelWidthMargin, orderNumberText.frame.origin.y + orderNumberText.frame.size.height + kLabelHeightMargin, self.view.frame.size.width, 1)];
    sepeator.backgroundColor = kSeperatorColor;
    //sepeator.alpha = 0.5;
    [contentBgView addSubview:sepeator];
    
    UILabel *orderEventTitle = [[UILabel alloc]initWithFrame:CGRectMake(kLabelWidthMargin, orderNumberText.frame.origin.y + orderNumberText.frame.size.height + 2*kLabelHeightMargin, kOrderTitleWidth, kOrderHeight)];
    orderEventTitle.text = @"订单主题:";
    orderEventTitle.backgroundColor = [UIColor clearColor];
    orderEventTitle.textColor = kGetColor(153, 153, 153);
    orderEventTitle.font = kOrderFont;
    [contentBgView addSubview:orderEventTitle];
    
    UILabel *orderEventText = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - kLabelWidthMargin * 2 - kOrderTextWidth , orderEventTitle.frame.origin.y, kOrderTextWidth, kOrderHeight)];
    orderEventText.text = @"取快递";
    orderEventText.backgroundColor = [UIColor clearColor];
    orderEventText.textColor = kTextColor;
    orderEventText.font = kOrderFont;
    [contentBgView addSubview:orderEventText];
    
    UIButton *checkOrderBtn = [[UIButton alloc]initWithFrame:CGRectMake(  (self.view.frame.size.width - kBtnWidth)/2,contentBgView.frame.size.height +contentBgView.frame.origin.y+ kLabelHeightMargin, kBtnWidth, kBtnHeight)];
    //[checkOrderBtn setBackgroundImage:[UIImage stretchImageWithName:@"方按钮黄小.png"] forState:UIControlStateNormal];
    checkOrderBtn.backgroundColor = kGetColor(250, 138, 37);
    checkOrderBtn.layer.cornerRadius = 5;
    checkOrderBtn.layer.opacity = 0.8;
    checkOrderBtn.titleLabel.font = kBtnFont;
    [checkOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [checkOrderBtn addTarget:self action:@selector(checkOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkOrderBtn];
    
    //    UIButton *continueAcceptBtn = [[UIButton alloc]initWithFrame:CGRectMake( 2* kLabelWidthMargin+checkOrderBtn.frame.size.width,contentBgView.frame.size.height +contentBgView.frame.origin.y+ kLabelHeightMargin, (self.view.frame.size.width - 3*kLabelWidthMargin)/2, kBtnHeight)];
    //    [continueAcceptBtn setBackgroundImage:[UIImage stretchImageWithName:@"方按钮绿小.png"] forState:UIControlStateNormal];
    //    [continueAcceptBtn setTitle:@"继续接单" forState:UIControlStateNormal];
    //    [continueAcceptBtn addTarget:self action:@selector(continueAccept) forControlEvents:UIControlEventTouchUpInside];
    //    continueAcceptBtn.titleLabel.font = kBtnFont;
    //    [self.view addSubview:continueAcceptBtn];
    
    _noteImage = [[UIImageView alloc]initWithFrame:CGRectMake(kLabelWidthMargin, checkOrderBtn.frame.origin.y + checkOrderBtn.frame.size.height + kHeightMargin, kNoteImageLength, kNoteImageLength)];
    _noteImage.image = [UIImage imageNamed:@"提示.png"];
    [self.view addSubview:_noteImage];
    
    _noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(_noteImage.frame.origin.x + _noteImage.frame.size.width + kLabelWidthMargin, _noteImage.frame.origin.y-kLabelHeightMargin, self.view.frame.size.width - 2*kLabelWidthMargin-2*kNoteImageLength, kNoteLabelHeight)];
    _noteLabel.backgroundColor = [UIColor clearColor];
    _noteLabel.textColor = kTextColor;
    _noteLabel.font = kOrderFont;
    _noteLabel.text = @"取消订单次数过多会降低你的人品值,请多多注意噢!";
    _noteLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    _noteLabel.numberOfLines = 0;
    [self.view addSubview:_noteLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.view.backgroundColor = kGetColor(240, 239, 237);
    
}
-(void)checkOrder
{
    
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"sdfsdfs");
        if (_popMydetailOrderVC) {
            _popMydetailOrderVC();
        }
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"presentMyOrderVC" object:nil];
    }];
    
}
- (void)addNavBar
{
	// Do any additional setup after loading the view.
    navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kNavbarHeight)];
    navBar.backgroundColor = kGetColor(250, 250, 250);
    [self.view addSubview:navBar];
    //    UIButton  *back = [UIButton buttonWithType:UIButtonTypeCustom];
    //    back.frame = CGRectMake(10, 30, 30, 20);
    //    [back setBackgroundImage:[UIImage imageNamed:@"navigationbar_back.png"] forState:UIControlStateNormal];
    //    [back addTarget:self action:@selector(Pop) forControlEvents:UIControlEventTouchUpInside];
    //    [navBar addSubview:back];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 25, 160, 34)];
    _titleLabel.text = @"取消订单";
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textAlignment =UIControlContentHorizontalAlignmentCenter;
    _titleLabel.textColor = kTextColor;
    
    UIView *sepeator = [[UIView alloc]initWithFrame:CGRectMake(0, kNavbarHeight, self.view.frame.size.width, 0.5)];
    sepeator.backgroundColor = kSeperatorDarkColor;
    sepeator.alpha = 0.5;
    [navBar addSubview:sepeator];
    //titleLabel.backgroundColor = [UIColor lightGrayColor];
    [navBar addSubview:_titleLabel];
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
