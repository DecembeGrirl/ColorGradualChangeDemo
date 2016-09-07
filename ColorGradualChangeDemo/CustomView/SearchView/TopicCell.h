//
//  TopicCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicCell : UITableViewCell
{
    UILabel * _lable1;
    UILabel * _lable2;
    UILabel * _lable3;
    UILabel * _lable4;
}

-(void)ConfigData:(id)data;

@end
