//
//  HeadView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/30.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import "HeadView.h"
#import "UIImageView+WebCache.h"
#import "Config.h"
#import "GlobalHelper.h"
#import "UIView+Frame.h"
@implementation HeadView

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
    _backegroudImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image.jpg"]];
    _backegroudImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backegroudImageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin; //与superView的上边距保持一致
    [self addSubview:_backegroudImageView];
    
    _headImageView = [[UIImageView alloc]init];
    [_headImageView setBackgroundColor:[UIColor redColor]];
    _headImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin; // 与superView右边距保持一致
    _headImageView.layer.cornerRadius = 40;
    _headImageView.layer.masksToBounds = YES;
    [self addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc]init];
    [_nameLabel setTextAlignment:NSTextAlignmentCenter];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
    [self addSubview:_nameLabel];
    
    _lineView = [[UIView alloc]init];
    [_lineView setBackgroundColor:[UIColor whiteColor]
     ];
    [self addSubview:_lineView];
    
    _friendsLabel = [[UILabel alloc]init];
    [_friendsLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    _friendsLabel.textColor = [UIColor whiteColor];
    [_friendsLabel setText:@"关注  "];
    [self addSubview:_friendsLabel];
    
    _followsLabel =[[UILabel alloc]init];
    [_followsLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
     _followsLabel.textColor = [UIColor whiteColor];
    [_followsLabel setText:@"粉丝  "];
    [self addSubview:_followsLabel];
    
    _verifiedReasonLabel =[[UILabel alloc]init];
    [_verifiedReasonLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0f]];
    [_verifiedReasonLabel setTextAlignment:NSTextAlignmentCenter];
    _verifiedReasonLabel.lineBreakMode = NSLineBreakByTruncatingTail;
     _verifiedReasonLabel.textColor = [UIColor whiteColor];
    [self addSubview:_verifiedReasonLabel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_backegroudImageView setFrame:CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height)];
    CGFloat roation = self.frame.size.height - headImageheight;

        CGFloat headBtnWidth = 80;
        [_headImageView setFrame:CGRectMake((self.width /2 - 30), headImageheight - 175 +roation, headBtnWidth, headBtnWidth)];
        _headImageView.centerX = self.centerX;
        [_nameLabel setFrame:CGRectMake(self.width/2 - 100, _headImageView.bottom+ 3, 200, 16)];
        _headImageView.layer.cornerRadius =headBtnWidth/2;
        
        [_lineView  setFrame:CGRectMake(0, _nameLabel.bottom+2, 1, 14)];
        _lineView.centerX = self.centerX;
    
        [_friendsLabel setFrame:CGRectMake(_lineView.left - _friendsCountLableSize.width - 5, _lineView.top, _friendsCountLableSize.width, _friendsCountLableSize.height)];
        [_followsLabel setFrame:CGRectMake(_lineView.right + 5, _lineView.top, _followsCountLabelSzie.width, _followsCountLabelSzie.height)];
        [_verifiedReasonLabel setFrame:CGRectMake(0, _lineView.bottom+2 , self.width, 16)];
}

-(void)ConfigDataWithUserInfo:(User *)obj
{
    _nameLabel.text = obj.name;
    [_backegroudImageView sd_setImageWithURL:[NSURL URLWithString:obj.cover_image_phone] placeholderImage:[UIImage imageNamed:@"image.jpg"] completed:nil];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:obj.profile_image_url] placeholderImage:[UIImage imageNamed:@"headImage"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    NSString * friendsCount = [obj.friends_count intValue]>10000?[NSString stringWithFormat:@"%d万",[obj.friends_count intValue]%10000]:[NSString stringWithFormat:@"%d",[obj.friends_count intValue]];
    _friendsLabel.text = [_friendsLabel.text stringByAppendingString:friendsCount];
//   _friendsCountLableSize = [GlobalHelper boundingRectWithLable:_friendsLabel Size:CGSizeMake(MAXFLOAT, 14)];
    _friendsCountLableSize =[GlobalHelper boundingRectString:_friendsLabel.text Size:CGSizeMake(MAXFLOAT, 14) Font:14.0f];
    NSString * folloewsCount = [obj.followers_count intValue]>10000? [NSString stringWithFormat:@"%d万",[obj.followers_count intValue]%10000]:[NSString stringWithFormat:@"%d",[obj.followers_count intValue]];
    _followsLabel.text = [_followsLabel.text stringByAppendingString:folloewsCount];
    _followsCountLabelSzie = [GlobalHelper boundingRectString:_followsLabel.text Size:CGSizeMake(MAXFLOAT, 14) Font:14.0f];
    
    _verifiedReasonLabel.text = obj.verified_reason;
}



@end
