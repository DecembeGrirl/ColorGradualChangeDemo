//
//  MessageViewController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/18.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "MessageViewController.h"
#import "UIView+Frame.h"
#import "MJRefresh.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ConfigNavBar];
    [self initViews];
}

-(void)initViews
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.customNav.bottom -38, KScreenWidth, KScreenHeight-35) style:UITableViewStylePlain];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 45, 0, 0);
    [_tableView setBackgroundColor:[UIColor clearColor]];
    [self.view insertSubview:_tableView belowSubview:self.customNav];
    _tableView.contentInset = UIEdgeInsetsMake(20 , 0, 0, 0);
    
    __block typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        _page=1;
//        [weakSelf FetchWeiBo];
        [weakSelf->_tableView.mj_header endRefreshing];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter
                            footerWithRefreshingBlock:^{
//                                _page ++;
//                                [weakSelf FetchWeiBo];
                                [weakSelf->_tableView.mj_header endRefreshing];
                            }];
    
//    _searchBar = [[SearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 35)];
//    _searchBar.type = CanNotEditType;
//    _searchBar.delegate= self;
//    _tableView.tableHeaderView =_searchBar;
    
    self.tableViewDelegate =[[MessageTableViewDelegate alloc]init];
    [self.tableViewDelegate registTableView:_tableView Data:nil];
//    _statusArr = [NSMutableArray arrayWithCapacity:5];
//    _page = 1;
}



-(void)ConfigNavBar
{
    [self.customNav setBackgroundColor:[UIColor whiteColor]];
    [self.customNav setNavTitle:@"消息"];
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"发现群" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.customNav setLeftNavButton:leftBtn];
    [self.customNav setRightNavButton:[[self.customNav class]createNavButtonByImageNormal:@"navigationbar_icon_radar" imageSelected:@"navigationbar_icon_radar_highlighted" target:self action:@selector(HandleRightNavBtn:)]];
}

-(void)HandleLeftNavBtn:(UIButton *)btn
{
    NSLog(@"点击发现群");
}

-(void)HandleRightNavBtn:(UIButton *)btn
{
    NSLog(@"点击消息");
}

-(void)refreshData
{
    [_tableView.mj_header beginRefreshing];
}

#pragma mark - SearchBarDelegate
-(void)TextFiledBegingEdite
{
    if(!_searchView)
    {
        _searchView = [[SearchView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _searchView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _searchView.selectedSearchBarCancelBtnBlock = ^()
        {
            weakSelf.tabBarController.tabBar.hidden = NO;
        };
        [self.view addSubview: _searchView];
    }
    _searchView.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [_searchView SearchBarBecomeFirstResponder];
}



@end
