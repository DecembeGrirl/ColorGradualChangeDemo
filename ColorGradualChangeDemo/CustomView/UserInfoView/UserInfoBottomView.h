//
//  UserInfoBottomView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/28.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

typedef void(^ClickFollowBtnBlock)(UIButton *btn);
typedef void(^ClickChatBtnBlock)();
typedef void(^ClickHotBtnBlock)(UIButton *btn);
@interface UserInfoBottomView : UIView
{
    UIButton * _followBtn;  //关注按钮
    UIButton *_chatBtn; //聊天按钮;
    UIButton * _hotBtn; //热门按钮
}
@property (nonatomic, copy)ClickFollowBtnBlock followBtnBlock;
@property (nonatomic, copy)ClickChatBtnBlock chatBtnBlock;
@property (nonatomic, copy)ClickHotBtnBlock hotBtnBlock;

-(void)ConfigUIWIthData:(User *)obj;
@end
