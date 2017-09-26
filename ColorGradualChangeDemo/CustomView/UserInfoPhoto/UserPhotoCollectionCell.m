//
//  UserPhotoCollectionCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 2017/3/7.
//  Copyright © 2017年 yangshuyaun. All rights reserved.
//

#import "UserPhotoCollectionCell.h"
#import "UIView+Frame.h"
@implementation UserPhotoCollectionCell

-(instancetype)init
{
    if(self = [super init])
    {
       
    }
    return self;
}

-(void)ConfigData:(NSString *)urlStr andImage:(UIImage *)image 
{
    if(self.imageView)
    {
        [self.imageView removeFromSuperview];
    }
    self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
//    [self.imageView setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:self.imageView];
    if([image isKindOfClass:[UIImage class]])
    {
        [self.imageView setImage:image];
        return;
    }
    if(!_isloadImage)
    {
        return;
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    __weak typeof(self)weakself = self;
    [self.imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if(image)
        {
            if(image.images)
            { // 如果是 gif图片 则添加gif 图标
                CGFloat width = 20;
                UIImageView * gifView = [[UIImageView alloc]initWithFrame:CGRectMake(weakself.imageView.width - width ,weakself.imageView.height- width, width, width)];
                [gifView setImage:[UIImage imageNamed:@"timeline_image_gif"]];
                [self.imageView addSubview:gifView];
            }
            UIImage *clipImage = image.images?image.images[0]:image;
            UIImage * tempImage = [weakself ClipImage:clipImage withRect:weakself.imageView.frame];
            [weakself.imageView setImage:tempImage];
//            NSLog(@"^^^^^^^   %li",(long)weakself.indexPath.row);
//            weakself.orignImage = clipImage;
             [weakself.statusObj.cacheImageArr replaceObjectAtIndex:weakself.indexPath.row withObject:tempImage];
        }

    }];
}

-(UIImage *)ClipImage:(UIImage *)image withRect:(CGRect)rect
{
    CGSize size = rect.size;
    
    CGFloat height = image.size.height >= size.height?size.height:image.size.height;
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView setFrame:CGRectMake(0, 0, size.width, height)];
    
    CGRect screenRect = [imageView bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [imageView.layer renderInContext:ctx];
    UIImage *tempImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImage;
}



@end
