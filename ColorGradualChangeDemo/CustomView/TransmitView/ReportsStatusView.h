//
//  reportsStatusView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Statuses.h"

@interface ReportsStatusView : UIView
{
    UIImageView * _imageView;
    UILabel * _userNameLabel;
    UILabel * _textLabel;

}
-(void)ConfigDataWith:(Statuses *)obj;


@end
