//
//  OauthViewController.m
//  weibo
//
//  Created by zsh tony on 14-7-27.
//  Copyright (c) 2014年 zsh-tony. All rights reserved.
//

#import "OauthViewController.h"
#import "weiboconfgure.h"
#import "Account.h"
#import "AccountTool.h"
#import "MainViewController.h"
@interface OauthViewController ()
{
    UIWebView *webview;
    NSString *code;
}

@end

@implementation OauthViewController

-(void)loadView
{
    webview = [[UIWebView alloc]init];
    self.view = webview;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kOauthURL]];
    
    [webview loadRequest:request];
    webview.delegate = self;
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:webview animated:YES];
    hud.labelText = @"正在加载中";
    
}
// http://localhost/#access_token=2.00Q6djwBsE94CD1945235925C6Qz4B&remind_in=115086&expires_in=115086&uid=1784036562

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:webview animated:YES];
}
//每次发送请求都会调用此方法
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSLog(@"%@",request.URL);
//    NSString *url = request.URL.absoluteString;//请求的全路径
//    NSRange range = [url rangeOfString:@"access_token"];
//    NSRange range1 =[url rangeOfString:@"code"];
//    if ([url rangeOfString:@"localhost"].length!=0) {
//        NSString *paramstring = [url substringFromIndex:range1.location];
//       
//        NSArray *param = [paramstring componentsSeparatedByString:@"?"];//切割字符串
//        NSLog(@"%@",param);
//        for (NSString *paramsttr in param) {
//            
//            NSArray *keyCodeValue = [paramsttr componentsSeparatedByString:@"="];
//            code = keyCodeValue[1];
//        }
//        
//  //      NSString *urlstrr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token?client_id=3469816565&client_secret=%@&grant_type=authorization_code",kAppSecret];
//                NSString *urlstrr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token?grant_type=authorization_code&client_id=3469816565&client_secret=%@&redirect_uri=http://&code=%@",kAppSecret,code];
//        NSLog(@"%@",urlstrr);
//        NSURL *url1 = [NSURL URLWithString:urlstrr];
//        
//        NSMutableURLRequest *request1 = [NSMutableURLRequest requestWithURL:url1];
//        [request1 setHTTPMethod:@"post"];
//        
//
//        [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//
//            if (data != nil && error == nil) {
//                // 解码
//                NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                
//                if ([[string stringWithBeliefStr:string] rangeOfString:@"access_token"].length!=0) {//判断字符串中有无某个字符串
//                    Account *account = [[Account alloc]init];
//                    NSArray *param = [[string stringWithBeliefStr:string] componentsSeparatedByString:@","];//切割字符串
//                    NSLog(@"sdfgdsfsf%@",param);
//                    for(NSString *paramstr in param)
//                    {
//                        NSArray *keyValue = [paramstr componentsSeparatedByString:@":"];
//                        NSString *key = keyValue[0];
//                        NSString *value = keyValue[1];
//                        
//                        if ([[key stringWithBeliefStr:key] isEqualToString:kAccessToken]) {
//                            account.accessToken = [value stringWithBeliefStr:value];
//                        }else if([[key stringWithBeliefStr:key] isEqualToString:kUid]){
//                            account.uid = [value stringWithBeliefStr:value];
//                        }
//                        
//                    }
//                    NSString *accessUrlstr = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@", account.accessToken, account.uid];
//                    NSURL *accessUrl = [NSURL URLWithString:accessUrlstr];
//                    //NSLog(@"%@",accessUrlstr);
//                    NSURLRequest *accessRequest = [NSURLRequest requestWithURL:accessUrl];
////                    NSURLRequest *accessRequest = [NSURLRequest requestWithPath:@"users/show.json" params:@{@"uid": account.uid}];
//                    //NSLog(@"%@",accessRequest);
//                    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:accessRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//                        //NSLog(@"%@",JSON);
//                        account.screenName = JSON[@"screen_name"];
//                        
//                        [[AccountTool sharedAccountTool]addAccount:account];//归档
//                         [MBProgressHUD hideAllHUDsForView:webview animated:YES];
//                        
//                        MainViewController *main = [[MainViewController alloc]init];
//                        
//                        self.view.window.rootViewController = main;
//                        
//                    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//                        
//                        NSLog(@"hghjhgkuyk%@",error);
//                         [MBProgressHUD hideAllHUDsForView:webview animated:YES];
//                        
//                    }];//初始化请求对象
//                    [operation start];//发送请求
//                }
//                
//            } else if (error == nil) {
//                NSLog(@"接收到空数据");
//            } else {
//                NSLog(@"网络请求错误%@", error.localizedDescription);
//            }
//        }];
//         return NO;
//    }
//    
//
    return  YES;
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
