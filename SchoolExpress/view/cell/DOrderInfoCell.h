//
//  DOrderInfoCell.h
//  SchoolExpress
//
//  Created by zsh tony on 15-5-6.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpExpress.h"
#import "CampusFood.h"
#import "HelpClass.h"
@interface DOrderInfoCell : UITableViewCell
@property (nonatomic,strong)UIImageView *feeImage;
@property (nonatomic,strong)UILabel *feeLabel;
@property (nonatomic,strong)UILabel *PTimeLabel;
@property (nonatomic,strong)UILabel *orderIdTitle;
@property (nonatomic,strong)UILabel *firstLineLabel;
@property (nonatomic,strong)UILabel *firstLineTitle;
@property (nonatomic,strong)UILabel *secondLineTitle;
@property (nonatomic,strong)UILabel *secondLineLabel;
@property (nonatomic,strong)UILabel *forthLineTitle;
@property (nonatomic,strong)UILabel *forthLineLabel;
@property (nonatomic,strong)UILabel *thirdLineTitle;
@property (nonatomic,strong)UILabel *thirdLineLabel;
@property (nonatomic,strong)HelpExpress *helpExpress;
@property (nonatomic,strong)CampusFood *campusFood;
@property (nonatomic,strong)HelpClass *helpClass;
@property (nonatomic,strong)UIButton *cancelOrderBtn;
@property (nonatomic,strong)UIButton *CompleteOrderBtn;
@property (nonatomic,strong)void (^presentCancelVC)(int tag);
@property (nonatomic,strong)void (^presentCompleteVC)();
@end
