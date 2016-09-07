//
//  PopoverCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/4/13.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "PopoverCell.h"
#import "UIView+Frame.h"
#import "config.h"
@implementation PopoverCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self CreatUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    return  self;
}

-(void)CreatUI
{
    _imageView = [[UIImageView alloc]init];
    [self addSubview:_imageView];
    _textLabel = [[UILabel alloc]init];
    _textLabel.font = [UIFont systemFontOfSize:14.0f];
    [_textLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_textLabel];
    
    _lineView = [[UIView alloc]init];
    [_lineView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_lineView];
}

-(void)configUIWithText:(NSString *)text image:(UIImage *)image
{
    [_imageView setImage:image];
    [_textLabel setText:text];
    [self setViewsFrame];
}
-(void)setViewsFrame
{
    if(self.type == OnlyHaveText)
    {
        [_textLabel setFrame:CGRectMake(0, 0, KScreenWidth / 3, 44)];
    }
    else
    {
        [_imageView setFrame:CGRectMake(5, 5, 50, 50)];
        [_textLabel setFrame:CGRectMake(_imageView.right + 3, _imageView.top, self.width - _imageView.right - 6,self.height)];
    }
    [_lineView setFrame:CGRectMake(0, self.bottom-0.5,KScreenWidth ,0.5)];
}


@end
