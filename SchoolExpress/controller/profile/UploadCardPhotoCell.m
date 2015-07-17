//
//  UploadCardPhotoCell.m
//  SchoolExpress
//
//  Created by lerrruby on 15/5/18.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "UploadCardPhotoCell.h"
#define kMargin 13.3
#define kPhotoLength 140
@implementation UploadCardPhotoCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, kMargin, 320-2*kMargin, 40)];
       // _noteLabel.textColor =
        _noteLabel.text = @"对焦使证件上得字体和照片清晰可见,以避免审核不通过";
        _noteLabel.font = k13Font;
        _noteLabel.numberOfLines = 0;
        //_noteLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        [self.contentView addSubview:_noteLabel];
        
        _IDFaceExample = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin,_noteLabel.frame.size.height + _noteLabel.frame.origin.y+ kMargin, kPhotoLength, kPhotoLength)];
        _IDFaceExample.image = [UIImage imageNamed:@"上传身份证.png"];
        [self.contentView addSubview:_IDFaceExample];
        
        UILabel *example1 = [[UILabel alloc]initWithFrame:CGRectMake(3, 5, 40, 10)];
        example1.font = k13Font;
        example1.backgroundColor = [UIColor clearColor];
        example1.text = @"示例一";
        [_IDFaceExample addSubview:example1];
        
        _IDBackExample = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, _IDFaceExample.frame.origin.y +_IDFaceExample.frame.size.height +kMargin, kPhotoLength , kPhotoLength)];
        _IDBackExample.image = [UIImage imageNamed:@"上传身份证.png"];
        [self.contentView addSubview:_IDBackExample];
        
        UILabel *example2 = [[UILabel alloc]initWithFrame:CGRectMake(3, 5, 40, 10)];
        example2.font = k13Font;
        example2.backgroundColor = [UIColor clearColor];
        example2.text = @"示例二";
        [_IDBackExample addSubview:example2];
        
        _studentIDExample = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, _IDBackExample.frame.origin.y +_IDBackExample.frame.size.height +kMargin, kPhotoLength , kPhotoLength)];
        _studentIDExample.image = [UIImage imageNamed:@"上传身份证.png"];
        [self.contentView addSubview:_studentIDExample];
        
        UILabel *example3 = [[UILabel alloc]initWithFrame:CGRectMake(3, 5, 40, 10)];
        example3.font = k13Font;
        example3.backgroundColor = [UIColor clearColor];
        example3.text = @"示例三";
        [_studentIDExample addSubview:example3];
        
        _IDFacePhoto = [[UIButton alloc]initWithFrame:CGRectMake(_IDFaceExample.frame.size.width +_IDFaceExample.frame.origin.x +kMargin, _IDFaceExample.frame.origin.y, kPhotoLength, kPhotoLength)];
        [_IDFacePhoto setBackgroundImage:[UIImage imageNamed:@"上传身份证.png"] forState:UIControlStateNormal];
        [_IDFacePhoto addTarget:self action:@selector(upIDFacePhoto) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_IDFacePhoto];
        
        _IDBackPhoto = [[UIButton alloc]initWithFrame:CGRectMake(_studentIDExample.frame.size.width +_studentIDExample.frame.origin.x +kMargin, kMargin+_IDFacePhoto.frame.size.height + _IDFacePhoto.frame.origin.y, kPhotoLength, kPhotoLength)];
        [_IDBackPhoto setBackgroundImage:[UIImage imageNamed:@"上传身份证反面.png"] forState:UIControlStateNormal];
        [_IDBackPhoto addTarget:self action:@selector(upIDBackPhoto) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_IDBackPhoto];

        _studentIDPhoto = [[UIButton alloc]initWithFrame:CGRectMake(_studentIDExample.frame.size.width +_studentIDExample.frame.origin.x +kMargin, kMargin+_IDBackPhoto.frame.size.height + _IDBackPhoto.frame.origin.y, kPhotoLength, kPhotoLength)];
        [_studentIDPhoto setBackgroundImage:[UIImage imageNamed:@"上传学生证.png"] forState:UIControlStateNormal];
        [_studentIDPhoto addTarget:self action:@selector(upStudentIDPhoto) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_studentIDPhoto];

    }
    return self;
}


-(void)upIDFacePhoto
{
    if (_uploadIDFacePhoto) {
        _uploadIDFacePhoto();
    }
}
-(void)upIDBackPhoto
{
    if (_uploadIDBackPhoto) {
        _uploadIDBackPhoto();
    }
}
-(void)upStudentIDPhoto
{
    if (_uploadStudentIDPhoto) {
        _uploadStudentIDPhoto();
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
