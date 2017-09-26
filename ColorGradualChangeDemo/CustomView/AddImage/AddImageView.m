//
//  AddImageView.m
//  移动物美
//
//  Created by 杨淑园 on 2016/12/23.
//  Copyright © 2016年 赵永生. All rights reserved.
//

#import "AddImageView.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation AddImageView
-(instancetype)initWithImags:(NSArray *)array showAddBtn:(BOOL)isShow
{
    self.isEdit = isShow;
    imageViewWidth = (KScreenWidth - 15 - 3.8 * 4) / 5  ;
    self.items = [NSMutableArray arrayWithCapacity:5];
    self.images = [[NSMutableArray alloc]initWithArray:array];
    if(self = [super init])
    {
        for (int i = 0; i < array.count; i++) {
            [self addItemAtIndex:@(i)];
        }
        self.addbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addbtn setImage:[UIImage imageNamed:@"icon_addImageBtn"] forState:UIControlStateNormal];
        self.addbtn.layer.borderColor = YSHY_COLOR_normal(215, 215, 215).CGColor;
//        self.addbtn.layer.cornerRadius = 5;
        self.addbtn.layer.borderWidth = 0.5;
        [self.addbtn addTarget:self action:@selector(selectedAddbtn) forControlEvents:UIControlEventTouchUpInside];
        [self.addbtn setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.addbtn];
        CGFloat margin =(imageViewWidth* array.count + 15 + 3.8*array.count);
        [self.addbtn setFrame:CGRectMake(margin, 20, imageViewWidth -20, imageViewWidth-20)];
        
        if(isShow == NO || self.images.count >= 5)
        {
            self.addbtn.hidden = YES;
        }
    }
    return  self;
}


-(void)configImages:(NSArray *)array
{
    for (UIView * view in self.subviews) {
        if([view isKindOfClass:[AddImageItem class]])
        {
            [view removeFromSuperview];
        }
    }
    
    self.images  = [array mutableCopy];
    for (int i = 0; i < self.images.count; i++) {
        [self addItemAtIndex:@(i)];
    }
}

-(void)addItemAtIndex:(NSNumber *)index
{
    NSInteger i = [index integerValue];
    AddImageItem * imageViewItem = [[AddImageItem alloc]initWithSize:CGSizeMake(imageViewWidth -10, imageViewWidth-10) IsEdit:self.isEdit];
    id imageObj = self.images[i];
    if([imageObj isKindOfClass:[ALAsset class]])
    {
        ALAsset * asset = imageObj;
        [imageViewItem.myImageView setImage:[UIImage imageWithCGImage:[asset aspectRatioThumbnail]]];
    }
    else
    {
        NSString * url = imageObj;
        [imageViewItem.myImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    }
    imageViewItem.delegate = self;
    [self addSubview:imageViewItem];
    CGFloat margin = index ==0?15:(imageViewWidth* i + 15 + 3.8*i);
    CGFloat top = self.isEdit?10:((80 - imageViewWidth)/2 -5);
    CGFloat width = self.isEdit?imageViewWidth -10:imageViewWidth;
    [imageViewItem setFrame:CGRectMake(margin, top, width, width)];
    [self.items addObject:imageViewItem];
}

-(void)selectedAddbtn
{
    [self.delegate addImage:self.images];
}

-(void)changeAddBtnFrameAtIndex:(NSInteger)index
{
    CGRect frame = self.addbtn.frame;
    CGFloat margin =(imageViewWidth* index + 15 + 3.8*index);
    frame.origin.x = margin;
    self.addbtn.frame = frame;
}
#pragma mark ------AddImageItemDelegate-----
-(void)deleteImage:(AddImageItem *)item
{
    NSInteger index = [self.items indexOfObject:item];
    [self.items removeObject:item];
    [self.images removeObjectAtIndex:index];
    self.addbtn.hidden = NO;
    [item removeFromSuperview];
    [UIView animateWithDuration:0.5f animations:^{
        for (int i = 0 ;i < self.items.count;i++) {
            AddImageItem* item1 = self.items[i];
            CGRect frame = item1.frame;
            CGFloat margin = i ==0?15:(imageViewWidth* i + 15 + 3.8*i);
            frame.origin.x = margin;
            item1.frame = frame;
           
        }
        [self changeAddBtnFrameAtIndex:self.items.count];
     } completion:nil];
    [self.delegate deletImage:self.images];
}

@end
