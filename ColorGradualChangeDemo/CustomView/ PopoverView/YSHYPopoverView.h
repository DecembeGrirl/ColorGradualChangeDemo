//
//  YSHYPopoverView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/4/13.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverCell.h"

#define cellHeight 40

typedef enum {
    DirectionFromUP       = 0,    //由上往下
    DirectionFromDown     = 1     // 由下往上
}YSHYPopoverViewDirection;

@interface YSHYPopoverView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property (nonatomic, assign)YSHYPopoverViewDirection direction;
@property (nonatomic, strong)NSArray *dataSorce;
-(void)ConfigDatasource:(NSArray *)array;
-(CGFloat)getHeight;
-(void)showWithView:(UIView *)view;
-(void)hiddenWithView:(UIView *)view;
@end
