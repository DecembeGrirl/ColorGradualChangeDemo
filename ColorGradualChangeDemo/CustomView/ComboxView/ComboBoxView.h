//
//  ComboBoxView.h
//  移动物美
//
//  Created by 杨淑园 on 16/9/22.
//  Copyright © 2016年 赵永生. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  redDotForUplaodTransactionIndexPathRow  3

@protocol ComboBoxViewdelegate <NSObject>

-(void)SelectedComboBoxViewItem:(NSInteger)index;

@end

@interface ComboBoxView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * myTableView;
    UIImageView * backGroundImage;
}
@property (nonatomic, strong)NSArray * titleArray;
@property (nonatomic, strong)NSArray * titleImageArray;

@property (nonatomic, strong)NSIndexPath * redDotIndexpath;
@property (nonatomic,strong)id<ComboBoxViewdelegate>delegate ;
-(void)showRedDotAtIndexPath:(NSIndexPath *)indexpath;

-(void)show;
-(void)hidden;
@end

