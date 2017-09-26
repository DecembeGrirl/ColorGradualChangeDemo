//
//  UserPhotoCollectionViewCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/8/29.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EqualSpaceFlowLayout.h"
#import "Statuses.h"
typedef void(^SeleBlankOutOfCellBlock)();
typedef void(^SaveImageBlock)(UIImage * image ,NSIndexPath *indexPath);

@protocol userPhotoCollectionViewDelegate <NSObject>

//-(void)selectedImageView:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexpath images:(NSArray *)array inView:(UIView *)view;
-(void)selectedImageView:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexpath currentImage:(UIImage *)image images:(NSArray *)array inView:(UIView *)view;
//-(void)seleBlankOutOfCell;

@end

@interface UserPhotoCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,EqualSpaceFlowLayoutDelegate,UIGestureRecognizerDelegate>
{
    NSArray * dataArray;
    Statuses * _statusObj;
}
@property (assign, atomic)BOOL canLoad;
@property (strong, nonatomic)UICollectionView * myCollectionView;
@property (strong, nonatomic)NSMutableArray * images;
@property (strong, nonatomic)UIImage * currentImage;
@property (weak, nonatomic)id<userPhotoCollectionViewDelegate>delegate;
@property (copy, nonatomic)SeleBlankOutOfCellBlock selectedBlackOutOfcellBlock;
@property (copy, nonatomic)SaveImageBlock saveImageBlock;

-(void)ConfigCellWithObj:(Statuses *)obj;
-(void)configCellWith:(NSArray *)array;
-(void)setCollectionViewFrame;
@end
