//
//  userPhotoTableViewCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/8/29.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserPhotoCollectionView.h"


@interface userPhotoTableViewCell : UITableViewCell
{
    NSArray * dataArray;
   
}

@property (nonatomic, strong)UserPhotoCollectionView * photoCollectionView;

-(void)ConfigCellWith:(NSArray *)array;

-(void)setCollectionViewFrame;
@end
