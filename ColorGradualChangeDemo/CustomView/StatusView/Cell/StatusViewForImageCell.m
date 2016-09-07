//
//  MyCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import "StatusViewForImageCell.h"
#import "GlobalHelper.h"
#import "Statuses.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "Config.h"

#define headImageWidth  30
@implementation StatusViewForImageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.imageContentView = [[UserPhotoCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width-10, 0)];
        [self.imageContentView.myCollectionView setBackgroundColor:[UIColor whiteColor]];
        self.imageContentView.opaque = YES;
        [self.contentView addSubview:self.imageContentView];
        __weak typeof (self)weakSelf = self;
        self.imageContentView.selectedBlackOutOfcellBlock= ^()
        {
            if (weakSelf.imageContentView.delegate !=nil){
                [weakSelf.myDelegate HandleTapGestureForStatusViewForImageCell:weakSelf];
            }
        };
    }
    return self;
}

-(void)setSubviewsFrame
{
    [super setSubviewsFrame];
    [self.imageContentView setFrame:CGRectMake(5, _contentTextLabel.bottom, self.width ,self.obj.getImageHight)];
    [self.imageContentView setCollectionViewFrame];
    
    CGFloat bottomViewTop =self.imageContentView.bottom?self.imageContentView.bottom:_contentTextLabel.bottom;
    [_bottomView setFrame:CGRectMake(0, bottomViewTop + 2, KScreenWidth , BottomToolViewHeight)];
}

-(void)ConfigCellWithIndexPath:(NSIndexPath *)indexPath Data:(id)data cellType:(CellType)cellType
{
    [super ConfigCellWithIndexPath:indexPath Data:data cellType:cellType];
    [self.imageViewArray removeAllObjects];
    
    self.obj = (Statuses *)data;
    //    [self.imageContentView configImageContentViewWith:self.obj];
    NSMutableArray* array = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in self.obj.pic_urls) {
        NSString *str = [dic[@"thumbnail_pic"] stringByReplacingOccurrencesOfString:Kthumbnail withString:Kbmiddle];
        [array addObject:str];
    }
    [self.imageContentView ConfigCellWith:array];
}
-(CGFloat)cellHeight
{
    if(self.type == COMMENTDETAILSTYPE)
    {
        return self.imageContentView.bottom;
    }
    return _bottomView.bottom;
}
@end
