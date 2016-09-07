//
//  MyselfViewController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/18.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "MyselfViewController.h"
#import "UIView+Frame.h"
#import "GlobalHelper.h"
#import "NormalSearchCell.h"
@interface MyselfViewController ()

@end

@implementation MyselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ConfigNavBar];
    [self initViews];
    [self registTableView];
}

-(void)initViews
{
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.customNav.bottom, KScreenWidth, KScreenHeight-self.customNav.height - 48) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
}
-(void)ConfigNavBar
{
    [self.customNav setNavTitle:@"我"];
    [self.customNav setBackgroundColor:[UIColor whiteColor]];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"添加好友" forState:UIControlStateNormal];
    [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.customNav setLeftNavButton:leftBtn];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"设置" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.customNav setRightNavButton:rightBtn];
}

-(void)registTableView
{
    [self CreatSomeDate];
    self.delegate = [[MyselfTableViewDelegate alloc]init];
    [self.delegate RegistTableView:_tableView];
    self.delegate.dataSource = _arrayData;
}


-(void)CreatSomeDate
{
    _arrayData = [[NSMutableArray alloc]initWithCapacity:5];
    [_arrayData addObject:[GlobalHelper ShareInstance].user];
    
    NSMutableArray * array1 = [[NSMutableArray alloc]init];
    [array1 addObject:@{@"image":@"tabbar_compose_headlines",@"title":@"新的好友",@"description":@""}];
    [array1 addObject:@{@"image":@"tabbar_compose_delete",@"title":@"微博等级",@"description":@"连续登陆17天"}];
    [_arrayData addObject:array1];
    
    NSMutableArray * array2 = [[NSMutableArray alloc]init];
    [array2 addObject:@{@"image":@"tabbar_compose_productrelease",@"title":@"我的相册",@"description":@""}];
    [array2 addObject:@{@"image":@"tabbar_compose_lbs",@"title":@"我的点评",@"description":@""}];
    [array2 addObject:@{@"image":@"tabbar_compose_lbs",@"title":@"我的赞",@"description":@""}];
    [_arrayData addObject:array2];
    //    [array removeAllObjects];
    NSMutableArray * array3 = [[NSMutableArray alloc]init];
    [array3 addObject:@{@"image":@"tabbar_compose_music",@"title":@"微博支付",@"description":@"末那大鱼海棠手办"}];
    [array3 addObject:@{@"image":@"tabbar_compose_friend",@"title":@"微博运动",@"description":@"每天运动10000步,你达标了吗?"}];
     [_arrayData addObject:array3];
    NSMutableArray * array4 = [[NSMutableArray alloc]init];
    [array4 addObject:@{@"image":@"tabbar_compose_voice",@"title":@"粉丝头条",@"description":@"推广博文及账号的利器"}];
    [array4 addObject:@{@"image":@"tabbar_compose_shooting@3x",@"title":@"粉丝服务",@"description":@"橱窗 私信 营销 数据中心"}];
     [_arrayData addObject:array4];
    NSMutableArray * array5 = [[NSMutableArray alloc]init];
    [array5 addObject:@{@"image":@"tabbar_compose_wbcamera@2x",@"title":@"草稿箱",@"description":@""}];
     [_arrayData addObject:array5];
    
    NSMutableArray *array6 = [[NSMutableArray alloc]init];
    [array6 addObject:@{@"image":@"tabbar_compose_more",@"title":@"更多",@"description":@"文章 收藏"}];
    [_arrayData addObject:array6];




}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
