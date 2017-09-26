//
//  RetweetedStatusView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/9.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "RetweetedStatusView.h"
#import "Config.h"
#import "Statuses.h"
#import "GlobalHelper.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
@implementation RetweetedStatusView

-(instancetype)init
{
    if (self = [super init])
    {
        [self setBackgroundColor:RGB_COLOR(@"#E8E7E9")];
        _contentTextLabel = [[YYLabel alloc]init];
        [self addSubview:_contentTextLabel];
        _contentTextLabel.numberOfLines = 0;
        _contentTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _imageViewArray = [NSMutableArray arrayWithCapacity:1];
        
        self.imageContentView = [[UserPhotoCollectionView alloc]initWithFrame:CGRectMake(0, 0,KScreenWidth, 0)];
        [self.imageContentView.myCollectionView setBackgroundColor:RGB_COLOR(@"#E8E7E9")];
        self.imageContentView.opaque = NO;
        __weak typeof (self)weakSelf = self;
        self.imageContentView.selectedBlackOutOfcellBlock= ^()
        {
            [weakSelf.delegate HandleTapGestureForRetweetedStatusView:weakSelf];
        };
//        self.imageContentView.saveImageBlock=^(UIImage *image,NSIndexPath *indexPath)
//        {
//            NSLog(@" 保存图片喽");
//             NSLog(@"~~~~~~~~   %li",(long)indexPath.row);
//            [weakSelf.obj.cacheImageArr replaceObjectAtIndex:indexPath.row withObject:image];
//        };
//        
        [self addSubview:self.imageContentView];
        self.userInteractionEnabled = YES;
        [self addGesture];
    }
    return  self;
}

-(void)ConfigUIWithData:(id)data
{
    self.obj = (Statuses *)data;
    _contentTextLabel.attributedText = self.obj.retweetedContextAtr;
    _contentTextLabel.userInteractionEnabled = YES;
    [_imageViewArray removeAllObjects];
    self.imageContentView.canLoad = self.canLoad;
    [self.imageContentView ConfigCellWithObj:self.obj];
}

-(void)setSubviewsFrame
{
    CGSize contentTextSize = self.obj.retweetedContextSize;
    [_contentTextLabel setFrame:CGRectMake(5, 0, ceilf(contentTextSize.width) , ceil(contentTextSize.height) )];
    [self.imageContentView setFrame:CGRectMake(5,_contentTextLabel.bottom ,KScreenWidth - 10  ,self.obj.getImageHight)];
    [self.imageContentView setCollectionViewFrame];
    CGFloat height = self.imageContentView.bottom;
    CGRect newframe = self.frame;
    newframe.size.height = height+2  ;
    self.frame = newframe;
}

-(void)addGesture
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HandleTapGesture:)];
    tap.delegate = self;
}

-(void)HandleTapGesture:(UITapGestureRecognizer *)tap
{
    RetweetedStatusView * view = (RetweetedStatusView *)tap.view;
    if([view.imageContentView canPerformAction:@selector(collectionView:didSelectItemAtIndexPath:) withSender:view.imageContentView])
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [view.imageContentView performSelector:@selector(collectionView:didSelectItemAtIndexPath:) withObject:view.imageContentView.myCollectionView withObject:indexPath];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    RetweetedStatusView * view =[[touch.view superview] isKindOfClass:[RetweetedStatusView class]]?(RetweetedStatusView*)[touch.view superview]:(RetweetedStatusView*)touch.view;
    [self.delegate HandleTapGestureForRetweetedStatusView:view];
}



@end
