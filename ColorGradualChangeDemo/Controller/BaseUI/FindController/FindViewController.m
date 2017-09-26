//
//  FindViewController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/18.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "FindViewController.h"
#import "UIView+Frame.h"
#import "FindeTableViewDelegate.h"
#import "CycleScrollCell.h"
#import "TopicCell.h"
#import "NormalSearchCell.h"
#import "RequsetStatusService.h"
@interface FindViewController ()<SearchBarDelegate>
{
    NSArray * trendsArray;
}
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.customNav.hidden = YES;
    
    _dataArray = [[NSMutableArray alloc]init];
    trendsArray = [[NSMutableArray alloc]init];
    [self CreatSearchBar];
    [self CreatSomeData];
    [self ConfigTableView];
//    [self getTrendHourly];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    _centeBtn.hidden = NO;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"centerBtnShow" object:nil];
}



-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_searchBar.textField resignFirstResponder];
    [_dataArray removeAllObjects];
}

-(void)CreatSearchBar
{
    _searchBar = [[SearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.width, SearchBarHeight )];
    _searchBar.type = CanNotEditType;
    _searchBar.delegate= self;
    [self.view addSubview:_searchBar];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _searchBar.bottom, KScreenWidth,KScreenHeight - _searchBar.bottom - 48)];
    [self.view addSubview:_tableView];
    self.findeTableViewDelegate = [[FindeTableViewDelegate alloc]init];
    
    _searchView = [[SearchView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _searchView.hidden = YES;
    __weak typeof(self) weakSelf = self;
    _searchView.selectedSearchBarCancelBtnBlock = ^()
    {
        weakSelf.tabBarController.tabBar.hidden = NO;
    };
    [self.view addSubview: _searchView];
}

-(void)ConfigTableView
{
    self.findeTableViewDelegate.dataSource = _dataArray;
    [self.findeTableViewDelegate RegistTableView:_tableView];
     [_tableView reloadData];
    __weak typeof(self)weakSelf = self;
    self.findeTableViewDelegate.configCellBlock=^(NSIndexPath * indexPath,id item,UITableViewCell * cell)
    {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if([cell isKindOfClass:[CycleScrollCell class]])
        {
            CycleScrollCell * cycleScrollCell = (CycleScrollCell *)cell;
            [cycleScrollCell ConfigCycleScrolView:@[[UIImage imageNamed:@"scrollImage1"],[UIImage imageNamed:@"scrollImage2"],[UIImage imageNamed:@"scrollImage3"]]];
        }
        else if ([cell isKindOfClass:[TopicCell class]])
        {
            TopicCell * topicCell = (TopicCell *)cell;
            [topicCell ConfigData:strongSelf->_dataArray.lastObject];
        }
        else if([cell isKindOfClass:[NormalSearchCell class]])
        {
            NormalSearchCell * normalCell = (NormalSearchCell *)cell;
            [normalCell ConfigData:strongSelf->_dataArray[indexPath.section - 2][indexPath.row]];
        }
    };
}

-(void)TextFiledBegingEdite
{
    [self.view endEditing:YES];
    _searchView.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
//    [_searchBar.textField resignFirstResponder];
//    [_searchBar endEditing:YES];
//    [_searchView.searchBar.textField becomeFirstResponder];
    [_searchView SearchBarBecomeFirstResponder];
}

-(void)getTrendHourly
{
    __weak typeof(self) weakSelf = self;
    [[RequsetStatusService shareInstance] getTrendHourly];
    [RequsetStatusService shareInstance].successBlock = ^(NSData *data , WBHttpRequest *request)
    {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary * trendsDic = dic[@"trends"];
        if(trendsDic){
        trendsArray  = [trendsDic objectForKey:[trendsDic allKeys][0]];
        [_dataArray  addObject:trendsArray];
        [weakSelf ConfigTableView];
        }
    };
}

-(void)CreatSomeData
{
    NSMutableArray * array1 = [[NSMutableArray alloc]init];
    [array1 addObject:@{@"image":@"tabbar_compose_headlines",@"title":@"热门微博",@"description":@"全站最热微博尽收罗"}];
    [array1 addObject:@{@"image":@"tabbar_compose_delete",@"title":@"找人",@"description":@""}];
    [_dataArray addObject:array1];
    
    NSMutableArray * array2 = [[NSMutableArray alloc]init];
    [array2 addObject:@{@"image":@"tabbar_compose_productrelease",@"title":@"玩游戏",@"description":@"玩樱桃小丸子 赢免费日本游"}];
    [array2 addObject:@{@"image":@"tabbar_compose_lbs",@"title":@"周边",@"description":@"发现\"定慧寺\"值得去的地儿"}];
    [_dataArray addObject:array2];
    
    NSMutableArray * array3 = [[NSMutableArray alloc]init];
    [array3 addObject:@{@"image":@"tabbar_compose_music",@"title":@"股票",@"description":@"赚钱的操作尽在股票组合"}];
    [array3 addObject:@{@"image":@"tabbar_compose_friend",@"title":@"电影",@"description":@"优惠电影就在这里!"}];
    [array3 addObject:@{@"image":@"tabbar_compose_voice",@"title":@"红人淘",@"description":@"全网唯一网红资讯频道"}];
    [array3 addObject:@{@"image":@"tabbar_compose_shooting@3x",@"title":@"微博头条",@"description":@"随时随地一起看新闻"}];
    [array3 addObject:@{@"image":@"tabbar_compose_wbcamera@2x",@"title":@"鲜城-北京",@"description":@"本地最有特色的美食福利推荐"}];
    [array3 addObject:@{@"image":@"tabbar_compose_more",@"title":@"更多",@"description":@""}];
    [_dataArray addObject:array3];
}

@end
