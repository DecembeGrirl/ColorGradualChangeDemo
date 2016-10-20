//
//  UserPhotoCollectionViewCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/8/29.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EqualSpaceFlowLayout.h"

typedef void(^SeleBlankOutOfCellBlock)();

@protocol userPhotoCollectionViewDelegate <NSObject>

//-(void)selectedImageView:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexpath images:(NSArray *)array inView:(UIView *)view;
-(void)selectedImageView:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexpath currentImage:(UIImage *)image images:(NSArray *)array inView:(UIView *)view;
//-(void)seleBlankOutOfCell;

@end

@interface UserPhotoCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,EqualSpaceFlowLayoutDelegate,UIGestureRecognizerDelegate>
{
    NSArray * dataArray;
}
@property (strong, nonatomic)UICollectionView * myCollectionView;
@property (strong, nonatomic)NSMutableArray * images;
@property (strong, nonatomic)UIImage * currentImage;
@property (weak, nonatomic)id<userPhotoCollectionViewDelegate>delegate;
@property (copy, nonatomic)SeleBlankOutOfCellBlock selectedBlackOutOfcellBlock;

-(void)ConfigCellWith:(NSArray *)array;
-(void)setCollectionViewFrame;
@end
