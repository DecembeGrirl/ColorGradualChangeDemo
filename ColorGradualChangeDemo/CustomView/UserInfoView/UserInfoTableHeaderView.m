//
//  UserInfoTableHeaderView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/23.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "UserInfoTableHeaderView.h"
#import "Config.h"
#import "UIView+Frame.h"
@implementation UserInfoTableHeaderView

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
    self.userInteractionEnabled = YES;
    CGFloat btnwidth = 50;
    CGFloat btnHeight = 30;
    CGFloat space = 5;
    
    _homeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_homeBtn setFrame:CGRectMake((self.width-btnwidth*3 - 5*2 )/2, 5, btnwidth , btnHeight)];
    [_homeBtn setTitle:@"主页" forState:UIControlStateNormal];
    [_homeBtn addTarget:self action:@selector(HandleHomeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_homeBtn];
    
    _statusBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_statusBtn setFrame:CGRectMake(_homeBtn.right+ space , _homeBtn.top, _homeBtn.width, btnHeight)];
    [_statusBtn setTitle:@"微博" forState:UIControlStateNormal];
    [_statusBtn addTarget:self action:@selector(HandleStatusBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_statusBtn];
    
    _photoBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_photoBtn setFrame:CGRectMake(_statusBtn.right+space, _homeBtn.top, _homeBtn.width, btnHeight)];
    [_photoBtn setTitle:@"相册" forState:UIControlStateNormal];
    [_photoBtn addTarget:self action:@selector(HandlePhotoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_photoBtn];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(_statusBtn.left, _homeBtn.bottom, _homeBtn.width, 2)];
    [_lineView setBackgroundColor:[UIColor orangeColor]];
    [self addSubview:_lineView];
    [self FormtBtn];
}

//初始化 btn 的各属性
-(void)FormtBtn
{
    [_homeBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [_homeBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_statusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_statusBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [_photoBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_photoBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
}

-(void)HandleHomeBtn
{
    [UIView animateWithDuration:0.25 animations:^{
        [_lineView setFrame:CGRectMake(_homeBtn.left, _homeBtn.bottom, _homeBtn.width, 2)];
    }];
    [_homeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_statusBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    
    [_photoBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [self.delegate selectedUserInfoTableHeaderViewHomeBtn];
}

-(void)HandleStatusBtn
{
    [UIView animateWithDuration:0.25 animations:^{
        [_lineView setFrame:CGRectMake(_statusBtn.left, _homeBtn.bottom, _homeBtn.width, 2)];
    }];
    [_statusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_homeBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    
    [_photoBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [self.delegate selectedUserInfoTableHeaderViewWeiBoBtn];
    
}

-(void)HandlePhotoBtn
{
    [UIView animateWithDuration:0.25 animations:^{
        [_lineView setFrame:CGRectMake(_photoBtn.left, _homeBtn.bottom, _homeBtn.width, 2)];
    }];
    [_statusBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    
    [_homeBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    
    [_photoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.delegate selectedUserInfoTableHeaderViewPhotoBtn];
    
}
@end
