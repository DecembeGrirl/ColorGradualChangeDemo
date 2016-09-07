//
//  UserHomeController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/21.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "BaseController.h"
#import "HeadView.h"
#import "UserHomeTableViewDelegate.h"
#import "UserInfoTableHeaderView.h"
//#import "UserObj.h"
#import "SearchView.h"
#import "UserInfoBottomView.h"
#import "YSHYPopoverView.h"
#import "MBProgressHUD.h"
@interface UserHomeController : BaseController<SearchBarDelegate,UserInfoTableHeaderViewDelegate,userPhotoCollectionViewDelegate>
{
    HeadView * _headView;
    UITableView * _tableView;
    UserInfoTableHeaderView * _tableHeaderView;
    SearchView * _searchView;
    UIStatusBarStyle _statusBarsStyle;
    UserInfoBottomView *_bottomToolView;
    
    UserPhotoCollectionView * _imageContentView;
    int _page;
    MBProgressHUD * _hud;
    BaseCell * _selectedCell;
    NSInteger  _selectedIndex;
    NSInteger _photoPage;
}
@property (nonatomic, strong)YSHYPopoverView *popoverView;
@property (nonatomic, strong)YSHYPopoverView *hotPopView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, strong)User * userObj;
@property (nonatomic, strong)UserHomeTableViewDelegate *tableViewDelegate;


@end
