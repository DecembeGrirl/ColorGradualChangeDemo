//
//  Statuses.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/7/5.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "Statuses.h"
#import "GlobalHelper.h"
#import "YYLabel.h"
@implementation Statuses

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

-(CGFloat)getStatusesHight
{
    // 微博内容的高度
    YYLabel * label = [[YYLabel alloc]init];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
//    NSAttributedString * attrStr = [[NSAttributedString alloc]initWithString:self.text];
    label.attributedText = [[GlobalHelper ShareInstance]setStr:self.text WithColor:RGB_COLOR(@"#0099FF") WithFont:14.0f];
    CGFloat textSizeHeight =  [GlobalHelper CalculateYYlabelHeightAttributedString:label.attributedText Size:CGSizeMake(KScreenWidth - 10, MAXFLOAT)].height ;
//    [GlobalHelper boundingRectWithLable:<#(NSString *)#> Size:<#(CGSize)#> font:<#(CGFloat)#>]
    //转发的微博高度
    CGFloat reStatusSzieHeight = 0;
    if(self.retweeted_status)
    {
        
    NSString * str = [NSString stringWithFormat:@"%@:%@",self.retweeted_status.user.name,self.retweeted_status.text];
        
//        NSAttributedString * reStr = [[NSAttributedString alloc]initWithString:str];
         label.attributedText = [[GlobalHelper ShareInstance]setStr:str WithColor:RGB_COLOR(@"#0099FF") WithFont:14.0f];
    
   CGSize  reStatusSzie =[GlobalHelper CalculateYYlabelHeightAttributedString:label.attributedText Size:CGSizeMake(KScreenWidth - 10, MAXFLOAT)] ;
        
    [label setFrame:CGRectMake(0, 0,ceil(reStatusSzie.width), ceil(reStatusSzie.height))];
        
    }
    CGFloat imageHeight = [self getImageHight];
    return ceil(textSizeHeight) +ceil(label.frame.size.height) + ceil(imageHeight) + 40 + 30 + 7 ;
    
}

-(CGFloat)getImageHight
{
   NSInteger imageCount =  self.retweeted_status?self.retweeted_status.pic_urls.count:self.pic_urls.count;
    NSInteger row =imageCount / 3;
    if(imageCount %3)
        row += 1;
    
    if(imageCount>1)
    {
        return (row + 1) * 2 + row * KsigleImageViewWidth + 5;
    }
    else if(imageCount==1)
    {
        return 170 + 4 ;
    }else
    {
        return 0;
    }
}



@end