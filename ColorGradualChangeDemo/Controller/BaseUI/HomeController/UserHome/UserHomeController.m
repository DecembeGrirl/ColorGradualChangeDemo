//
//  UserHomeController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/21.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "UserHomeController.h"
#import "GlobalHelper.h"
#import "UIView+Frame.h"
#import "WBHttpRequest.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
#import "ShowBigView.h"
#import "WBDetailsController.h"
#import "RequsetStatusService.h"
#import "MJExtension.h"
#import "PQActionSheet.h"
@interface UserHomeController ()<WBHttpRequestDelegate,RetweetedStatusViewDelegate,ShowBigViewDelegate>

@end

@implementation UserHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self ConfigNavBar];
    [self CreatUI];
    [self ConfigTable];
    [self ConfigHeadView];
    [self conntectNetworkingResult];
    [self BottomToolViewBlock];
    [self initPopoverView];
    
    _hud = [[GlobalHelper ShareInstance]ShowHUD:_hud WithMessage:@"玩命加载中..." afterDelay:0 inView:_tableView];
    [[RequsetStatusService shareInstance] FetchWeiBo:_page];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
-(void)ConfigNavBar
{
    self.customNav.leftBtn.hidden = NO;
    [self.customNav setBackgroundColor:[UIColor clearColor]];
    self.customNav.leftBtn.titleLabel.text = @"首页";
    
    UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightNavBtn addTarget:self action:@selector(ClickRightNavBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightNavBtn setTitle:@"..." forState:UIControlStateNormal];
    [self.customNav setRightNavButton:rightNavBtn];
    [self.customNav setBackgroundColor:[UIColor yellowColor]];
    UIButton  * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_search"] forState:UIControlStateNormal];
    [searchBtn setFrame:CGRectMake(self.customNav.rightBtn.left -  30, rightNavBtn.top, 25, 25)];
    [searchBtn addTarget:self action:@selector(handleSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.customNav addSubview:searchBtn];
}

-(void)CreatUI
{
    //下拉放大 view
    _headView= [[HeadView alloc]initWithFrame:CGRectMake(0, -headImageheight, self.view.width,headImageheight)];
    _headView.contentMode = UIViewContentModeScaleAspectFill;
    
    //这是 主页 微博  相册  view
    _tableHeaderView = [[UserInfoTableHeaderView alloc]initWithFrame:CGRectMake(0, headImageheight - 40,KScreenWidth, 40)];
    _tableHeaderView.delegate = self;
    // 微博tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - BottomToolViewHeight)style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    _tableView.contentInset = UIEdgeInsetsMake(_tableHeaderView.bottom, 0, 0, 0);
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    __block typeof(self) weakSelf = self;
    _tableView.mj_footer = [MJRefreshBackNormalFooter
                            footerWithRefreshingBlock:^{
                                weakSelf->_page ++;
                                [[RequsetStatusService shareInstance] FetchWeiBo:_page];
                            }];
    [_tableView addSubview:_headView];
    [self.view insertSubview:_tableHeaderView aboveSubview:_tableView];
    [self.view insertSubview:_tableView belowSubview:self.customNav];
    [_tableView sendSubviewToBack:_headView];
    
    //底部工具栏
    _bottomToolView= [[UserInfoBottomView alloc]initWithFrame:CGRectMake(0, KScreenHeight - BottomToolViewHeight , KScreenWidth, BottomToolViewHeight)];
    [_bottomToolView ConfigUIWIthData:self.userObj];
    [self.view addSubview:_bottomToolView];
    
    //搜索view
    _searchView = [[SearchView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _searchView.hidden = YES;
    _searchView.searchBar.delegate = self;
    _searchView.searchBar.type = CanNotPullDown;
    [self.view addSubview: _searchView];
    
    self.tableViewDelegate = [[UserHomeTableViewDelegate alloc]init];
    self.tableViewDelegate.type = TypeOfUserStatusTableView;
    [self.tableViewDelegate RegistTableView:_tableView];
    
    self.dataSource = [[NSMutableArray alloc]initWithCapacity:2];
    _page = 1;
    _photoPage = 1;
}

-(void)initPopoverView
{
    _popoverView = [[YSHYPopoverView alloc]init];
    _popoverView.hidden = YES;
    [self.popoverView ConfigDatasource:@[@"取消关注",@"添加关注"]];
    [self.view insertSubview:_popoverView belowSubview:_bottomToolView];
    
    _hotPopView =[[YSHYPopoverView alloc]init];
    _hotPopView.hidden = YES;
    [self.hotPopView ConfigDatasource:@[@"热门内容",@"话题",@"文章"]];
    [self.view insertSubview:_hotPopView belowSubview:_bottomToolView];
}

-(void)ConfigHeadView
{
    [_headView ConfigDataWithUserInfo:self.userObj];
}

-(void)ConfigTable
{
    __block typeof(self) weakSelf  = self;
    self.tableViewDelegate.configCellBlock=^(NSIndexPath * indexPath,id item,BaseCell * cell){
        [cell ConfigCellWithIndexPath:indexPath Data:item cellType:cellTypeOfNomarl];
        if([cell isKindOfClass:[RetweetedStatusViewCell class]])
        {
            RetweetedStatusViewCell *tempcell = (RetweetedStatusViewCell*)cell;
            tempcell.retweetedStatusView.delegate = weakSelf;
            tempcell.retweetedStatusView.imageContentView.delegate = weakSelf;
        }
        else if ([cell isKindOfClass:[StatusViewForImageCell class]])
        {
            StatusViewForImageCell * tempCell = (StatusViewForImageCell *)cell;
            tempCell.imageContentView.delegate = weakSelf;
        }
    };
    self.tableViewDelegate.scrollViewDidScrollBlock= ^(UIView * view)
    {
        [weakSelf ScaleHeadViewWithScrollView:view];
    };
    self.tableViewDelegate.selectedCellBlock =^(UITableViewCell *cell)
    {
        [weakSelf hiddenPopView];
        BaseCell * tempCell = (BaseCell *)cell;
        weakSelf->_selectedCell  = tempCell;
        if([tempCell canPerformAction:@selector(selectedYYLable) withSender:tempCell])
        {
            [tempCell performSelector:@selector(selectedYYLable) withObject:tempCell];
        }
        WBDetailsController *VC = [[WBDetailsController alloc]init];
        VC.obj = tempCell.statusObj;
        VC.type = COMMENTDETAILSTYPE;
        VC.backBlock = ^(Statuses *obj)
        {
            [weakSelf->_dataSource replaceObjectAtIndex:weakSelf->_selectedIndex withObject:obj];
            weakSelf->_selectedCell.statusObj = obj;
        };
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
    self.tableViewDelegate.selectedCellMoreBtnBlock = ^(UITableViewCell *cell)
    {
        [weakSelf hiddenPopView];
        weakSelf->_selectedCell = (BaseCell *)cell;
        [weakSelf showActionSheetViewController];
    };
    
    self.tableViewDelegate.selectedPhotoBlock = ^(UITableViewCell * cell)
    {
        userPhotoTableViewCell * photoCell = (userPhotoTableViewCell *)cell;
       
        photoCell.photoCollectionView.delegate = weakSelf;
        
    };
    self.tableViewDelegate.selectedUserNameBlock = ^(Statuses * statusesObj)
    {
        UserHomeController * VC = [[UserHomeController alloc]init];
        VC.userObj = statusesObj.user;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
    
    self.tableViewDelegate.userObj= self.userObj;
}
-(void)BottomToolViewBlock
{
    __block typeof(self)weakself = self;
    _bottomToolView.followBtnBlock= ^(UIButton * btn)
    {
        weakself.hotPopView.hidden = YES;
        if(weakself.popoverView.hidden == YES)
        {
            [weakself.popoverView showWithView:btn];
        }else
        {
            [weakself.popoverView hiddenWithView:btn];
            //            weakself.popoverView.hidden = YES;
        }
    };
    _bottomToolView.chatBtnBlock = ^()
    {
        
    };
    _bottomToolView.hotBtnBlock = ^(UIButton * btn)
    {
        weakself.popoverView.hidden = YES;
        if(weakself.hotPopView.hidden == YES)
        {
            [weakself.hotPopView showWithView:btn];
        }else
        {
            [weakself.hotPopView hiddenWithView:btn];
            //            weakself.hotPopView.hidden = YES;
        }
    };
}

-(void)conntectNetworkingResult
{
    __block typeof(self)weakself = self;
    [RequsetStatusService shareInstance].successBlock=^(NSData *data , WBHttpRequest *request)
    {
        id dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [weakself->_hud hide:YES];
        
        if([request.tag isEqualToString:KTagGetUserAndFriendWeibo])
        {
            [weakself SuccessGetWeiBoInfo:dic];
        }
        else if([request.tag isEqualToString:KTagGetUserPhotoInfo])
        {
            [weakself ConfigPhotoTable:dic];
        }
    };
    [RequsetStatusService shareInstance].fialedBlock =^(NSError *error)
    {
        weakself->_hud.hidden = YES;
        [[GlobalHelper ShareInstance]ShowHUD:_hud WithMessage:@"啊哦~网络请求出错了~" afterDelay:1.5f inView:weakself.view];
    };
}

-(void)SuccessGetWeiBoInfo:(NSDictionary *)dict
{
    if(dict)
    {
        self.dataSource = [Statuses mj_objectArrayWithKeyValuesArray:dict[Kstatuses]];
    }
    self.tableViewDelegate.dataSource = self.dataSource;
    if(self.dataSource.count > 0)
        [_tableView reloadData];
}
-(void)ScaleHeadViewWithScrollView:(UIView *)view
{
    UITableView * tableview = (UITableView * )view;
    CGFloat offsetY = tableview.contentOffset.y;
    CGFloat realY = -offsetY -40;
    //    CGFloat realY = -offsetY;
    if(realY > headImageheight)
    {
        CGRect rect = _headView.frame;
        rect.size.height = fabs(offsetY) ;
        rect.origin.y = offsetY;
        [_headView setFrame:rect];
    }
    [_tableHeaderView setFrame:CGRectMake(0,realY, _tableHeaderView.width, _tableHeaderView.height)];
    CGFloat alpha = self.customNav.bottom/realY;
    if(_tableHeaderView.top <= self.customNav.bottom)
    {
        [_tableHeaderView setFrame:CGRectMake(0, self.customNav.bottom,  _tableHeaderView.width, _tableHeaderView.height)];
        [self.customNav setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
        self.customNav.leftBtn.titleLabel.textColor = [UIColor blackColor];
        self.customNav.rightBtn.titleLabel.textColor = [UIColor blackColor];
        self.customNav.titleLabel.textColor =[UIColor blackColor];
        [self.customNav setNavTitle:self.userObj.name];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }else
    {
        alpha = alpha< 0.4?0:alpha;
        [self.customNav setBackgroundColor:[UIColor colorWithWhite:1 alpha:alpha]];
        [self.customNav.titleLabel setTextColor:[UIColor colorWithWhite:1 alpha:alpha]];
        if(alpha == 0)
        {
            [self.customNav setNavTitle:@""];
            self.customNav.leftBtn.titleLabel.textColor = [UIColor whiteColor];
            self.customNav.rightBtn.titleLabel.textColor = [UIColor whiteColor];
            self.customNav.titleLabel.textColor = [UIColor whiteColor];
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        }
    }
    _statusBarsStyle =[UIApplication sharedApplication].statusBarStyle;
}
-(void)handleSearchBtn
{
    _searchView.hidden = NO;
    _statusBarsStyle = [UIApplication sharedApplication].statusBarStyle;
    [_searchView SearchBarBecomeFirstResponder];
    [_searchView.searchBar.delegate TextFiledBegingEdite];
}
-(void)selectedCancelBtn:(UIButton *)sendder
{
    self.tabBarController.tabBar.hidden = NO;
    _searchView.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle =_statusBarsStyle;
}
-(void)TextFiledBegingEdite
{
    _searchView.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [_searchView SearchBarBecomeFirstResponder];
    [_searchView.searchBar setTextFieldPlacehoder:@"搜他的微博"];
}

-(void)ClickRightNavBtn:(UIButton *)btn
{
    
    [self showShareActionSheet:self.view];
}

- (void)showShareActionSheet:(UIView *)view
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    __weak UserHomeController *theController = self;
    
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    NSString * shareText = @"说说分享心得...";
    NSArray  *imageURl =@[self.userObj.profile_image_url];
    
    NSArray* imageArray = @[[UIImage imageNamed:@"scrollImage3"]];
    
    //设置新浪微博分享内容
    [shareParams SSDKSetupSinaWeiboShareParamsByText:shareText title:Nil image:imageURl url:[NSURL URLWithString:@"http://www.baidu.com"] latitude:0 longitude:0 objectID:Nil type:SSDKContentTypeAuto];
    
    //跳转到 客户端进行分享
    [shareParams SSDKEnableUseClientShare];
    
    //设置跳过分享编辑页面 显示分享菜单
    SSUIShareActionSheetController *sheet = [ShareSDK showShareActionSheet:view
                                                                     items:nil
                                                               shareParams:shareParams
                                                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                                           
                                                           switch (state) {
                                                               case SSDKResponseStateSuccess:
                                                               {
                                                                   NSLog(@"分享成功");
                                                                   dispatch_async(dispatch_get_main_queue(), ^{
                                                                       MBProgressHUD * hud = [[MBProgressHUD alloc]init];
                                                                       [hud setLabelText:@"分享成功"];
                                                                       hud.mode = MBProgressHUDModeCustomView;
                                                                       hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"card_icon_addtogroup_confirm"]];
                                                                       [self.view addSubview:hud];
                                                                       [hud show:YES];
                                                                       [hud hide:YES afterDelay:1.0f];
                                                                   });
                                                               }
                                                                   break;
                                                               case SSDKResponseStateFail:
                                                               {
                                                                   
                                                               }
                                                                   break;
                                                               default:
                                                                   break;
                                                           }
                                                       }];
    
    
    [shareParams SSDKEnableUseClientShare];
    //添加分享平台 及跳转到对应平台的分享页面
    [sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
}


-(void)showActionSheetViewController
{
    [self hiddenPopView];
    _selectedIndex =  [self.tableViewDelegate.dataSource indexOfObject:_selectedCell.statusObj];
    __block typeof(self) weakself = self;
    __weak  NSString *favorites = _selectedCell.statusObj.favorited == NO ?@"收藏":@"取消收藏";
    
    PQActionSheet *actionSheet = [[PQActionSheet alloc]initWithTitle:nil clickedAtIndex:^(NSInteger index) {
        if(index == 0)
        {
            if([favorites isEqual:@"收藏"])
            {
                [[RequsetStatusService shareInstance]CreatFavoriterOfStauts:weakself->_selectedCell.statusObj];
            }else
            {
                [[RequsetStatusService shareInstance]RemoveFavoritesOfStauts:weakself->_selectedCell.statusObj];
            }
        }
    } cancelButtonTitle:@"取消" otherButtonTitles:favorites,@"帮上头条",@"取消关注",@"屏蔽",@"举报",nil];
    [actionSheet show];
}

-(void)hiddenPopView
{
    _hotPopView.hidden = YES;
    _popoverView.hidden = YES;
}

#pragma mark -查看大图
-(void)ShowBigViewDismiss:(UIView *)bigView selectedView:(UIView *)view CurrentIndex:(NSInteger)currentIndex images:(NSArray *)images
{
    self.tabBarController.tabBar.hidden = NO;
    NSIndexPath * indexpath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
    NSLog(@" %@",_imageContentView.subviews);
    UICollectionViewCell *currentView = [_imageContentView collectionView:_imageContentView.myCollectionView cellForItemAtIndexPath:indexpath];
    currentView.hidden = YES;
    __block CGRect toViewframe =[_imageContentView convertRect:currentView.frame toView:self.view];
    __block UIView *tempView = view;
    __block typeof(bigView) weakBigView = bigView;
    [self.view addSubview:tempView];
    [UIView animateWithDuration:0.3 animations:^{
        [weakBigView removeFromSuperview];
        [tempView setFrame:toViewframe];
    } completion:^(BOOL finished) {
        [tempView removeFromSuperview];
        currentView.hidden = NO;
    } ];
}
#pragma mark - 点击被转发的微博
-(void)HandleTapGestureForRetweetedStatusView:(RetweetedStatusView *)retweetedStatusView
{
    WBDetailsController *VC = [[WBDetailsController alloc]init];
    VC.obj = retweetedStatusView.obj;
    VC.type = COMMENTDETAILSTYPE;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hiddenPopView];
}


#pragma mark ---- UserInfoTableHeaderViewDelegate ---
#pragma mark - userPhotoTableViewCellDelegate
-(void)selectedImageView:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexpath currentImage:(UIImage *)image images:(NSArray *)array inView:(UIView *)view
{
    self.tabBarController.tabBar.hidden = YES;
    _imageContentView =(UserPhotoCollectionView *)view;
    UIImageView * imageView = cell.contentView.subviews.lastObject;
    UIImageView * tempView = [[UIImageView alloc]initWithImage:imageView.image];
    CGRect toViewframe =[view convertRect:cell.frame toView:self.view];
    [tempView setFrame:toViewframe];
    ShowBigView *big = [[ShowBigView alloc]initWithFrame:self.view.bounds];
    big.delegate = self;
    [self.view addSubview:big];
    [big ConfigData:array ImageView:imageView atIndex:indexpath.row];
    [big CreatSelectedView:tempView AndFrame:toViewframe currentIamge:image];
}
//-(void)selectedImageView:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexpath images:(NSArray *)array inView:(UIView *)view
//{

//    self.tabBarController.tabBar.hidden = YES;
//    _imageContentView =(UserPhotoCollectionView *)view;
//    UIImageView * imageView = cell.contentView.subviews.lastObject;
//    UIImageView * tempView = [[UIImageView alloc]initWithImage:imageView.image];
//    CGRect toViewframe =[view convertRect:cell.frame toView:self.view];
//    [tempView setFrame:toViewframe];
//    ShowBigView *big = [[ShowBigView alloc]initWithFrame:self.view.bounds];
//    big.delegate = self;
//    [self.view addSubview:big];
//    [big ConfigData:array ImageView:imageView atIndex:indexpath.row];
//    [big CreatSelectedView:tempView AndFrame:toViewframe];
//}

-(void)selectedUserInfoTableHeaderViewHomeBtn
{
    self.tableViewDelegate.dataSource = self.dataSource;
    self.tableViewDelegate.type = TypeOfUserHomeTableView;
    if(self.dataSource.count > 0)
        [_tableView reloadData];
    
}

-(void)selectedUserInfoTableHeaderViewPhotoBtn
{
    //    [[RequsetStatusService shareInstance] GetUserPhotoInfo:self.userObj];
    [[RequsetStatusService shareInstance] GetUserPhotoInfo:self.userObj page:_photoPage];
    
}
-(void)selectedUserInfoTableHeaderViewWeiBoBtn
{
    self.tableViewDelegate.dataSource = self.dataSource;
    self.tableViewDelegate.type = TypeOfUserStatusTableView;
    if(self.dataSource.count > 0)
        [_tableView reloadData];
}

-(void)ConfigPhotoTable:(NSDictionary *)dic
{
    self.tableViewDelegate.type = TypeOfUserAlssetsTableView;
    _tableView.contentInset = UIEdgeInsetsMake(-_tableView.contentOffset.y-1, 0, 0, 0);
    [_tableView reloadData];
}



@end
