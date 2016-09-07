//
//  ShowBigViewController.m
//  YSHYImageView
//
//  Created by 杨淑园 on 15/10/13.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import "ShowBigView.h"
#import "UIImageView+WebCache.h"
#import "Config.h"
#import "PopFadeTranst.h"
#import "PushFadeTranst.h"
#import "WBViewControll.h"
#define IOS7LATER  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#pragma mark - ShowBigViewController
@interface ShowBigView ()<UIViewControllerTransitioningDelegate>
@property(assign, nonatomic) CGPoint currentPoint;
@property (strong, nonatomic) NSMutableArray *showImageArrary;
@property (assign, nonatomic) int sendNumber;
@property (nonatomic, strong) YSHYZoomScrollView *currentZoomScrollView;
@property (nonatomic, strong) YSHYZoomScrollView * lastZoomScrollView;
@end

@implementation ShowBigView
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        _scrollerview = [[UIScrollView alloc]initWithFrame:frame];
        self.showImageArrary = [[NSMutableArray alloc]initWithCapacity:5];
        [self CreatUI];
    }
    return  self;
}
-(void)CreatUI
{
    [_scrollerview setFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _scrollerview.delegate = self;
    _scrollerview.pagingEnabled = YES;
    [_scrollerview setShowsHorizontalScrollIndicator:NO];
    [_scrollerview setShowsVerticalScrollIndicator:NO];
    _scrollerview.contentOffset = CGPointMake(0 , 0);
    _scrollerview.hidden = YES;
    [self addSubview:_scrollerview];
    
    _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/2-30, 15, 60, 25)];
    [_countLabel setBackgroundColor:RGB_COLOR(@"#E4E4E4")];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    [_countLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    _countLabel.textColor= [UIColor whiteColor];
    _countLabel.layer.cornerRadius = 10.0f;
    _countLabel.layer.masksToBounds = YES;
    [self addSubview:_countLabel];
    
}

-(void)ConfigData:(NSArray *)array ImageView:(UIImageView *)imageView atIndex:(NSInteger )index;
{
    _bigImageArray= [NSMutableArray arrayWithArray: array];
    self.currentView =imageView;
    self.currentIndex = index;
    //    for (NSDictionary * dict in _bigImageArray) {
    //        UIImageView * imageView = (UIImageView *)dict[KImageContentView];
    //        if( CGRectEqualToRect(imageView.frame, _currentView.frame))
    //        {
    //            self.currentIndex = [_bigImageArray indexOfObject:dict];
    //            break;
    //        }
    //    }
    _scrollerview.contentSize = CGSizeMake((_bigImageArray.count) * (self.frame.size.width),0);
    _countLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)self.currentIndex+1,(unsigned long)[_bigImageArray count]];
    _countLabel.hidden = _bigImageArray.count>1?NO:YES;
}




-(void)CreatSelectedView:(UIImageView *)view AndFrame:(CGRect )frame
{
    self.selectedView = [[UIImageView alloc]init];
    self.originFrame = frame;
    self.selectedView = view;
    //    self.selectedView.image = _currentView.image;
    //    _currentView.image = self.selectedView.image;
    [self addSubview:self.selectedView];
    
    [self changeSelectedViewFrame];
}
-(void)changeSelectedViewFrame
{
    __block typeof(self) weakself = self;
    if(_bigImageArray.count> 0)
        [self showBigImage];
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat height = weakself.selectedView.image.size.height/weakself.selectedView.image.size.width * weakself.width;
        if(height)
        {
            [weakself.selectedView setFrame:CGRectMake(0, 0, weakself.width, height)];
            if(height < weakself.height)
                [weakself.selectedView setCenter:weakself.center];
        }
    } completion:^(BOOL finished) {
        weakself.selectedView.hidden = YES;
        weakself->_scrollerview.hidden = NO;
        
    }];
}
-(void)showBigImage
{
    //显示选中的图片的大图
    for (int i=0; i<[_bigImageArray count]; i++)
    {
        YSHYZoomScrollView *zoomScrollView = [[YSHYZoomScrollView alloc]init];
        CGRect frame = _scrollerview.frame;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = 0;
        zoomScrollView.frame = frame;
        
        NSString *thumbnail_pic_url = [NSString stringWithFormat:@"%@", _bigImageArray[i]];
        __block typeof(self) weakself = self;
        __block typeof(zoomScrollView) weakZoomScrollView = zoomScrollView;
        [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:thumbnail_pic_url] options:SDWebImageDelayPlaceholder progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            //            [weakZoomScrollView .imageView setImage:_bigImageArray[i]];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if(!error)
            {
                [weakZoomScrollView setImageViewFrame:image];
            }
        }];
        
        zoomScrollView.tapMRZoomScrollviewBlock = ^(YSHYZoomScrollView *view)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.selectedView.hidden = NO;
                weakself->_scrollerview.hidden = YES;
                [weakself.delegate ShowBigViewDismiss:weakself selectedView:weakself.selectedView CurrentIndex:weakself.currentIndex images:_bigImageArray];
            });
        };
        [_scrollerview addSubview:zoomScrollView];
    }
    
    [_scrollerview setContentOffset:CGPointMake(KScreenWidth *self.currentIndex, 0)];
    self.currentZoomScrollView =(YSHYZoomScrollView *) _scrollerview.subviews[self.currentIndex];
}

#pragma  amrk - scrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentPoint = _scrollerview.contentOffset;
    int b = self.currentPoint.x/_scrollerview.frame.size.width + 1 ;
    self.lastZoomScrollView = self.currentZoomScrollView;
    int temp = b-1>=0?b-1:0;
    self.currentZoomScrollView = scrollView.subviews[temp];
    if(![self.lastZoomScrollView isEqual:self.currentZoomScrollView])
    {
        //让滑过去的image恢复默认大小
        float newScale = self.lastZoomScrollView.minimumZoomScale;
        [self.lastZoomScrollView scrollViewDidEndZooming:self.lastZoomScrollView withView:self.lastZoomScrollView.imageView atScale:newScale];
        
        UIImageView * tempImageView = self.currentZoomScrollView.imageView;
        //        UIImageView * tempImageView= _bigImageArray[temp][KImageContentView];
        self.selectedView.image = tempImageView.image;
        //        self.selectedDisplayImage = _bigImageArray[temp][KDisplay_pic];
    }
    self.currentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;;
    _countLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)self.currentIndex+1,(unsigned long)[_bigImageArray count]];
}



@end
