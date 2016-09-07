//
//  TransmitViewController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/4.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "BaseController.h"
#import "ReportsStatusView.h"
#import "ChatToolView.h"
#import "Statuses.h"
#import "Config.h"
#import "FaceView.h"

// 转发/评论页面

@interface TransmitViewController : BaseController
{
    UITextView *_textView;
    UILabel *_placehodlerLabel;
    ReportsStatusView * _reportsStatusView;
    ChatToolView * _bottomToolView;
    FaceView * _faceInputView;
}
@property (nonatomic, assign)CommentType type;
@property (nonatomic, strong)Statuses * obj;




@end
