//
//  ViewController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import "WBViewControll.h"
#import "Config.h"
#import "MJRefresh.h"
#import "SDImageCache.h"
#import "ShowBigView.h"
#import "MBProgressHUD.h"
#import "TransmitViewController.h"
#import "WBDetailsController.h"
#import "UserHomeController.h"
#import "RequsetStatusService.h"
#import "MJExtension.h"
#import "Statuses.h"
#import "WebViewController.h"
#import "PQActionSheet.h"
#import "MJExtension.h"
#import "FrinedFollowingController.h"
//#define headImageheight  200
@interface WBViewControll ()<UIGestureRecognizerDelegate,WBHttpRequestDelegate,RetweetedStatusViewDelegate,ShowBigViewDelegate,SearchBarDelegate,userPhotoCollectionViewDelegate,StatusViewForImageCellDelegate>
@end

@implementation WBViewControll

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initViews];
    [self ConfigTableView];
    [self conntectNetworkingResult];
    _hud = [[GlobalHelper ShareInstance]ShowHUD:_hud WithMessage:@"玩命加载中..." afterDelay:0 inView:self.view];
    if(![GlobalHelper ShareInstance].user)
    {
        [[RequsetStatusService shareInstance] FetchUserInfo];
    }
    [self ConfigNavBar];
    [[RequsetStatusService shareInstance] FetchWeiBo:_page];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
-(void)initViews
{
    [self.customNav setBackgroundColor:[UIColor whiteColor]];
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, self.customNav.bottom -38, KScreenWidth, KScreenHeight-38) style:UITableViewStylePlain];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.table setBackgroundColor:[UIColor clearColor]];
    [self.view insertSubview:self.table belowSubview:self.customNav];
    self.table.contentInset = UIEdgeInsetsMake(20 , 0, 0, 0);
    
    __block typeof(self) weakSelf = self;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf->_page= 1;
        [[RequsetStatusService shareInstance] FetchWeiBo:_page];
    }];
    self.table.mj_footer = [MJRefreshBackNormalFooter
                            footerWithRefreshingBlock:^{
                                weakSelf->_page ++;
                                [[RequsetStatusService shareInstance] FetchWeiBo:_page];
                            }];
    _searchBar = [[SearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 35)];
    _searchBar.type = CanNotEditType;
    _searchBar.delegate= self;
    self.table.tableHeaderView =_searchBar;
    
    self.tableViewDelegate =[[WeiboTableViewDelegate alloc]init];
    _statusArr = [NSMutableArray arrayWithCapacity:5];
    _page = 1;
}
-(void)ConfigNavBar
{
    NSString * name = [GlobalHelper ShareInstance].user.name;
    [self.customNav setNavTitle:name];
    
    [self.customNav setLeftNavButton:[[self.customNav class]createNavButtonByImageNormal:@"navigationbar_friendattention" imageSelected:@"navigationbar_friendattention_highlighted" target:self action:@selector(HandleLeftNavBtn:)]];
    
    [self.customNav setRightNavButton:[[self.customNav class]createNavButtonByImageNormal:@"navigationbar_icon_radar" imageSelected:@"navigationbar_icon_radar_highlighted" target:self action:@selector(HandleRightNavBtn:)]];
}

-(void)ShowHUDWithMessage:(NSString *)message afterDelay:(CGFloat)delay
{
    if(!_hud)
    {
        _hud = [[MBProgressHUD alloc]init];
        [self.view addSubview:_hud];
    }
    _hud.labelText = message;
    [_hud show:YES];
    if(delay > 0)
        [_hud hide:YES afterDelay:delay];
}
-(void)ConfigTableView
{
    __block typeof(self) weakSelf = self;
    __block typeof(self.navigationController) weakselfNavigationController = self.navigationController;
    [self.tableViewDelegate RegistTableView:self.table];
    
    self.tableViewDelegate.configCellBlock = ^(NSIndexPath * indexPath,id item,BaseCell * cell){
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
//            tempCell.delegate = weakSelf;
            tempCell.myDelegate = weakSelf;
            tempCell.imageContentView.delegate = weakSelf;
        }
    };
    self.tableViewDelegate.selectedCellBtnBolck = ^(BaseCell * cell, CommentType type)
    {
        if(type == COMMENTDETAILSTYPE)
        {
            WBDetailsController *VC = [[WBDetailsController alloc]init];
            VC.obj = cell.statusObj;
            VC.type = type;
            [weakselfNavigationController pushViewController:VC animated:YES];
        }
        else
        {
            TransmitViewController * VC = [[TransmitViewController alloc]init];
            VC.obj= cell.statusObj;
            VC.type = type;
            [weakSelf presentViewController:VC animated:YES completion:nil];
        }
    };
    
    self.tableViewDelegate.selectedCellBlock = ^(UITableViewCell * cell)
    {
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
            [weakSelf->_statusArr replaceObjectAtIndex:weakSelf->_selectedIndex withObject:obj];
            weakSelf->_selectedCell.statusObj = obj;
        };
        [weakselfNavigationController pushViewController:VC animated:YES];
    };
    self.tableViewDelegate.selectedNameOrHeaderBlock= ^(BaseCell *cell){
        UserHomeController * VC = [[UserHomeController alloc
                                    ]init];
        VC.userObj = cell.statusObj.user;
        [weakselfNavigationController pushViewController:VC animated:YES];
    };
    //    self.tableViewDelegate.downLoadWeibo = ^()
    //    {
    //        weakSelf->_page++;
    //        [weakSelf FetchWeiBo];
    //    };
    self.tableViewDelegate.selectedCellMoreBtnBlock = ^(UITableViewCell * cell)
    {
        weakSelf->_selectedCell = (BaseCell *)cell;
        
        [weakSelf showActionSheetViewController];
    };
    self.tableViewDelegate.selectedURL= ^(NSString * URLStr)
    {
        WebViewController * VC = [[WebViewController alloc]init];
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
    //    self.tableViewDelegate.selectedPhotoBlock = ^(UITableViewCell * cell)
    //    {
    //        userPhotoTableViewCell * photoCell = (userPhotoTableViewCell *)cell;
    //        photoCell.photoCollectionView.delegate = weakSelf;
    //
    //    };
}

