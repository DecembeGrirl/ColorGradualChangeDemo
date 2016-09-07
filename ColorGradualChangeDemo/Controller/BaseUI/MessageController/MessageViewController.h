//
//  MessageViewController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/18.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "BaseController.h"
#import "SearchBar.h"
#import "SearchView.h"
#import "MessageTableViewDelegate.h"
@interface MessageViewController : BaseController<SearchBarDelegate>
{
    UITableView * _tableView;
    SearchBar * _searchBar;
    SearchView * _searchView;
}
@property (nonatomic, strong)MessageTableViewDelegate * tableViewDelegate;
-(void)refreshData;
@end
