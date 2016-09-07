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


-(void)ConfigCellWith:(NSArray *)array
{
//    dataArray = array;
    dataArray = @[@"http://tva2.sinaimg.cn/crop.0.0.996.996.1024/e99f2c66jw8f2dps8rc6tj20ro0rpgna.jpg",@"http://ww4.sinaimg.cn/bmiddle/df2c3b44gw1f7c10c605fj20j60if45s.jpg",@"http://ww3.sinaimg.cn/bmiddle/df2c3b44gw1f7c10gipnej20ht1ghncj.jpg",@"http://ww3.sinaimg.cn/bmiddle/006tGpI1jw1f7bijrgzghj30gv0gvt99.jpg",@"http://ww1.sinaimg.cn/bmiddle/006iEOlXgw1f7cpn6khvzj30j60j7wg5.jpg",@"http://ww2.sinaimg.cn/bmiddle/006iEOlXgw1f7cpn6sdmej30b40b43z9.jpg",@"http://ww4.sinaimg.cn/bmiddle/006bkE4Cgw1f7af853p21j30c70bpmz1.jpg",@"http://ww3.sinaimg.cn/bmiddle/006bkE4Cgw1f7af82l99jj30c80bqdh4.jpg",@"http://ww4.sinaimg.cn/bmiddle/006bkE4Cgw1f7af839332j30c80bbgo0.jpg",@"http://ww2.sinaimg.cn/bmiddle/00658JkGgw1f742yuamptj30kh0jq495.jpg"];
    [_photoCollectionView ConfigCellWith:dataArray];
}


-(void)setCollectionViewFrame
{
    [_photoCollectionView setFrame:self.bounds];
    [_photoCollectionView setCollectionViewFrame];
}


@end
