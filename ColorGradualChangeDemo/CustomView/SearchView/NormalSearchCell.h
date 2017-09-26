//
//  NomarlFindCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalSearchCell : UITableViewCell
{
    UIImageView  * _imageView;
    
    
}
@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UILabel * sublabel;
@property (nonatomic, strong) UIView * lineView ;
-(void)ConfigData:(NSDictionary *)dic;
@end
