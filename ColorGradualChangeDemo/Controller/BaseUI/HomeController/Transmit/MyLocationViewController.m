//
//  MyLocationViewController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 2016/12/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "MyLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "SearchBar.h"
#import "UIView+Frame.h"
#import "SearchView.h"
#import "RequsetStatusService.h"
@interface MyLocationViewController ()<CLLocationManagerDelegate,SearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CLLocationManager *locationManager;
    NSArray * dataArray;
}

@property (nonatomic, strong)SearchBar *searchBar;
@property (nonatomic, strong)SearchView * searchView;
@end

@implementation MyLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self startUpdateLocation];
}

-(void)creatUI
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.customNav.titleLabel.text = @"我在这儿";
    UIButton *leftBtn =[CustomNavbar createNavButttonByTitle:@"取消" target:self action:@selector(HandelCancelBtn:)];
    [self.customNav setLeftNavButton:leftBtn];
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.customNav.bottom-22, KScreenWidth, KScreenHeight-35) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.separatorInset = UIEdgeInsetsMake(0, 45, 0, 0);
    [_myTableView setBackgroundColor:[UIColor clearColor]];
    [self.view insertSubview:_myTableView belowSubview:self.customNav];
    _myTableView.contentInset = UIEdgeInsetsMake(20 , 0, 0, 0);


    _searchBar = [[SearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 35)];
    _searchBar.type = CanNotEditType;
    _searchBar.delegate= self;
    [self.view addSubview:_searchBar];
    [_searchBar setTextFieldPlacehoder:@"搜附近位置"];
    _myTableView.tableHeaderView =_searchBar;
}

-(void)HandelCancelBtn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)TextFiledBegingEdite
{
    if(!_searchView)
    {
        _searchView = [[SearchView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _searchView.hidden = YES;
        [_searchView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]];
        [_searchView.searchBar setTextFieldPlacehoder:@""];
        _searchView.label.text = @"";
        [_searchView.hotSearchView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        __weak typeof(self) weakSelf = self;
        
        _searchView.selectedSearchBarCancelBtnBlock = ^()
        {
            weakSelf.tabBarController.tabBar.hidden = NO;
            [weakSelf.myTableView setFrame:CGRectMake(0, self.customNav.bottom-22, KScreenWidth, KScreenHeight-35)];
        };
        [self.view addSubview: _searchView];
    }
    _searchView.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [_searchView SearchBarBecomeFirstResponder];
    [_myTableView setFrame:CGRectMake(0, self.customNav.bottom-48, KScreenWidth, KScreenHeight-35)];
}

-(void)startUpdateLocation
{
    if(![locationManager locationServicesEnabled] &&[CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"定位服务未开启");
    }
    else
    {
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        [locationManager requestAlwaysAuthorization];
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter =  5.0;
        [locationManager startUpdatingLocation];
    }
}
// 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位服务" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL * settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingsURL];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    [locationManager stopUpdatingLocation];
    
    CLLocation *currentLocation = locations.lastObject;
    NSDictionary * dic = @{@"lat":[NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude],@"long":[NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude]};
    
    [[RequsetStatusService shareInstance] getNearbyLocation:dic];
    [RequsetStatusService shareInstance].successBlock=^(NSData *data , WBHttpRequest *request)
    {
        NSDictionary  *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dataArray = dic[@"pois"];
        [self.myTableView reloadData];
    };
}

#pragma  maek - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    NSDictionary * dic = dataArray[indexPath.row];
    cell.textLabel.text = dic[@"title"];
    NSString * str =[dic[@"checkin_num"] longValue]!=0?[NSString stringWithFormat:@"%@人访问过", dic[@"checkin_num"]]:@"";
   str = ![dic[@"address"] isKindOfClass:[NSNull class]]?[NSString stringWithFormat:@"%@ %@",str,dic[@"address"]]:str;
    cell.detailTextLabel.text = str;
    return  cell;
}


@end
