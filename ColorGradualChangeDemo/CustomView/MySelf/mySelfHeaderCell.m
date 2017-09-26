//
//  mySelfHeaderCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/7/11.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "mySelfHeaderCell.h"
#import "UIView+Frame.h"
#import "Config.h"
#import "UIImageView+WebCache.h"
@implementation mySelfHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self CreatUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)CreatUI
{
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 50, 50)];
    [_headImage setBackgroundColor:[UIColor redColor]];
    _headImage.layer.cornerRadius = 25;
    _headImage.layer.masksToBounds = YES;
    [self addSubview:_headImage];
    
    _nameLa = [[UILabel alloc]initWithFrame:CGRectMake(_headImage.right + 3, _headImage.top + 5, 200, 16)];
    [_nameLa setFont:[UIFont systemFontOfSize:14.0f]];
    [self addSubview:_nameLa];
    
    _decriptionLa = [[UILabel alloc]initWithFrame:CGRectMake(_nameLa.left, _nameLa.bottom + 3, _nameLa.width, _nameLa.height)];
    [_decriptionLa setFont:[UIFont systemFontOfSize:12.0f]];
    [self addSubview:_decriptionLa];
    
    _VipImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.right - 60, 26, 50, 16)];
    [_VipImage setBackgroundColor:[UIColor purpleColor]];
//    [self addSubview:_VipImage];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _headImage.bottom + 5, self.width, 0.5)];
    _lineView.alpha = 0.5;
    [_lineView setBackgroundColor:[UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1]];
    [self addSubview:_lineView];
    
    _weiBoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_weiBoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _weiBoBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    _weiBoBtn.titleLabel.numberOfLines = 0;
    _weiBoBtn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:_weiBoBtn];
    
    _followBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_followBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _followBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    _followBtn.titleLabel.numberOfLines = 0;
    _followBtn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self addSubview:_followBtn];
    
    _fansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _fansBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    _fansBtn.titleLabel.numberOfLines = 0;
    _fansBtn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [_fansBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_fansBtn];
    
   
}

-(void)configData:(User *)user
{
    [_headImage sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url ]];
    _nameLa.text = user.name;
    _decriptionLa.text = !user.desc?@"简介:这家伙很懒,什么都没留下":user.desc;

    NSString * weiboBtnStr = [NSString stringWithFormat:@"%@\n微博",user.statuses_count];
    NSString *followBtnStr = [NSString stringWithFormat:@"%@\n关注",user.followers_count];
    NSString *fansBtnStr = [NSString stringWithFormat:@"%@\n粉丝", user.friends_count];
    [_weiBoBtn setTitle:weiboBtnStr forState:UIControlStateNormal];
    [_followBtn setTitle:followBtnStr forState:UIControlStateNormal];
    [_fansBtn setTitle:fansBtnStr forState:UIControlStateNormal];
    
}

-(void)setSubViewsFrame
{
    [_VipImage setFrame:CGRectMake(self.right - 60, 26, 60, 16)];
    [_lineView setFrame:CGRectMake(0, _headImage.bottom + 5, self.width, 0.5)];
    [_weiBoBtn setFrame:CGRectMake(self.left, _lineView.bottom, KScreenWidth/3, 40)];
    [_followBtn setFrame:CGRectMake(_weiBoBtn.right, _lineView.bottom, KScreenWidth/3, 40)];
    [_fansBtn setFrame:CGRectMake(_followBtn.right, _lineView.bottom, KScreenWidth/3, 40)];
    
    UIView  * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, KScreenWidth, 0.5)];
    [lineView setBackgroundColor:[UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:215.0f/255.0f alpha:1]];
    [self addSubview:lineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];}

@end
