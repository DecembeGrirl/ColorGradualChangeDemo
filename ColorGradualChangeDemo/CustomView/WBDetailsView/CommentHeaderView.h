//
//  CommentHeaderView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/9.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "Statuses.h"
// 微博正文里的 转发 评论 赞 的详情view
@interface CommentHeaderView : UIView
{
    UIButton * _repostsBtn;
    UIButton * _commentsBtn;
    UIButton * _attitudesBtn;
    UIView *_lineView;
 
}
-(void)ConfigData:(Statuses *)obj;
@end
