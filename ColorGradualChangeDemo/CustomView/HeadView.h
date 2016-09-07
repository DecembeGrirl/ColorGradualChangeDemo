//
//  HeadView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/30.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#define headImageheight  [UIScreen mainScreen].bounds.size.height/3
@interface HeadView : UIView
{
    UIImageView * _backegroudImageView;
    UIImageView * _headImageView;
    UILabel * _nameLabel;
    UILabel * _friendsLabel; //关注
    UILabel * _followsLabel; //粉丝
    UIView * _lineView;
    UILabel * _verifiedReasonLabel;//认证原因
    
    CGSize _friendsCountLableSize;
    CGSize _followsCountLabelSzie;
}

-(void)ConfigDataWithUserInfo:(User *)obj;

@end
