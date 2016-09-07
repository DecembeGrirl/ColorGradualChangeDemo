//
//  ImageContenCollectionView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/7/14.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "ImageContenCollectionView.h"

@implementation ImageContenCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if(self = [super initWithFrame:frame collectionViewLayout:layout])
    {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

-(void)ConfigCollectionView:(Statuses * )statuses
{
    self.dataArray = statuses.pic_urls;
   
    CGRect frame = self.frame;
    CGFloat height = [statuses getImageHight];
    frame.size.height = height;
    self.frame = frame;
    [self reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"CellID";
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[UICollectionViewCell alloc]init];
    }
    if(indexPath.row % 4 == 1)
    {
         [cell setBackgroundColor:[UIColor redColor]];
    }else if(indexPath.row % 4 == 2)
    {
        [cell setBackgroundColor:[UIColor greenColor]];
    }
    else if(indexPath.row % 4 == 3)
    {
        [cell setBackgroundColor:[UIColor yellowColor]];
    }
    else
    {
        [cell setBackgroundColor:[UIColor grayColor]];
    }
    
    
    [cell.subviews.lastObject removeFromSuperview];
//    NSString * str = self.dataArray[indexPath.row];
    NSString * thumPicURL = self.dataArray[indexPath.row][Kthumbnail_pic];
    NSString * picURL = [thumPicURL stringByReplacingOccurrencesOfString:Kthumbnail withString:Kbmiddle];
//    NSLog(@"%@",cell.subviews);
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:cell.frame];
    [imageView setBackgroundColor:[UIColor redColor]];
    [imageView sd_setImageWithURL:[NSURL URLWithString:picURL]];
    [cell addSubview:imageView];
    return cell;

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger col = self.dataArray.count / 3 ;
    CGFloat width = KsigleImageViewWidth;
    if(col < 1)
    {
        width = self.dataArray.count % 3 == 1?220:(KScreenWidth - 5)/2 - 4;
    }
        return CGSizeMake(width, width);
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIView * view =cell.subviews.lastObject;
    [view setFrame:cell.frame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
