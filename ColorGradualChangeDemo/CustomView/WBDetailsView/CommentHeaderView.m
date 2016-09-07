//
//  CommentHeaderView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/9.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "CommentHeaderView.h"
#import "UIView+Frame.h"
@implementation CommentHeaderView

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
    CGFloat btnwidth = 80;
    CGFloat btnHeight = 30;
    _repostsBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_repostsBtn setFrame:CGRectMake(0, 5, btnwidth, btnHeight)];
    [_repostsBtn addTarget:self action:@selector(HandleRepostsBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_repostsBtn];
    
    _commentsBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_commentsBtn setFrame:CGRectMake(_repostsBtn.right , _repostsBtn.top, _repostsBtn.width, btnHeight)];
    [_commentsBtn addTarget:self action:@selector(HandleCommentsBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_commentsBtn];
    
    _attitudesBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [_attitudesBtn setFrame:CGRectMake(self.width - btnwidth, _repostsBtn.top, _repostsBtn.width, btnHeight)];
    [_attitudesBtn addTarget:self action:@selector(HandleAttitudesBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_attitudesBtn];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(_commentsBtn.left, _repostsBtn.bottom, _repostsBtn.width, 2)];
    [_lineView setBackgroundColor:[UIColor orangeColor]];
    [self addSubview:_lineView];
}

-(void)ConfigData:(Statuses *)obj
{
    NSString *repostsText = obj.reposts_count.intValue>0?[NSString stringWithFormat:@"转发 %@",obj.reposts_count]:@"转发";
    [_repostsBtn setTitle:repostsText forState:UIControlStateNormal];
    NSString *commentsText = obj.comments_count.intValue>0?[NSString stringWithFormat:@"评论 %@",obj.comments_count]:@"评论";
    [_commentsBtn setTitle:commentsText forState:UIControlStateNormal];
    NSString *attitudesText = obj.attitudes_count.intValue>0?[NSString stringWithFormat:@"赞 %@",obj.attitudes_count]:@"赞";
    [_attitudesBtn setTitle:attitudesText forState:UIControlStateNormal];
    
    [self FormtBtn];
}
-(void)FormtBtn
{
    [_repostsBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [_repostsBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_commentsBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_commentsBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [_attitudesBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_attitudesBtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
}

-(void)HandleRepostsBtn
{
    [UIView animateWithDuration:0.25 animations:^{
        [_lineView setFrame:CGRectMake(_repostsBtn.left, _repostsBtn.bottom, _repostsBtn.width, 2)];
    }];
    [_repostsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_commentsBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_attitudesBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
}

-(void)HandleCommentsBtn
{
    [UIView animateWithDuration:0.25 animations:^{
        [_lineView setFrame:CGRectMake(_commentsBtn.left, _repostsBtn.bottom, _repostsBtn.width, 2)];
    }];
    [_commentsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_repostsBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_attitudesBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
}

-(void)HandleAttitudesBtn
{
    [UIView animateWithDuration:0.25 animations:^{
        [_lineView setFrame:CGRectMake(_attitudesBtn.left, _repostsBtn.bottom, _repostsBtn.width, 2)];
    }];
    [_commentsBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_repostsBtn setTitleColor:RGB_COLOR(@"#969696") forState:UIControlStateNormal];
    [_attitudesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}


@end
