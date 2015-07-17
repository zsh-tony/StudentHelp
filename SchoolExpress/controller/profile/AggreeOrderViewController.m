#import "AggreeOrderViewController.h"
#define kWidthMargin 10
#define kHeightMargin 20
#define kIconX 30
#define KIconLength 20
#define kIconLabelLength 200
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
@interface AggreeOrderViewController ()
{
    UIView *navBar;
    
}
@end

@implementation AggreeOrderViewController

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
    [self addNavBar];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kGetColor(240, 239, 237);
    UIImageView *iconAccepted = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - KIconLength - kWidthMargin - kIconLabelLength)/2,kNavbarHeight + kHeightMargin, KIconLength, KIconLength)];
    iconAccepted.image = [UIImage imageNamed:@"对号.png"];
    [self.view addSubview:iconAccepted];
    
    UILabel *iconLabel = [[UILabel alloc]initWithFrame:CGRectMake(iconAccepted.frame.origin.x + iconAccepted.frame.size.width + kWidthMargin, iconAccepted.frame.origin.y, kIconLabelLength, KIconLength)];
    iconLabel.text = @"成功确认!正在等待小伙伴好消息!";
    iconLabel.textColor = kGetColor(117, 114, 110);
    [self.view addSubview:iconLabel ];
    
    UIView *contentBgView = [[UIView alloc]initWithFrame:CGRectMake(0, iconLabel.frame.origin.y + iconLabel.frame.size.height + kHeightMargin, self.view.frame.size.width, kBgHeight)];
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
    
    
    UIImageView *noteImage = [[UIImageView alloc]initWithFrame:CGRectMake(kLabelWidthMargin, checkOrderBtn.frame.origin.y + checkOrderBtn.frame.size.height + kHeightMargin, kNoteImageLength, kNoteImageLength)];
    noteImage.image = [UIImage imageNamed:@"提示.png"];
    [self.view addSubview:noteImage];
    
    UILabel *noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(noteImage.frame.origin.x + noteImage.frame.size.width + kLabelWidthMargin, noteImage.frame.origin.y-kLabelHeightMargin, self.view.frame.size.width - 2*kLabelWidthMargin-2*kNoteImageLength, kNoteLabelHeight)];
    noteLabel.backgroundColor = [UIColor clearColor];
    noteLabel.textColor = kTextColor;
    noteLabel.font = kOrderFont;
    noteLabel.text = @"确认消息已通过短信提醒通知接单者,";
    noteLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    noteLabel.numberOfLines = 0;
    [self.view addSubview:noteLabel];
    
    
}
-(void)checkOrder
{
    
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"sdfsdfs");
        if (_popMydetailOrderVC) {
            _popMydetailOrderVC();
        }
        
    }];
    
}
- (void)addNavBar
{
	// Do any additional setup after loading the view.
    navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kNavbarHeight)];
    navBar.backgroundColor = kGetColor(250, 250, 250);
    [self.view addSubview:navBar];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 25, 160, 34)];
    titleLabel.text = @"取消订单";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment =UIControlContentHorizontalAlignmentCenter;
    titleLabel.textColor = kTextColor;
    
    UIView *sepeator = [[UIView alloc]initWithFrame:CGRectMake(0, kNavbarHeight, self.view.frame.size.width, 0.5)];
    sepeator.backgroundColor = kSeperatorDarkColor;
    sepeator.alpha = 0.5;
    [navBar addSubview:sepeator];

    [navBar addSubview:titleLabel];
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
