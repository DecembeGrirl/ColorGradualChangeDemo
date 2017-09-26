//
//  UserPhotoCollectionCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 2017/3/7.
//  Copyright © 2017年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Statuses.h"
typedef void(^SaveStatusImageBlcok)(UIImage * image ,NSIndexPath *indexPath);


@interface UserPhotoCollectionCell : UICollectionViewCell


@property (nonatomic, assign)BOOL isloadImage;
@property (nonatomic, strong)UIImage * orignImage;
@property (nonatomic, strong)Statuses  * statusObj;
@property (nonatomic, strong)UIImageView * imageView;
@property (nonatomic, strong)NSIndexPath * indexPath;

@property (nonatomic, strong)SaveStatusImageBlcok saveStatusImageBlcok;
-(void)ConfigData:(NSString *)urlStr andImage:(UIImage *)image;

@end
