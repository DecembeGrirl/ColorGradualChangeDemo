//
//  FrinedFollowingController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/8/13.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "FrinedFollowingController.h"
#import "Config.h"
#import "YYLabel.h"
#import "PQActionSheet.h"
#import "GlobalHelper.h"
#import "FriendFollowingTableViewCell.h"
#import "FriendFollowingHeaderView.h"
#import "MJRefresh.h"
@interface FrinedFollowingController ()<UITableViewDataSource,UITableViewDelegate,FriendFollowingHeaderViewDelegate>
{
    UITableView * myTableView;
    NSMutableArray * dataArray;
}
@end

@implementation FrinedFollowingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNav.titleLabel.text = @"好友关注动态";
    self.customNav.leftBtn.hidden = NO;
    UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthBtn setTitle:@"..." forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.customNav setRightNavButton:rigthBtn];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(18, 9, 23, 40)];
    label.font = [UIFont systemFontOfSize:14.0];
    label.text = @"首页";
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,KScreenWidth , KScreenHeight )];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view insertSubview:myTableView belowSubview:self.customNav];
    
    myTableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(someData)];
    [myTableView.mj_header beginRefreshing];
}

#pragma  maek - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * array = dataArray[section][@"user"];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellId";
    FriendFollowingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[FriendFollowingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell ConfigData:dataArray[indexPath.section][@"user"][indexPath.row]];
    return  cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendFollowingTableViewCell * myCell = (FriendFollowingTableViewCell *)cell;
    [myCell setSubViewFrame];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FriendFollowingHeaderView * view = [[FriendFollowingHeaderView alloc]initWithFrame:CGRectMake(0, 5, KScreenWidth, 30)];
    view.delegate = self;
    [view configData:dataArray[section] section:section];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:  (NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 35;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(void)rightBtnClick
{
    __weak typeof(self)weakSelf = self;
    PQActionSheet * sheet = [[PQActionSheet alloc]initWithTitle:nil clickedAtIndex:^(NSInteger index) {
        if (index == 0) {
            [weakSelf someData];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:NO];
        }
        
    } cancelButtonTitle:@"取消" otherButtonTitles:@"刷新",@"返回首页",nil];
    [sheet show];
}

-(void)selectedfollowingBtn:(NSInteger)section
{
    NSMutableArray * array  = dataArray[section][@"user"];
    PQActionSheet * sheet = [[PQActionSheet alloc]initWithTitle:nil clickedAtIndex:^(NSInteger index) {
    } cancelButtonTitle:@"取消" otherButtonTitles:nil];
    for(NSDictionary * dic in array)
    {
        NSString *str = [NSString stringWithFormat:@"不再推荐 @%@",dic[@"name"]];
        [sheet addButtonWithTitle:str];
    }
    [sheet show];
}
// 假数据
-(void)someData
{
    dataArray = [[NSMutableArray alloc]init];
    NSMutableDictionary * dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setValue:@"@追美剧学英文" forKey:@"title"];
    [dic1 setValue:@"114万" forKey:@"followCount"];
    NSMutableArray * array= [[NSMutableArray alloc]init];
     NSMutableDictionary * user1 = [[NSMutableDictionary alloc]init];
    [user1 setValue:@"旅行笔录" forKey:@"name"];
    [user1 setValue:@"default.png" forKey:@"headerImage"];
    [user1 setValue:@"知名旅行博主" forKey:@"descrip"];
    [user1 setValue:@"来一场说走就走的旅行" forKey:@"leastStatuses"];
    [array addObject:user1];
    
    NSMutableDictionary * user2 = [[NSMutableDictionary alloc]init];
    [user2 setValue:@"触碰心坎的那些话" forKey:@"name"];
    [user2 setValue:@"default.png" forKey:@"headerImage"];
    [user2 setValue:@"微博知名情感两性账号" forKey:@"descrip"];
    [user2 setValue:@"向来缘浅,奈何情深" forKey:@"leastStatuses"];
    [array addObject:user2];
    [dic1 setObject:array forKey:@"user"];
    
    [dataArray addObject:dic1];
    [dataArray addObject:dic1];
    [dataArray addObject:dic1];
    [dataArray addObject:dic1];
    [dataArray addObject:dic1];
    [dataArray addObject:dic1];
    
    [myTableView reloadData];
}

@end
