//
//  FriendFollowingHeaderView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/8/24.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "FriendFollowingHeaderView.h"
#import "GlobalHelper.h"
@implementation FriendFollowingHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.label = [[YYLabel alloc]initWithFrame:CGRectMake(5, 4, KScreenWidth - 30, 20)];
        self.label.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.label];
        [GlobalHelper ShareInstance].selectedYYLabelRangeTextBlock=^(UIView * containerView, NSAttributedString * text, NSRange range, CGRect rect)
        {        NSString * str = [[text string] substringWithRange:range];
            UIAlertView * alertView= [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"点击了 %@", str] delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
            [alertView show];
            NSLog(@"点击了好友关注 的@ 用户");
        };
        
        self.imageViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.imageViewBtn setFrame:CGRectMake(KScreenWidth - 55, 0, 35, 35)];
        [self.imageViewBtn setImage:[UIImage imageNamed:@"message_toolbar_popover_arrow"] forState:UIControlStateNormal];
        [self.imageViewBtn addTarget:self action:@selector(tableHeaderBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.imageViewBtn];
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 29.5, KScreenWidth, 0.5)];
        [lineView setBackgroundColor:RGB_COLOR(@"#E8E7E9")];
        [self addSubview:lineView];
    }
    return  self;
}

-(void)configData:(NSDictionary *)dic section:(NSInteger)section
{
    self.section = section;
    NSString * str = [NSString stringWithFormat:@"%@ 等%@人关注了",dic[@"title"],dic[@"followCount"]];
    self.label.attributedText = [[GlobalHelper ShareInstance]setStr:str WithColor:RGB_COLOR(@"#0099FF") WithFont:14.0f];
}

-(void)tableHeaderBtnClick
{
    [self.delegate selectedfollowingBtn:self.section];
}

@end
