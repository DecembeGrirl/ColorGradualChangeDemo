//
//  ImageContenCollectionView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/7/14.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Statuses.h"
#import "EqualSpaceFlowLayout.h"
@interface ImageContenCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,EqualSpaceFlowLayoutDelegate>


@property (nonatomic, strong)NSArray * dataArray;

-(void)ConfigCollectionView:(Statuses * )statuses;

@end
