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
        //        [_contentTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
        //        _contentTextLabel.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        ////            [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        //            NSLog(@"%@",text);
        //        };
        //        [GlobalHelper ShareInstance].selectedYYLabelRangeTextBlock=^(UIView * containerView, NSAttributedString * text, NSRange range, CGRect rect)
        //        {
        //            NSString * str = [[text string] substringWithRange:range];
        //            UIAlertView * alertView= [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"点击了 %@", str] delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
        //            [alertView show];
        //        };
        _imageViewArray = [NSMutableArray arrayWithCapacity:1];
        
        self.imageContentView = [[UserPhotoCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, 0)];
        [self.imageContentView.myCollectionView setBackgroundColor:RGB_COLOR(@"#E8E7E9")];
        self.imageContentView.opaque = NO;
        __weak typeof (self)weakSelf = self;
        self.imageContentView.selectedBlackOutOfcellBlock= ^()
        {
            [weakSelf.delegate HandleTapGestureForRetweetedStatusView:weakSelf];
        };
        [self addSubview:self.imageContentView];
        self.userInteractionEnabled = YES;
        [self addGesture];
    }
    return  self;
}

-(void)ConfigUIWithData:(id)data
{
    self.obj = (Statuses *)data;
    NSString * userName=self.obj.user.name==nil?self.obj.user.screen_name:self.obj.user.name;
    NSString *contentText = self.obj.text;
    _contentTextLabel.attributedText =[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"@%@:%@",userName,contentText]];
    _contentTextLabel.userInteractionEnabled = YES;
    _contentTextLabel.attributedText = [[GlobalHelper ShareInstance]setStr:_contentTextLabel.text WithColor:RGB_COLOR(@"#0099FF") WithFont:14.0f];
    [_imageViewArray removeAllObjects];
    
    NSMutableArray* array = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in self.obj.pic_urls) {
        NSString *str = [dic[@"thumbnail_pic"] stringByReplacingOccurrencesOfString:Kthumbnail withString:Kbmiddle];
        [array addObject:str];
    }
    [self.imageContentView ConfigCellWith:array];
}

-(void)setSubviewsFrame
{
    CGSize contentTextSize = [GlobalHelper CalculateYYlabelHeightAttributedString:_contentTextLabel.attributedText Size:CGSizeMake(KScreenWidth -10, MAXFLOAT)];
    [_contentTextLabel setFrame:CGRectMake(5, 0, ceilf(contentTextSize.width) , ceil(contentTextSize.height) )];
    [self.imageContentView setFrame:CGRectMake(5,_contentTextLabel.bottom ,self.width ,self.obj.getImageHight)];
    [self.imageContentView setCollectionViewFrame];
    //    self.obj.getImageHight
    CGFloat height = self.imageContentView.bottom;
    CGRect newframe = self.frame;
    newframe.size.height = height+2  ;
    self.frame = newframe;
}

-(void)addGesture
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HandleTapGesture:)];
    tap.delegate = self;
    //    [self addGestureRecognizer:tap];
}

-(void)HandleTapGesture:(UITapGestureRecognizer *)tap
{
    RetweetedStatusView * view = (RetweetedStatusView *)tap.view;
    if([view.imageContentView canPerformAction:@selector(collectionView:didSelectItemAtIndexPath:) withSender:view.imageContentView])
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [view.imageContentView performSelector:@selector(collectionView:didSelectItemAtIndexPath:) withObject:view.imageContentView.myCollectionView withObject:indexPath];
    }
    else
    {
        
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    
    RetweetedStatusView * view =[[touch.view superview] isKindOfClass:[RetweetedStatusView class]]?(RetweetedStatusView*)[touch.view superview]:(RetweetedStatusView*)touch.view;
    
    [self.delegate HandleTapGestureForRetweetedStatusView:view];
}



@end
