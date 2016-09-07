//
//  reportsStatusView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "ReportsStatusView.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "Config.h"
@implementation ReportsStatusView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self CreatUI];
    }
    return  self;
}

-(void)CreatUI
{
    [self setBackgroundColor:RGB_COLOR(@"#FAFAFA")];
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.layer.masksToBounds = YES;
    [self addSubview:_imageView];
    
    _userNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(_imageView.right + 5, 2, self.width - _imageView.right, 20)];
    [_userNameLabel setFont:[UIFont fontWithName:@"Helvetica" size:16.0f]];
    [self addSubview:_userNameLabel];
    
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(_userNameLabel.left, _userNameLabel.bottom, self.width - _imageView.right - 5, 40)];
    _textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _textLabel.numberOfLines = 2;
    [_textLabel setTextColor:RGB_COLOR(@"#969696")];
    [_textLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    [self addSubview:_textLabel];
}
-(void)ConfigDataWith:(Statuses *)obj
{
    if( obj.retweeted_status.user)
    {
        NSString *picurl = obj.retweeted_status.thumbnail_pic?obj.retweeted_status.thumbnail_pic:obj.retweeted_status.user.profile_image_url;
        [_imageView sd_setImageWithURL:[NSURL URLWithString:[picurl stringByReplacingOccurrencesOfString:Kthumbnail withString:Kbmiddle]]];
        _userNameLabel.text =[ NSString stringWithFormat:@"@%@",obj.retweeted_status.user.name];
        _textLabel.text =obj.retweeted_status.text;
        return;
    }
    else
    {
        NSString * picurl = obj.thumbnail_pic?obj.thumbnail_pic:obj.user.profile_image_url;
        [_imageView sd_setImageWithURL:[NSURL URLWithString:[picurl stringByReplacingOccurrencesOfString:Kthumbnail withString:Kbmiddle]]];
        _userNameLabel.text =[ NSString stringWithFormat:@"@%@",obj.user.name];
        _textLabel.text =obj.text;
    }
   
}

@end
