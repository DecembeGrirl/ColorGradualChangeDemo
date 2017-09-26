//
//  CommnetsObj.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/15.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "CommentsObj.h"
#import "Config.h"
#import "MJExtension.h"
#import "GlobalHelper.h"
@implementation CommentsObj
-(CGFloat)getHeight
{
    
    CGSize nameSize = [GlobalHelper boundingRectString:self.user.name Size:CGSizeMake(MAXFLOAT, 25) Font:12.0f];
    
    CGSize timeSize = [GlobalHelper boundingRectString:self.created_at Size:CGSizeMake(MAXFLOAT, 25) Font:12.0f];
    
    NSAttributedString * att = [[GlobalHelper  ShareInstance] setStr:self.text WithColor:RGB_COLOR(@"#0099FF") WithFont:14.0f];
    CGSize size =  [GlobalHelper CalculateYYlabelHeightAttributedString:att Size:CGSizeMake(KScreenWidth-45, MAXFLOAT)];
    
    CGFloat height = 16+ceil(nameSize.height)+ceil(timeSize.height)+ceil(size.height);
    return  height;
}

@end
