//
//  BottomView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/10.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "BottomToolView.h"
#import "UIView+Frame.h"


@implementation BottomToolView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self CreatUI];
    }
    return self;
}

-(void)CreatUI
{
    [self setBackgroundColor:RGB_COLOR(@"#FAFAFA")];
    _repostsBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_repostsBtn setFrame:CGRectMake(0, 0, KScreenWidth/ 3, BottomToolViewHeight)];
    _repostsBtn.tag = ReportsBtnTag;
    [_repostsBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
    [_repostsBtn addTarget:self action:@selector(HandleRepostsBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_repostsBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_repostsBtn setImage:[UIImage imageNamed:@"toolbar_icon_retweet"] forState:UIControlStateNormal];
    [_repostsBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [_repostsBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [self addSubview:_repostsBtn];
    
    _commentsBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_commentsBtn setImage:[UIImage imageNamed:@"toolbar_icon_comment"] forState:UIControlStateNormal];
    _commentsBtn.tag = CommentsBtnTag;
    [_commentsBtn addTarget:self action:@selector(HandleCommentsBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_commentsBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_commentsBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [_commentsBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_commentsBtn setFrame:CGRectMake(_repostsBtn.right , _repostsBtn.top, KScreenWidth/ 3 , BottomToolViewHeight)];
    [_commentsBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
    [self addSubview:_commentsBtn];
    
    _attitudesBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_attitudesBtn setFrame:CGRectMake(_commentsBtn.right, _repostsBtn.top, KScreenWidth/ 3 , BottomToolViewHeight)];
    _attitudesBtn.tag = AttitudesBtnTag;
    [_attitudesBtn setImage:[UIImage imageNamed:@"toolbar_icon_unlike"] forState:UIControlStateNormal];
    [_attitudesBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_attitudesBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [_attitudesBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_attitudesBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
    [self addSubview:_attitudesBtn];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(_repostsBtn.right, 10, 1, 20)];
    [lineView1 setBackgroundColor:RGB_COLOR(@"#d5d4d4")];
    [self addSubview:lineView1];
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(_commentsBtn.right, 10, 1, 20)];
    [lineView2 setBackgroundColor:RGB_COLOR(@"#d5d4d4")];
    [self addSubview:lineView2];
}

-(void)HandleRepostsBtn:(UIButton *)btn
{
    [self.delegate SelectedBottomViewBtn:btn btnType:REPORTTYPE];
}

-(void)HandleCommentsBtn:(UIButton *)btn
{
    CommentType type = self.statusObj.comments_count.integerValue > 0?COMMENTDETAILSTYPE:COMMENTTYPE;
    [self.delegate SelectedBottomViewBtn:btn btnType:type];
}
-(void)ConfigBtnData:(CommentType)type
{
    if(type == COMMENTDETAILSTYPE)
    {
        self.hidden = YES;
        NSString *repostsText = self.statusObj.retweeted_status.reposts_count.intValue>0?[NSString stringWithFormat:@"%@",self.statusObj.retweeted_status.reposts_count]:@"转发";
        [_repostsBtn setTitle:repostsText forState:UIControlStateNormal];
        NSString *commentsText = self.statusObj.retweeted_status.comments_count.intValue>0?[NSString stringWithFormat:@"%@",self.statusObj.retweeted_status.comments_count]:@"评论";
        [_commentsBtn setTitle:commentsText forState:UIControlStateNormal];
        NSString *attitudesText = self.statusObj.retweeted_status.attitudes_count.intValue>0?[NSString stringWithFormat:@"%@",self.statusObj.retweeted_status.attitudes_count]:@"赞";
        [_attitudesBtn setTitle:attitudesText forState:UIControlStateNormal];
    }
    else
    {
        NSString *repostsText = self.statusObj.reposts_count.intValue>0?[NSString stringWithFormat:@"%@",self.statusObj.reposts_count]:@"转发";
        [_repostsBtn setTitle:repostsText forState:UIControlStateNormal];
        NSString *commentsText = self.statusObj.comments_count.intValue>0?[NSString stringWithFormat:@"%@",self.statusObj.comments_count]:@"评论";
        [_commentsBtn setTitle:commentsText forState:UIControlStateNormal];
        NSString *attitudesText = self.statusObj.attitudes_count.intValue>0?[NSString stringWithFormat:@"%@",self.statusObj.attitudes_count]:@"赞";
        [_attitudesBtn setTitle:attitudesText forState:UIControlStateNormal];
    }
}

@end
