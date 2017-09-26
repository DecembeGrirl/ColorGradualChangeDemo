//
//  StatusObj.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/8.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "StatusObj.h"
#import "Config.h"
#import "SDWebImageManager.h"
@implementation StatusObj

-(void)setStatusWithData:(NSDictionary *)status
{
    self.attitudes_count = status[Kattitudes_count];
    NSDictionary * tempDic = status[Kretweeted_status];
    self.retweeted_status = [[StatusObj alloc]init];
    if(tempDic)
    {
        [self.retweeted_status setStatusWithData:tempDic];
    }
    self.user = [[UserObj alloc]init];
    [self.user setUserWithUserInfo:status[Kuser]];
    [self DownloadImagesWithURLS:status[Kpic_urls]];}

-(void)DownloadImagesWithURLS:(NSArray *)urls
{
    self.imageArray = [NSMutableArray arrayWithCapacity:urls.count];
    self.thumbnail_pic_urls = [NSMutableArray arrayWithCapacity:urls.count];
    self.bmiddle_pic_urls = [NSMutableArray arrayWithCapacity:urls.count];
    self.original_pic_urls = [NSMutableArray arrayWithCapacity:urls.count];
    for (int i = 0; i<urls.count; i++) {
            NSString * thumbnailURL = urls[i][Kthumbnail_pic];
            NSString * bmiddleURL = [thumbnailURL stringByReplacingOccurrencesOfString:Kthumbnail withString:Kbmiddle];
            NSString *orignalURL = [thumbnailURL stringByReplacingOccurrencesOfString:Kthumbnail withString:Koriginal];
            [self.thumbnail_pic_urls addObject:thumbnailURL];
            [self.bmiddle_pic_urls addObject:bmiddleURL];
            [self.original_pic_urls addObject:orignalURL];
    }
}

-(UIImage *)ClipImage:(UIImage *)image scaleToSize:(CGSize)size
{
    CGFloat height = image.size.height > size.height?size.height:image.size.height;
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setFrame:CGRectMake(0, 0, size.width, height)];
    
//    UIReplicantView
//    UIView *view = [imageView snapshotViewAfterScreenUpdates:YES];
    CGRect screenRect = [imageView bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [imageView.layer renderInContext:ctx];
    UIImage *tempImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImage;
}


@end
