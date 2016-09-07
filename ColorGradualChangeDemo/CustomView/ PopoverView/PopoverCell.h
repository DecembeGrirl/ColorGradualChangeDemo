//
//  PopoverCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/4/13.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    OnlyHaveText     = 0,  //只有文字
    HaveTextAndImage = 1,  // 有图片和文字
}PopoverCellType;

@interface PopoverCell : UITableViewCell
{
    UIImageView *_imageView;
    UILabel * _textLabel;
    UIView *_lineView;
}
@property (nonatomic,assign)PopoverCellType type;
-(void)configUIWithText:(NSString *)text image:(UIImage *)image;
-(void)setViewsFrame;
@end
