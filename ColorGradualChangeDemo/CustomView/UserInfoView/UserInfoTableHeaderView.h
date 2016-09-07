//
//  UserInfoTableHeaderView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/23.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserInfoTableHeaderViewDelegate <NSObject>

-(void)selectedUserInfoTableHeaderViewPhotoBtn;
-(void)selectedUserInfoTableHeaderViewHomeBtn;
-(void)selectedUserInfoTableHeaderViewWeiBoBtn;

@end


@interface UserInfoTableHeaderView : UIView
{
    UIButton * _homeBtn;  //主页
    UIButton * _statusBtn; //微博
    UIButton * _photoBtn;//相册
    UIView *_lineView;
}

@property (nonatomic, assign)id<UserInfoTableHeaderViewDelegate>delegate;

@end
