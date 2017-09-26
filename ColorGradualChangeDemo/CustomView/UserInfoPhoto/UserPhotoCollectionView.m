//
//  UserPhotoCollectionViewCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/8/29.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "UserPhotoCollectionView.h"
#import "UserPhotoCollectionCell.h"
@implementation UserPhotoCollectionView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        EqualSpaceFlowLayout * layout = [[EqualSpaceFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 2;
        layout.minimumLineSpacing = 2;
        layout.sectionInset = UIEdgeInsetsMake(2, 0, 0, 0);
        layout.delegate = self;
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        self.myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        
        [_myCollectionView setFrame:self.bounds];
        _myCollectionView .delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.scrollEnabled = NO;
        [self addSubview:_myCollectionView];
        
        [_myCollectionView registerClass:[UserPhotoCollectionCell class] forCellWithReuseIdentifier:@"userPhotoCollectionCell"];
        [_myCollectionView registerClass:[UIView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapAction:)];
        tap.delegate = self;
        [_myCollectionView addGestureRecognizer:tap];
    }
    
    return self;
}
-(void)ConfigCellWithObj:(Statuses *)obj
{
    _statusObj = obj;
    dataArray = _statusObj.thumbnail_picArr;
    _images = [NSMutableArray arrayWithArray:dataArray];
    [_myCollectionView reloadData];
}

-(void)configCellWith:(NSArray *)array
{
    _images = [array mutableCopy];
    [_myCollectionView reloadData];
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  _images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"userPhotoCollectionCell";
    
    UserPhotoCollectionCell *cell = (UserPhotoCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.statusObj = _statusObj;
    cell.isloadImage = self.canLoad;
    [cell ConfigData:_images[indexPath.row] andImage:_statusObj.cacheImageArr[indexPath.row]];
    __weak typeof(self) weakself = self;
    cell.saveStatusImageBlcok = ^(UIImage * image ,NSIndexPath *indexPath)
    {
        weakself.saveImageBlock(image,indexPath);
    };
    return  cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(dataArray.count == 1)
    {
     return  CGSizeMake(200, 170);
    }
    else
        return  CGSizeMake((KScreenWidth-18) / 3, (KScreenWidth-18) /3);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UserPhotoCollectionCell * cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    [self.delegate selectedImageView:cell atIndexPath:indexPath currentImage:cell.imageView.image images:_images inView:self];
}

-(void)setCollectionViewFrame
{
    [_myCollectionView setFrame:self.bounds];
}


-(void)handleTapAction:(UITapGestureRecognizer *)tap
{
    self.selectedBlackOutOfcellBlock();
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]&& touch.view != _myCollectionView ) {
        return NO;
    }
    return YES;
}


@end
