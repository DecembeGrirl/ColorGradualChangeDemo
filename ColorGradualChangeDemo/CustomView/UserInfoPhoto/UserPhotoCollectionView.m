//
//  UserPhotoCollectionViewCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/8/29.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "UserPhotoCollectionView.h"
#import "UIView+Frame.h"
@implementation UserPhotoCollectionView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        EqualSpaceFlowLayout * layout = [[EqualSpaceFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 2;
        layout.minimumLineSpacing = 2;
        layout.sectionInset = UIEdgeInsetsMake(2, 0, 0, 0);
        layout.delegate = self;
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        
        [_myCollectionView setFrame:self.bounds];
        _myCollectionView .delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.scrollEnabled = NO;
        [self addSubview:_myCollectionView];
        
        [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"userPhotoCollectionCell"];
        [_myCollectionView registerClass:[UIView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAction:)];
        tap.delegate = self;
        [_myCollectionView addGestureRecognizer:tap];
    }
    
    return self;
}
-(void)ConfigCellWith:(NSArray *)array
{
    dataArray = array;
    _images = [NSMutableArray arrayWithArray:array];
    [_myCollectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return  dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"userPhotoCollectionCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[UICollectionViewCell alloc]init];
    }
    for (UIView * view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UIImageView * imageView;
    if(dataArray.count==1)
    {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 170)];
    }else
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (KScreenWidth-6)/3, (KScreenWidth-6)/3)];
    
    [imageView setBackgroundColor:[UIColor whiteColor]];
    NSURL *url = [NSURL URLWithString:dataArray[indexPath.row]];
    __weak typeof(self)weakself = self;
    [[SDWebImageManager sharedManager]downloadImageWithURL:url options:SDWebImageDelayPlaceholder progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if(image)
        {
            if(image.images)
            { // 如果是 gif图片 则添加gif 图标
                CGFloat width = 20;
                UIImageView * gifView = [[UIImageView alloc]initWithFrame:CGRectMake(imageView.width - width ,imageView.height- width, width, width)];
                [gifView setImage:[UIImage imageNamed:@"timeline_image_gif"]];
                [imageView addSubview:gifView];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *clipImage = image.images?image.images[0]:image;
                self.currentImage = clipImage;
                UIImage * tempImage = [weakself ClipImage:clipImage withRect:imageView.frame];
                [imageView setImage:tempImage];
                [_images replaceObjectAtIndex:indexPath.row withObject:tempImage];
            });
        }
    }];

    [cell.contentView addSubview:imageView];
    return  cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(dataArray.count == 1)
    {
     return  CGSizeMake(220, 170);
    }
    else
        return  CGSizeMake((KScreenWidth-6) /3, (KScreenWidth-6) /3);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];

    dispatch_async(dispatch_get_main_queue(), ^{
//        UIImageView * imageView = (UIImageView *)cell.contentView.subviews.lastObject;
//            NSLog(@"%@",imageView.image);
//     [self.delegate selectedImageView:cell atIndexPath:indexPath images:dataArray inView:self];
        [self.delegate selectedImageView:cell atIndexPath:indexPath currentImage:self.currentImage images:dataArray inView:self];
    });
}

-(void)setCollectionViewFrame
{
    [_myCollectionView setFrame:self.bounds];
}

-(UIImage *)ClipImage:(UIImage *)image withRect:(CGRect)rect
{
    UIImageView * imageView  = [[UIImageView alloc]initWithFrame:rect];
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
    [[imageView layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

-(void)handleTapAction:(UITapGestureRecognizer *)tap
{
    self.selectedBlackOutOfcellBlock();
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]&& touch.view != _myCollectionView ) {
//        CGPoint tapPoint = [touch locationInView:_myCollectionView];
//        if([self canPerformAction:@selector(collectionView:didSelectItemAtIndexPath:) withSender:self] )
//        {
//            if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
//            {
//                NSIndexPath *indexPath = [_myCollectionView indexPathForItemAtPoint:tapPoint];
//                [self collectionView:_myCollectionView didSelectItemAtIndexPath:indexPath];
//            }
//        }
        return NO;
    }
    return YES;
}


@end
