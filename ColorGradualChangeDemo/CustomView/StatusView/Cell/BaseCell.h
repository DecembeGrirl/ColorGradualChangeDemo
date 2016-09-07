//
//  BaseCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/12.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHelper.h"
#import "UIView+Frame.h"
#import "Statuses.h"
#import "Config.h"
#import "UIImageView+WebCache.h"
#import "Config.h"
#import "BottomToolView.h"
#import "YYText.h"
#import "RetweetedStatusView.h"
//#import "NSString+YYAdd.h"

typedef enum {
    cellTypeOfDetails  = 0,  // 详情页的cell显示
    cellTypeOfNomarl ,
}CellType;

@class BaseCell;
@protocol BaseCellDelegate <NSObject>

-(void)SelectedCellBtn:(BaseCell *)cell btnType:(CommentType)type;
-(void)SelectedNameOrHeader:(BaseCell *)cell;
-(void)SelectedMoreBtn:(BaseCell *)cell;
@end

@interface BaseCell : UITableViewCell<BottomToolViewBtnDelegate>
{
    UIImageView * _headImageView;
    YYLabel * _nickNameLabel;
    YYLabel *_contentTextLabel;
    UIButton *_moreBtn;
    
    BottomToolView *_bottomView;
    
}
@property (nonatomic, assign)CellType cellType;   
@property (nonatomic, assign)CommentType type;
@property (nonatomic, strong)Statuses * statusObj;
@property (nonatomic, strong)NSMutableArray *imageViewArray;
@property (nonatomic, weak)id<BaseCellDelegate>delegate;
-(void)ConfigCellWithIndexPath:(NSIndexPath *)indexPath Data:(id)data cellType:(CellType)cellType;
-(CGFloat)cellHeight;
-(void)setSubviewsFrame;
-(void)selectedYYLable;
-(void)setHeadImageUserInterActionEnable:(BOOL)userInaterActionEnable;

-(void)setMoreBtnImageWithImage;

//-(void)setSubviewsFrame;
@end
