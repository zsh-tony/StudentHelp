//
//  UIBTextViewCell.m
//  SchoolExpress
//
//  Created by zsh tony on 15-3-30.
//  Copyright (c) 2015年 zsh-tony. All rights reserved.
//

#import "UIBTextViewCell.h"

#define kHeightMargin 6
#define kTitleHeightMargin 7
#define kWidthMargin 3
#define kTitleWidth 63
#define kBContentHeight 45
#define kLContentHeight 30
#define kIcon 20
#define kTitleHeight 30
#define kTextViewFont [UIFont systemFontOfSize:14]
#define kLimitWords 30
@implementation UIBTextViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundColor = [UIColor brownColor];
        // Initialization code
        self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(kWidthMargin, kTitleHeightMargin+kWidthMargin, kIcon, kIcon)];
        self.iconView.image = [UIImage stretchImageWithName:@"navigationbar_pop_highlighted.png"];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kIcon+2*kWidthMargin, kTitleHeightMargin,kTitleWidth , 30 )];
        //self.titleLabel.text = @"取件时间:";
        //[self.titleLabel sizeToFit];
        self.titleLabel.font = kTextViewFont;
        //self.titleLabel.textColor = [UIColor lightGrayColor];

        self.contentText = [[UITextView alloc]initWithFrame:CGRectMake(kIcon+2*kWidthMargin+kTitleWidth, kHeightMargin, 320-kIcon-2*kWidthMargin-kTitleWidth-kHeightMargin-2*kWidthMargin, kBContentHeight)];
        self.placeholder = [[UILabel alloc]initWithFrame:CGRectMake(kHeightMargin, 2, 320-kIcon-2*kWidthMargin-kTitleWidth-kHeightMargin-2*kWidthMargin, kBContentHeight)];
        
        [self.contentText setScrollEnabled:NO];
        
        self.contentText.font = kTextViewFont;
        self.contentText.delegate = self;
        
        self.contentText.textColor = [UIColor blackColor];
        //[self.contentText sizeToFit];
        
        //self.placeholder = [[UILabel alloc]initWithFrame:CGRectMake(kIcon+4*kWidthMargin+kTitleWidth, kHeightMargin, 320-kIcon-2*kWidthMargin-kTitleWidth-kHeightMargin, kContentHeight)];
        self.placeholder.lineBreakMode = UILineBreakModeWordWrap;
        self.placeholder.numberOfLines = 0;
        
       
        self.placeholder.textColor = [UIColor lightGrayColor];
        self.placeholder.font = kTextViewFont;
        //[self.placeholder sizeToFit];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentText];
        [self.contentText addSubview:self.placeholder];
    }
    return self;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [[self tableView] setScrollEnabled:YES];
    if (_keyboardHeight) {
        _keyboardHeight();
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length] == 0)
    {
        [self.placeholder setHidden:NO];
    }
    if (textView.markedTextRange == nil && textView.text.length > kLimitWords) {
        textView.text = [textView.text substringToIndex:kLimitWords];
    }
    
}
- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    
    return (UITableView *)tableView;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    
    if(![text isEqualToString:@""]) {
        [self.placeholder setHidden:YES];
        
    }
    if ( [text isEqualToString:@"\n"] ) {
        //Do whatever you want
        if([textView.text isEqualToString:@""]) {
            [self.placeholder setHidden:NO];
            
        }
        if (_returnKey) {
            _returnKey(textView);
        }
        
        //如果不加这个，每次都会换行了
    }
    if (textView.text.length  >= kLimitWords && text.length > range.length) {
        return NO;
    }
    return YES;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
