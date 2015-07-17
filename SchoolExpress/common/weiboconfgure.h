//存放微博应用的一些配置
//#define kAppKey @"2783540646"
//#define kAppSecret @"ca07a4fda7bedb05407e04394c2d7aa2"

#define kAppKey @"3469816565"
#define kAppSecret @"10a7941f4355cb14846fad683478c5a8"

#define kOauthURL  [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&display=mobile&response_type=code",kAppKey,kRedirectURL]

#define kRedirectURL @"http://"

#define kUid @"uid"
#define kAccessToken @"access_token"
#define kBaseUrl @"http://202.117.77.156:8088/Favours/"

#define kOrderClassUrl @"http://202.117.77.156:8088/Favours/OrderClass"

#define kOrderCampusFoodUrl @"http://202.117.77.156:8088/Favours/OrderCampusFood"
#define kGrabOrdersPath @"GrabOrders"

#define kApplyOrdersPath @"ApplyOrders"

#define kConfirmOrdersPath @"ConfirmOrders"

#define kRegistUserPath @"RegistUser"

#define kUploadImagePath @"UploadImage"

#define kOrderExpressUrl @"http://202.117.77.156:8088/Favours/OrderExpress"

#define kGrabOrdersUrl @"http://202.117.77.156:8088/Favours/GrabOrders"

#define kApplyOrdersUrl @"http://202.117.77.156:8088/Favours/ApplyOrders"

#define kConfirmOrdersUrl @"http://202.117.77.156:8088/Favours/ConfirmOrders"