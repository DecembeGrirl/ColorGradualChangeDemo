//
//  ShowBigViewController.h
//  YSHYImageView
//
//  Created by 杨淑园 on 15/10/13.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "YSHYZoomScrollView.h"

#pragma mark - showImage


@protocol ShowBigViewDelegate <NSObject>

-(void)ShowBigViewDismiss:(UIView *)bigView selectedView:(UIView *)view CurrentIndex:(NSInteger)currentIndex images:(NSArray *)images;

@end

#pragma mark - ShowBigViewController

@interface ShowBigView :UIView
<UIScrollViewDelegate,UINavigationControllerDelegate>
{
    UIScrollView    *_scrollerview;
    NSMutableArray *_bigImageArray;
    UILabel *_countLabel;
}
@property (nonatomic, assign)CGRect originFrame;
@property (nonatomic, assign)UIImage * selectedDisplayImage;
@property (nonatomic, strong)UIImageView * selectedView;
@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, strong)UIImageView* currentView;
@property (nonatomic ,strong)id<ShowBigViewDelegate>delegate;
-(void)ConfigData:(NSArray *)array ImageView:(UIImageView *)imageView atIndex:(NSInteger )index;
//-(void)CreatSelectedView:(UIImageView *)view AndFrame:(CGRect )frame;
-(void)CreatSelectedView:(UIImageView *)view AndFrame:(CGRect )frame currentIamge:(UIImage *)image;
-(void)showBigImage;

@end




