//
//  ViewController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import "WBViewControll.h"
#import "MJRefresh.h"
#import "SDImageCache.h"
#define headImageheight  200
@interface WBViewControll ()<UINavigationControllerDelegate>
@end

@implementation WBViewControll

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initViews];
    [self ConfigTableView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self FetchWeiBo];
}

-(void)initViews
{
    self.headView = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, headImageheight)];

    [self.view addSubview:self.headView];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.table setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.table];
    self.table.contentInset = UIEdgeInsetsMake(headImageheight , 0, 0, 0);
//    self.table.tableHeaderView = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(HandlePushDownRefreshing)];
//    [self.table.tableHeaderView setFrame:CGRectMake(0, 0, 0, 0)];
    self.navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.navBar setBackgroundColor:[UIColor redColor]];
    self.navBar.hidden = YES;
    self.navBar.alpha = 0.0f;
    [self.view addSubview:self.navBar];
    
    self.tableViewDelegate =[[TableViewDelegate alloc]init];
    
    _statusArr = [NSMutableArray arrayWithCapacity:5];
}


-(void)ConfigTableView
{
    __weak id weakSelf = self;
    [self.tableViewDelegate RegistTableView:self.table];
    
    self.tableViewDelegate.configCellBlock = ^(NSIndexPath * indexPath,id item,BaseCell * cell){
        [cell ConfigCellWithIndexPath:indexPath Data:item];
    };
    self.tableViewDelegate.scrollViewDidScrollBlock= ^(UIView * view)
    {
        [weakSelf ScaleHeadViewWithScrollView:view];
    };
    
}
//对headImageView 进行缩放
-(void)ScaleHeadViewWithScrollView:(UIView *)view
{
    UITableView * tableview = (UITableView * )view;
    CGFloat offsetY = tableview.contentOffset.y;
    CGFloat dely =headImageheight+offsetY ;
    if(dely<=0  && fabs(dely) < 100)
    {
        self.navBar.hidden = YES;
        CGFloat height = fabs(offsetY);
        CGRect rect = self.headView.frame;
        rect.size.height = height;
        rect.origin.y = 0;
        self.headView.frame = rect;
    }else if( dely > 0)
    {
        [self.headView setFrame:CGRectMake(0, -fabs(dely), self.headView.frame.size.width,headImageheight)];
        CGFloat alpha = fabs(dely)/ headImageheight *1.5;
            alpha = alpha>1?1:alpha;
            self.navBar.hidden = NO;
        self.navBar.alpha =alpha;
    }
    else
    {
        self.table.contentOffset = CGPointMake(0, -(headImageheight + 100));
    }
    [self.headView layoutIfNeeded];
}

-(void)HandlePushDownRefreshing
{
    [self FetchWeiBo];
    [self.table reloadData];
}



-(void)FetchWeiBo
{
//    NSString * userID = [GlobalHelper getSsoInfoValueOfKey:@"userID"];
        NSString *accessToken = [GlobalHelper getSsoInfoValueOfKey:Kaccess_token];
//        NSString *typ
    NSDictionary * params = @{Kaccess_token:accessToken};
    [WBHttpRequest requestWithURL:KUserAndeFriendWeiBo httpMethod:@"GET" params:params delegate:self withTag:@"userAndFriendWeibo"];
}


//数据加载成功
-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
{
    NSLog(@"加载成功");
    NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if(dataDic)
    {
        NSArray * statuses = dataDic[Kstatuses];
        for (int i = 0; i < statuses.count; i ++) {
            StatusObj * obj = [[StatusObj alloc]init];
            [obj setStatusWithData:statuses[i]];
            [_statusArr addObject:obj];
        }
    }
     self.tableViewDelegate.dataSource = _statusArr;
    [self.table reloadData];

   
    
}

-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"数据加载失败!");
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    NSLog(@"内存警告!");
}


@end
