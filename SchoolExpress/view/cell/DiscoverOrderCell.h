//
//  expressCell.h
//  SchoolExpress
//
//  Created by zsh tony on 15-4-10.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpExpress.h"
#import "CampusFood.h"
#import "HelpClass.h"
@interface DiscoverOrderCell : UITableViewCell
//@property (nonatomic,strong)UIView *titleView;
//@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *feeImage;
@property (nonatomic,strong)UILabel *feeLabel;
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UILabel *nickNameLabel;
@property (nonatomic,strong)UILabel *PTimeLabel;
@property (nonatomic,strong)UILabel *firstLineLabel;
@property (nonatomic,strong)UILabel *firstLineTitle;
@property (nonatomic,strong)UILabel *secondLineTitle;
@property (nonatomic,strong)UILabel *secondLineLabel;
@property (nonatomic,strong)UILabel *forthLineTitle;
@property (nonatomic,strong)UILabel *forthLineLabel;
@property (nonatomic,strong)UILabel *thirdLineTitle;
@property (nonatomic,strong)UILabel *thirdLineLabel;
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,assign)CGFloat cellHeight;
@property (nonatomic,strong)HelpExpress *helpExpress;
@property (nonatomic,strong)CampusFood *campusFood;
@property (nonatomic,strong)HelpClass *helpClass;
@end
