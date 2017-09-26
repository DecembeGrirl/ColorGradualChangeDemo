//
//  TopicCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "TopicCell.h"
#import "UIView+Frame.h"
@implementation TopicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self CreatUI];
    }
    return  self;

}
-(void)CreatUI
{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, self.height) collectionViewLayout:layout];
    [myCollectionView setBackgroundColor:[UIColor whiteColor]];
    myCollectionView.delegate = self;
    myCollectionView.dataSource = self;
    [myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    
    [self addSubview:myCollectionView];
 
    
}

-(void)ConfigData:(NSArray *)array
{
    
//    dataSource  = array;
    dataSource = @[@"法国小鲜油",@"公共场所建母婴室",@"bigbang is everything",@"热门话题"];
   if(dataSource.count >0)
    [myCollectionView reloadData];
//    for (int i; <#condition#>; <#increment#>) {
//        <#statements#>
//    }
//    [_lable1 setText:@"#法国小鲜油#"];
//    [_lable2 setText:@"#公共场所建母婴室#"];
//    [_lable3 setText:@"#bigbang is everything#"];
//    [_lable4  setText:@"热门话题"];
//    [self layoutFrame];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(dataSource.count >0)
        return 4;
    else
        return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    for (UIView * view in cell.subviews) {
        [view removeFromSuperview];
    }
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2, 20)];
//    [label setText:[NSString stringWithFormat:@"#%@#",dataSource[indexPath.row][@"name"]]];
    
    [label setText:[NSString stringWithFormat:@"#%@#",dataSource[indexPath.row]]];
    [label setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [cell addSubview:label];
    if(!(indexPath.row % 2 ))
    {
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(KScreenWidth / 2-1, 3, 1, 16)];
        [line1 setBackgroundColor:[UIColor colorWithRed:214.0f/255.0f green:214.0f/255.0f blue:214.0f/255.0f alpha:1]];
        [cell addSubview:line1];
    }
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(3, cell.bottom - 1,KScreenWidth / 2 -  8, 1)];
    [line2 setBackgroundColor:[UIColor colorWithRed:214.0f/255.0f green:214.0f/255.0f blue:214.0f/255.0f alpha:1]];
    [cell addSubview:line2];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(KScreenWidth / 2, 25);
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{

}



@end
