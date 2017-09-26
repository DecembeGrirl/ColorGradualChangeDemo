//
//  MyCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import "BaseCell.h"
#import "RetweetedStatusView.h"
#import "ImageContentView.h"
#import "ImageContenCollectionView.h"
#import "Statuses.h"
#import "EqualSpaceFlowLayout.h"
#import "UserPhotoCollectionView.h"
@class StatusViewForImageCell;
@protocol StatusViewForImageCellDelegate <NSObject>

@optional
-(void)HandleTapGestureForStatusViewForImageCell:(StatusViewForImageCell *)statusViewForImageCell;
@end


@interface StatusViewForImageCell : BaseCell<EqualSpaceFlowLayoutDelegate>
{
    NSArray * dataArray;
}

@property (nonatomic, strong)UserPhotoCollectionView *imageContentView;

@property (nonatomic, strong)Statuses * obj;
@property (nonatomic, strong)id<StatusViewForImageCellDelegate>myDelegate;
-(CGFloat)cellHeight;

@end
