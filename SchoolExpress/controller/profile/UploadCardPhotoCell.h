//
//  UploadCardPhotoCell.h
//  SchoolExpress
//
//  Created by lerrruby on 15/5/18.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadCardPhotoCell : UITableViewCell
@property (nonatomic,strong)UILabel *noteLabel;
@property (nonatomic,strong)UIImageView *IDFaceExample;
@property (nonatomic,strong)UIButton *IDFacePhoto;
@property (nonatomic,strong)UIImageView *IDBackExample;
@property (nonatomic,strong)UIButton *IDBackPhoto;
@property (nonatomic,strong)UIImageView *studentIDExample;
@property (nonatomic,strong)UIButton *studentIDPhoto;
@property (nonatomic,strong) void (^uploadIDFacePhoto)();
@property (nonatomic,strong) void (^uploadIDBackPhoto)();
@property (nonatomic,strong) void (^uploadStudentIDPhoto)();
@end
