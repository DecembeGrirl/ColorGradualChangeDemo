//
//  RetweetedStatusView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/9.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageContentView.h"
#import "Statuses.h"
#import "YYText.h"
#import "UserPhotoCollectionView.h"
@class RetweetedStatusView;
@protocol RetweetedStatusViewDelegate <NSObject>
-(void)HandleTapGestureForRetweetedStatusView:(RetweetedStatusView *)retweetedStatusView;
@end
@interface RetweetedStatusView : UIView<UIGestureRecognizerDelegate>
{
    YYLabel * _contentTextLabel;
    NSMutableArray * _imageViewArray;
    //    ImageContentView * _imageContenView;
}
@property (nonatomic, assign)BOOL canLoad;
@property (nonatomic, strong)Statuses * obj;
//@property (nonatomic, strong)ImageContentView *imageContentView;
@property (nonatomic, strong)UserPhotoCollectionView *imageContentView;
@property (nonatomic, weak)id<RetweetedStatusViewDelegate>delegate;
-(void)ConfigUIWithData:(id)data;
-(void)setSubviewsFrame;
@end
