//
//  ImageContenView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/19.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "ImageContentView.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "GlobalHelper.h"
#import "Config.h"
@implementation ImageContentView

-(void)configImageContentViewWith:(Statuses *)obj
{
    _imageArray =[NSMutableArray arrayWithCapacity:obj.pic_urls.count];
    _imageViewArray = [NSMutableArray arrayWithCapacity:obj.pic_urls.count];
    for (int i = 0; i < obj.pic_urls.count; i++) {

    @autoreleasepool {
        UIImageView *imageView = [self CreatImageView];
        
            if(obj.pic_urls.count>1)
            {
                NSUInteger row = i / 3;
                NSUInteger col = i % 3;
                [imageView setFrame:CGRectMake(2 +(2 + KsigleImageViewWidth) * col , 2+(2 + KsigleImageViewWidth) * row  , KsigleImageViewWidth-2 , KsigleImageViewWidth-2)];
            }
            else
            {
                [imageView setFrame:CGRectMake(2,2,220, 170)];
            }
            [self configImageView:imageView with:obj index:i];
                   [self addSubview:imageView];
        }
    }
}

-(UIImageView *)CreatImageView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.userInteractionEnabled = YES;
    imageView.opaque = NO;
    [imageView setBackgroundColor:[UIColor whiteColor]];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HandleTapGesture:)];
    tapGesture.delegate = self;
    [imageView addGestureRecognizer:tapGesture];
    return  imageView;
}

-(void)configImageView:(UIImageView *)imageView with:(Statuses *)obj index:(NSInteger)index
{
    __block typeof(self)weakSelf = self;
    NSString * thumPicURL = obj.pic_urls[index][Kthumbnail_pic];
    NSString * picURL = [thumPicURL stringByReplacingOccurrencesOfString:Kthumbnail withString:Kbmiddle];
    [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:picURL ] options:SDWebImageDelayPlaceholder progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if(image)
        {
            
            if(image.images)
            { // 如果是 gif图片 则添加gif 图标
                CGFloat width = 20;
                UIImageView * gifView = [[UIImageView alloc]initWithFrame:CGRectMake(imageView.width - width ,imageView.height- width, width, width)];
                [gifView setImage:[UIImage imageNamed:@"timeline_image_gif"]];
                [imageView addSubview:gifView];
            }
            NSMutableDictionary * dic  = [NSMutableDictionary dictionaryWithCapacity:3 ];
            [dic setObject:imageURL forKey:Kthumbnail_pic]; //  图片地址
            [dic setObject:image forKey:Kthumbnail_pic_img];
            [dic setObject:imageView forKey:KImageContentView];
            
            
            UIImage *clipImage = image.images?image.images[0]:image;
            UIImage * tempImage = [weakSelf ClipImage:clipImage withRect:imageView.frame];
            [imageView setImage: tempImage];
//                [obj.imageArray addObject:tempImage];
            [weakSelf->_imageArray addObject:dic];
            [weakSelf->_imageViewArray addObject:imageView];
        }
    }];

}

-(UIImage *)ClipImage:(UIImage *)image withRect:(CGRect)rect
{
    UIImageView * imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
    [[imageView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

-(CGFloat)retrunHight
{
    return self.subviews.lastObject.height;
}

-(void)HandleTapGesture:(UITapGestureRecognizer *)gesture
{
    UIImageView *currentImageView = (UIImageView *)gesture.view;
    NSInteger index = [_imageViewArray indexOfObject:currentImageView];
    
    if(currentImageView.image)
    {
        [self.delegate imageContentView:self selectedImageView:currentImageView index:index  imageArray:_imageArray];
    }
}

@end
