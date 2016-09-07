//
//  FindViewController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/18.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "BaseController.h"
#import "SearchBar.h"
#import "FindeTableViewDelegate.h"
#import "SearchView.h"
@interface FindViewController : BaseController
{
    SearchBar * _searchBar;
    UITableView * _tableView;
    SearchView * _searchView;
//    PullDownView * _pullDownView;
//    UIView * _hotSearchView;
    NSMutableArray * _dataArray;
}
@property (nonatomic, strong)FindeTableViewDelegate *findeTableViewDelegate;
@end
