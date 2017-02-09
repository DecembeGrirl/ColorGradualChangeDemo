//
//  FriendFollowingTableViewCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/8/24.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "FriendFollowingTableViewCell.h"
#import "UIView+Frame.h"

@implementation FriendFollowingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.layer.cornerRadius = 30;
        _headerImageView.layer.masksToBounds = YES;
        [self addSubview:_headerImageView];
        _nameLa = [[UILabel alloc]init];
        _nameLa.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_nameLa];
        _descripLa = [[UILabel alloc]init];
        _descripLa.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_descripLa];
        _statusLa = [[UILabel alloc]init];
        _statusLa.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_statusLa];
        _followingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followingBtn setBackgroundImage:[UIImage imageNamed:@"toolbar_icon_addtogroup"] forState:UIControlStateNormal];
        [_followingBtn addTarget:self action:@selector(handleFollowingBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_followingBtn];
    }
    return  self;
}
-(void)ConfigData:(NSDictionary *)dic
{
    [_headerImageView setImage:[UIImage imageNamed:dic[@"headerImage"]]];
    _nameLa.text = dic[@"name"];
    _descripLa.text = dic[@"descrip"];
    _statusLa.text = dic[@"leastStatuses"];
}

-(void)setSubViewFrame
{
    [_headerImageView setFrame:CGRectMake(10, 5, self.frame.size.height - 10, self.frame.size.height - 10)];
    [_nameLa setFrame:CGRectMake(_headerImageView.right + 3, _headerImageView.top, self.width - _headerImageView.right, 20)];
    [_descripLa setFrame:CGRectMake(_nameLa.left, _nameLa.bottom + 3, _nameLa.width, 16)];
    [_statusLa setFrame:CGRectMake(_nameLa.left, _descripLa.bottom + 3, _nameLa.width, 14)];
    [_followingBtn setFrame:CGRectMake(self.width - 60, 5, 40, 40)];
    
    UILabel *lable= [[UILabel alloc]initWithFrame:CGRectMake(_followingBtn.left, _followingBtn.bottom + 3, 40, 16)];
    lable.font = [UIFont systemFontOfSize:12.0];
    lable.text = @"加关注";
    [self addSubview:lable];
}

-(void)handleFollowingBtn
{
    NSLog(@"添加喽");
    UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"点击了添加按钮" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
    [self addSubview:alertView];
    [alertView show];
}





@end
