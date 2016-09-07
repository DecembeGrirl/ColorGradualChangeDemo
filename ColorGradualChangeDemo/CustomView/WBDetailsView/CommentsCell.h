//
//  CommentsCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/15.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsObj.h"
#import "YYText.h"
@interface CommentsCell : UITableViewCell
{
    UIImageView * _imageView;
    UILabel * _nameLabel;
    UILabel * _timeLabel;
    YYLabel * _contentLabel;
    UIButton * _atitudesBtn;
}
-(void)ConfigData:(CommentsObj *)obj;
-(CGFloat)CellHeight;
@end
