//
//  WBDetailsController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/8.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "BaseController.h"
#import "Statuses.h"
#import "DetailsTableViewDelegate.h"
#import "Config.h"
#import "UserPhotoCollectionView.h"
//#import "ImageContentView.h"
#import "BottomToolView.h"
typedef void (^BackBlock)(Statuses *obj);

@interface WBDetailsController : BaseController
{
    NSMutableArray *_dataArray;
    NSMutableDictionary * _dataDic;  //存放转发 评论 和赞
    UserPhotoCollectionView * _imageContentView;
    BottomToolView *_bottomToolView;
}

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)DetailsTableViewDelegate * myTableViewDelegate;
@property (nonatomic, assign)CommentType type;
@property (nonatomic, strong)Statuses *obj;
@property (nonatomic, strong)BaseCell * baseCell;
@property (nonatomic, copy)BackBlock backBlock;
@end
