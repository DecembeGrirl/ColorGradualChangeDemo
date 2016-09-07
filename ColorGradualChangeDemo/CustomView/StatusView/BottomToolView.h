//
//  BottomView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/10.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "Statuses.h"
//@class BaseCell;

#define ReportsBtnTag 10001
#define CommentsBtnTag 10002
#define AttitudesBtnTag 10003

@protocol BottomToolViewBtnDelegate <NSObject>

-(void)SelectedBottomViewBtn:(UIButton *)btn btnType:(CommentType)type;

@end

@interface BottomToolView : UIView
{
    UIButton * _repostsBtn;  //转发按钮
    UIButton * _commentsBtn; //评论按钮;
    UIButton * _attitudesBtn; //点赞按钮
}
@property(nonatomic, strong)Statuses * statusObj;
@property(nonatomic, weak)id <BottomToolViewBtnDelegate>delegate;

-(void)ConfigBtnData:(CommentType)type;
@end
