//
//  TopicCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UILabel * _lable1;
    UILabel * _lable2;
    UILabel * _lable3;
    UILabel * _lable4;
    
    UICollectionView * myCollectionView;
    NSArray * dataSource;
    
//    UIView * _lineview;
    
}

-(void)ConfigData:(NSArray *)array;

@end
