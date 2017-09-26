//
//  userPhotoTableViewCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/8/29.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "userPhotoTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation userPhotoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self =[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _photoCollectionView = [[UserPhotoCollectionView alloc]init];
         [_photoCollectionView.myCollectionView setBackgroundColor:RGB_COLOR(@"#E8E7E9")];
        [self addSubview:_photoCollectionView];
    }
    return  self;
}

-(void)ConfigCellWith:(Statuses *)obj
{
//    for(int i= 0;i<array.count ;i++)
//    {
//        Statuses * obj = array[i];
//        if(obj.retweeted_status)
//            [_photoCollectionView ConfigCellWithObj:obj.retweeted_status];
//        else
            [_photoCollectionView ConfigCellWithObj:obj];
//    }
}

-(void)configCellWith:(NSArray *)array
{

}

-(void)setCollectionViewFrame
{
    [_photoCollectionView setFrame:self.bounds];
    [_photoCollectionView setCollectionViewFrame];
}


@end
