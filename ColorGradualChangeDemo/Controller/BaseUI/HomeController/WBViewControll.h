//
//  ViewController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "BaseController.h"
#import "WeiboTableViewDelegate.h"
#import "StatusViewForImageCell.h"
#import "HeadView.h"
#import "WeiboSDK.h"
#import "Config.h"
#import "GlobalHelper.h"
//#import "StatusObj.h"
#import "RetweetedStatusViewCell.h"
#import "StatusViewForImageCell.h"
#import "SearchBar.h"
#import "SearchView.h"
#import "MBProgressHUD.h"
#import "BaseCell.h"
@interface WBViewControll : BaseController
{
    NSMutableArray * _statusArr;
    MBProgressHUD * _hud;
    int _page;
    SearchView * _searchView;
    SearchBar * _searchBar;
    UserPhotoCollectionView *_imageContentView;
    BaseCell * _selectedCell;
    NSInteger  _selectedIndex;
}
@property (nonatomic, assign) int tempCount;

@property (nonatomic, strong) UITableView * table;
@property (nonatomic, strong)WeiboTableViewDelegate * tableViewDelegate;

-(void)refreshData;
//@property (nonatomic, strong) SearchBar * searchBar;
@end