-(void)conntectNetworkingResult
{
    __block typeof(self)weakself = self;
    [RequsetStatusService shareInstance].successBlock=^(NSData *data , WBHttpRequest *request)
    {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [weakself->_hud hide:YES];
        
        if([request.tag isEqualToString:KTagGetUserAndFriendWeibo])
            [weakself SuccessGetWeiBoInfo:dic];
        else if ([request.tag isEqualToString:KTagGetUserInfo])
            [weakself SuccessGetUserInfo:dic];
        else if ([request.tag isEqual:KTagCreatFavorites])
            [weakself SuccessCreatFavorites:dic];
        else if ([request.tag isEqualToString:KtagRemoveFavorites])
            [weakself SuccessRemoveFavorites:dic];
        //        else if ([request.tag isEqual:KTagGetSingleWeiboInfoWithID])
        //            [weakself SuccessGetSingleWeiboInfo:dic];
        
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
    };
    [RequsetStatusService shareInstance].fialedBlock =^(NSError *error)
    {
        weakself->_hud.hidden = YES;
        [[GlobalHelper ShareInstance]ShowHUD:_hud WithMessage:@"啊哦~网络请求出错了~" afterDelay:1.5f inView:weakself.view];
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
    };
}


//获取微博成功
-(void)SuccessGetWeiBoInfo:(NSDictionary *)dict
{
    if(_page==1)
        [_statusArr removeAllObjects];
    if(dict)
    {
        NSArray * statusesArr = dict[Kstatuses];
        for (int i = 0; i < statusesArr.count; i ++) {
            Statuses * statues = [Statuses mj_objectWithKeyValues:statusesArr[i]];
            [_statusArr addObject:statues];
        }
    }
    self.tableViewDelegate.dataSource = _statusArr;
    if(_statusArr.count> 0)
        [self.table reloadData];
}

-(void)SuccessGetUserInfo:(NSDictionary *)dic
{
    User * user = [User mj_objectWithKeyValues:dic];
    [GlobalHelper ShareInstance].user =user;
    [self ConfigNavBar];
}


-(void)SuccessCreatFavorites:(NSDictionary *)dic
{
    Statuses * obj = [Statuses mj_objectWithKeyValues:dic[Kstatus]];
    _selectedCell.statusObj = obj;
    [_statusArr replaceObjectAtIndex:_selectedIndex withObject:obj];
    
    MBProgressHUD * hud = [[MBProgressHUD alloc]init];
    [hud setLabelText:@"收藏成功"];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"card_icon_addtogroup_confirm"]];
    [self.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:0.5];
}
-(void)SuccessRemoveFavorites:(NSDictionary *)dic
{
    Statuses * obj = [Statuses mj_objectWithKeyValues:dic[Kstatus]];
    _selectedCell.statusObj = obj;
    [_statusArr replaceObjectAtIndex:_selectedIndex withObject:obj];
    MBProgressHUD * hud = [[MBProgressHUD alloc]init];
    [hud setLabelText:@"取消收藏"];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"card_icon_addtogroup_confirm"]];
    [self.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:0.5];
}
-(void)ReloadData
{
    [self.table reloadData];
}
//点击leftNavBtn
-(void)HandleLeftNavBtn:(UIButton *)btn
{
    NSLog(@"点击了leftNavBar");
    FrinedFollowingController *VC = [[FrinedFollowingController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

-(void)HandleRightNavBtn:(UIButton *)btn
{
    NSLog(@"点击了rightNavBar");
}

-(void)HandleTapGestureForRetweetedStatusView:(RetweetedStatusView *)retweetedStatusView
{
    WBDetailsController *VC = [[WBDetailsController alloc]init];
    VC.obj = retweetedStatusView.obj;
    VC.type = COMMENTDETAILSTYPE;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)HandleTapGestureForStatusViewForImageCell:(StatusViewForImageCell *)statusViewForImageCell
{
    WBDetailsController *VC = [[WBDetailsController alloc]init];
    VC.obj = statusViewForImageCell.obj;
    VC.type = COMMENTDETAILSTYPE;
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark -查看大图
#pragma mark - userPhotoTableViewCellDelegate
-(void)selectedImageView:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexpath images:(NSArray *)array inView:(UIView *)view
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
    [big CreatSelectedView:tempView AndFrame:toViewframe];
}


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

-(void)showActionSheetViewController
{
    _selectedIndex =  [_statusArr indexOfObject:_selectedCell.statusObj];
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
-(void)refreshData
{
    [self.table.mj_header beginRefreshing];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDImageCache sharedImageCache]clearDisk];
}

@end
