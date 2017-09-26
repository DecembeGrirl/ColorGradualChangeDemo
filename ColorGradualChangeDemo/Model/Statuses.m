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

-(void)setStatusOtherObj
{
    // 转发的微博内容
     NSString * str = [NSString stringWithFormat:@"@%@:%@",self.retweeted_status.user.name,self.retweeted_status.text];
    _retweetedContextAtr = [[GlobalHelper ShareInstance]setStr:str WithColor:RGB_COLOR(@"#0099FF") WithFont:14.0f];
    // 自己的微博内容
    _contextAtr = [[GlobalHelper ShareInstance]setStr:self.text WithColor:RGB_COLOR(@"#0099FF") WithFont:14.0f];
    
    _statusContentTextSize =  [GlobalHelper CalculateYYlabelHeightAttributedString:_contextAtr Size:CGSizeMake(KScreenWidth - 10, MAXFLOAT)] ;
    
    _retweetedContextSize = CGSizeMake(0, 0);
    if(self.retweeted_status)
    {
        _retweetedContextSize =[GlobalHelper CalculateYYlabelHeightAttributedString:_retweetedContextAtr Size:CGSizeMake(KScreenWidth - 10, MAXFLOAT)] ;
    }
   self.user.name = self.user.name==nil?self.user.screen_name:self.user.name;
   _nameSize = [GlobalHelper boundingRectString:self.user.name Size:CGSizeMake(KScreenWidth, MAXFLOAT) Font:14.0f];
    _statusContextHeight =  _statusContentTextSize.height;
    _retweetedContextHeight = _retweetedContextSize.height;
    _imageContextHeight = [self imageContextHeight];
    _height = [self getStatusesHight];
    
    [self getThumbnail_picArr];
    _cacheImageArr = [_thumbnail_picArr mutableCopy];
}

-(void)getThumbnail_picArr
{
    _thumbnail_picArr = [[NSMutableArray alloc]init];
    NSArray * urls = self.pic_urls.count > 0?self.pic_urls:self.retweeted_status.pic_urls;
    for (NSDictionary * dic in urls) {
        NSString *str = [dic[@"thumbnail_pic"] stringByReplacingOccurrencesOfString:Kthumbnail withString:Kbmiddle];
        [_thumbnail_picArr addObject:str];
    }
}


-(NSMutableArray *)thumbnail_picArr
{
    return  _thumbnail_picArr;
}

-(NSMutableArray *)cacheImageArr
{
    return  _cacheImageArr;
}

-(CGSize)statusContentTextSize
{
    return _statusContentTextSize;
}

-(CGSize)retweetedContextSize
{
    return _retweetedContextSize;
}

-(CGFloat)statusContextHeight
{
    // 微博内容的高度
    return  _statusContextHeight;
}

-(CGFloat)retweetedContextHeight
{
    //转发的微博高度
    return _retweetedContextHeight;
}

-(CGFloat)getImageHight
{
    return _imageContextHeight;
}

-(CGSize)nameSize
{
    return _nameSize;
}


-(CGFloat)getStatusesHight
{
    // 微博内容的高度
    CGFloat textSizeHeight = _statusContextHeight;
    //转发的微博高度
    CGFloat reStatusSzieHeight = _retweetedContextHeight;
    CGFloat imageHeight = _imageContextHeight;
    return ceil(textSizeHeight) +ceil(reStatusSzieHeight) + ceil(imageHeight) + 40 + 30 + 7 ;
}
-(CGFloat)imageContextHeight
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
