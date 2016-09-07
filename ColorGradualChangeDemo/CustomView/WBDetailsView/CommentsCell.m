//
//  CommentsCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/15.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "CommentsCell.h"
#import "Config.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "GlobalHelper.h"

@implementation CommentsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self CreatUI];
    }
    return  self;
}
-(void)CreatUI
{
    _imageView = [[UIImageView alloc]init];
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = 15.0f;
    [self.contentView addSubview:_imageView];
    
    _nameLabel = [[UILabel alloc]init];
    [_nameLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
    [self addSubview:_nameLabel];
    
    _timeLabel =[[UILabel alloc]init];
    [_timeLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
    _timeLabel.textColor = [UIColor grayColor];
    [self addSubview:_timeLabel];
    
    _contentLabel =[[YYLabel alloc]init];
    [_contentLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.numberOfLines = 0;
    [self addSubview:_contentLabel];
    
    _atitudesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_atitudesBtn setTitle:@"赞" forState:UIControlStateNormal];
    [_atitudesBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_atitudesBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];

    [self addSubview: _atitudesBtn];
    
    [GlobalHelper ShareInstance].selectedYYLabelRangeTextBlock=^(UIView * containerView, NSAttributedString * text, NSRange range, CGRect rect)
    {        NSString * str = [[text string] substringWithRange:range];
        UIAlertView * alertView= [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"点击了 %@", str] delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        [alertView show];
    };
}

-(void)ConfigData:(CommentsObj *)obj
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:obj.user.profile_image_url] placeholderImage:nil];
    _nameLabel.text = obj.user.name;
    _contentLabel.attributedText = [[NSAttributedString alloc]initWithString:obj.text];
    _contentLabel.attributedText = [[GlobalHelper  ShareInstance] setStr:_contentLabel.text WithColor:RGB_COLOR(@"#0099FF") WithFont:14.0f];
    _timeLabel.text = [GlobalHelper DateFormatter:obj.created_at];
    [self setViewsFrame];
}

-(void)setViewsFrame
{
    [_imageView setFrame:CGRectMake(5, 5, 30, 30)];
    
    CGSize nameSize = [GlobalHelper boundingRectString:_nameLabel.text Size:CGSizeMake(MAXFLOAT, 25) Font:12.0f];
    [_nameLabel setFrame:CGRectMake(_imageView.right + 5, _imageView.top, ceil(nameSize.width), ceil(nameSize.height))];

    
    CGSize timeSize = [GlobalHelper boundingRectString:_timeLabel.text Size:CGSizeMake(MAXFLOAT, 25) Font:12.0f];
    [_timeLabel setFrame:CGRectMake(_nameLabel.left, _nameLabel.bottom + 3, timeSize.width, ceil(timeSize.height))];
    
    CGSize contentSize = [GlobalHelper CalculateYYlabelHeightAttributedString:_contentLabel.attributedText Size:CGSizeMake(KScreenWidth - 45, MAXFLOAT)];
    [_contentLabel setFrame:CGRectMake(_timeLabel.left, _timeLabel.bottom + 3, ceilf(contentSize.width), ceil(contentSize.height))];
    [_atitudesBtn setFrame:CGRectMake(KScreenWidth - 35, 5, 15, 15)];
}
-(CGFloat)CellHeight
{
    return _contentLabel.bottom + 5;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
