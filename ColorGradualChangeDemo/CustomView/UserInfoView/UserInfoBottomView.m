//
//  UserInfoBottomView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/28.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "UserInfoBottomView.h"
#import "Config.h"
#import "UIView+Frame.h"
@implementation UserInfoBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:RGB_COLOR(@"#F3F3F3")];
        [self CreatUI];
    }
    return self;
}
-(void)CreatUI
{
    _followBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_followBtn setFrame:CGRectMake(0, 0, KScreenWidth/ 3, BottomToolViewHeight)];
//    _followBtn.tag = ReportsBtnTag;
    [_followBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [_followBtn addTarget:self action:@selector(HandleFollowBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_followBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
//    [_followBtn setImage:[UIImage imageNamed:@"toolbar_icon_retweet"] forState:UIControlStateNormal];
    [_followBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [_followBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [self addSubview:_followBtn];
    
    _chatBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    [_chatBtn setImage:[UIImage imageNamed:@"toolbar_icon_comment"] forState:UIControlStateNormal];
//    _chatBtn.tag = CommentsBtnTag;
    [_chatBtn addTarget:self action:@selector(HandleChatBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_chatBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
//    [_chatBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
//    [_chatBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_chatBtn setFrame:CGRectMake(_followBtn.right , _followBtn.top, KScreenWidth/ 3 , BottomToolViewHeight)];
    [_chatBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [self addSubview:_chatBtn];
    
    _hotBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_hotBtn setFrame:CGRectMake(_chatBtn.right, _followBtn.top, KScreenWidth/ 3 , BottomToolViewHeight)];
    [_hotBtn addTarget:self action:@selector(HandleHotBtn:) forControlEvents:UIControlEventTouchUpInside];
//    _attitudesBtn.tag = AttitudesBtnTag;
//    [_hotBtn setImage:[UIImage imageNamed:@"toolbar_icon_unlike"] forState:UIControlStateNormal];
    [_hotBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_hotBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [_hotBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_hotBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [self addSubview:_hotBtn];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(_followBtn.right, 10, 1, 20)];
    [lineView1 setBackgroundColor:RGB_COLOR(@"#d5d4d4")];
    [self addSubview:lineView1];
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(_chatBtn.right, 10, 1, 20)];
    [lineView2 setBackgroundColor:RGB_COLOR(@"#d5d4d4")];
    [self addSubview:lineView2];
}
-(void)ConfigUIWIthData:(User *)obj
{
    [_followBtn setTitle:@"已关注" forState:UIControlStateNormal];
    [_chatBtn setTitle:@"聊天" forState:UIControlStateNormal];
    [_hotBtn setTitle:@"他的热门" forState:UIControlStateNormal];
}
-(void)HandleFollowBtn:(UIButton *)btn
{
//    NSString * str = [[text string] substringWithRange:range];
//    UIAlertView * alertView= [[UIAlertView alloc]initWithTitle:nil message:@"点击了关注" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
//    [alertView show];
    self.followBtnBlock(btn);
}
-(void)HandleChatBtn:(UIButton *)btn
{
    self.chatBtnBlock();
//    UIAlertView * alertView= [[UIAlertView alloc]initWithTitle:nil message:@"点击了聊天" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
//    [alertView show];
}

-(void)HandleHotBtn:(UIButton *)btn
{
    self.hotBtnBlock(btn);
//    UIAlertView * alertView= [[UIAlertView alloc]initWithTitle:nil message:@"点击了他的热门" delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
//    [alertView show];
}


@end
