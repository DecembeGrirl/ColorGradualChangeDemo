//
//  ImageContenView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/19.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Statuses.h"
#import "EqualSpaceFlowLayout.h"
@class ImageContentView;
//#define KsigleImageViewWidth ([UIScreen mainScreen].bounds.size.width-5)/3 - 4
typedef void(^LayoutSubViewsFrameBlock)(ImageContentView * imageContentView);

@protocol ImageContentViewDelegate <NSObject>
-(void)imageContentView:(ImageContentView *)imageContentView selectedImageView:(UIImageView *)imageView index:(NSInteger)index imageArray:(NSArray *)imageArray;
@end
@interface ImageContentView : UIView<UIGestureRecognizerDelegate>
{
    NSMutableArray * _imageArray;
    NSMutableArray * _imageViewArray;
}
-(void)configImageContentViewWith:(Statuses *)obj;
@property (nonatomic, weak)id <ImageContentViewDelegate>delegate;
@property (nonatomic, weak)LayoutSubViewsFrameBlock layoutSubViewsBlock;

@property (nonatomic, strong)UICollectionView * collectionView;
@property (nonatomic, strong)EqualSpaceFlowLayout * layout;


@end
