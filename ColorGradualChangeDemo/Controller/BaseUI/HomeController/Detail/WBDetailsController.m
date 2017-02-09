//
//  WBDetailsController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/8.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "WBDetailsController.h"
#import "UIView+Frame.h"
#import "RetweetedStatusViewCell.h"
#import "StatusViewForImageCell.h"
#import "WBHttpRequest.h"
#import "ShowBigView.h"
#import "TransmitViewController.h"
#import "CommentsObj.h"
#import "UserHomeController.h"
#import "RequsetStatusService.h"
#import "MJExtension.h"
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import "WebViewController.h"

@interface WBDetailsController ()<WBHttpRequestDelegate,RetweetedStatusViewDelegate,BottomToolViewBtnDelegate,userPhotoCollectionViewDelegate,ShowBigViewDelegate>

@end

@implementation WBDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CreatUI];
    [self ConfigTable];
    [self conntectNetworkingResult];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_dataArray addObject:self.obj];
    [[RequsetStatusService shareInstance]FetchComments:self.obj.ID];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    self.backBlock(self.obj);
}


-(void)CreatUI
{
    [self.customNav setNavTitle:@"微博正文"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.customNav.leftBtn.hidden = NO;
    UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rigthBtn setTitle:@"..." forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.customNav setRightNavButton:rigthBtn];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.customNav.bottom, self.view.width, self.view.height - self.customNav.bottom - BottomToolViewHeight)];
    [self.view addSubview:_tableView];
    _bottomToolView = [[BottomToolView alloc]initWithFrame:CGRectMake(0, self.view.height - BottomToolViewHeight, self.view.width, BottomToolViewHeight)];
    _bottomToolView.delegate = self;
    [self.view addSubview:_bottomToolView];
    
    self.myTableViewDelegate = [[DetailsTableViewDelegate alloc]init];
    self.myTableViewDelegate.type= self.type;
    _dataArray = [NSMutableArray arrayWithCapacity:5];
    _dataDic = [NSMutableDictionary dictionaryWithCapacity:3];
}

-(void)ConfigTable
{
    __weak typeof(self) weakSelf = self;
    __weak typeof(self.navigationController) weakselfNavigationController = self.navigationController;
    [self.myTableViewDelegate RegistTableView:_tableView];
    self.myTableViewDelegate.configCellBlock=^(NSIndexPath * indexPath,id item,UITableViewCell * cell)
    {
        if([cell isKindOfClass:[RetweetedStatusViewCell class]])
        {
            RetweetedStatusViewCell *tempcell = (RetweetedStatusViewCell*)cell;
            tempcell.retweetedStatusView.delegate = weakSelf;
            tempcell.retweetedStatusView.imageContentView.delegate = weakSelf;
        }
        else if ([cell isKindOfClass:[StatusViewForImageCell class]])
        {
            StatusViewForImageCell *tempcell = (StatusViewForImageCell*)cell;
            tempcell.imageContentView.delegate = weakSelf;
        }
    };
    self.myTableViewDelegate.selectedNameOrHeaderBlock= ^(Statuses *statusObj){
        UserHomeController * VC = [[UserHomeController alloc]init];
        VC.userObj = statusObj.user;
        [weakselfNavigationController pushViewController:VC animated:YES];
    };
    self.myTableViewDelegate.selectedCellMoreBtnBlock =^(UITableViewCell * cell)
    {
        if([cell isKindOfClass:[BaseCell class]])
        {
            BaseCell * tempcCell = (BaseCell *)cell;
            weakSelf.baseCell = tempcCell;
            if(tempcCell.statusObj.favorited )
                [[RequsetStatusService shareInstance] CreatFavoriterOfStauts:tempcCell.statusObj];
            else
                [[RequsetStatusService shareInstance] RemoveFavoritesOfStauts:tempcCell.statusObj];
            
        }
    };
    self.myTableViewDelegate.selectedUserNameBlock = ^(Statuses * statusesObj)
    {
        UserHomeController * VC = [[UserHomeController alloc]init];
        VC.userObj = statusesObj.user;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
    
    self.myTableViewDelegate.selectedCellBtnBolck = ^(BaseCell *cell,CommentType type)
    {
        TransmitViewController * VC= [[TransmitViewController alloc]init];
        [weakSelf  presentViewController:VC animated:YES completion:nil];
    };
   
    self.myTableViewDelegate.selectedURLBlock = ^(NSString * URLStr)
    {
        WebViewController * VC = [[WebViewController alloc]init];
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
//    self.myTableViewDelegate.selectedURL= ^(NSString * URLStr)
//    {
//        WebViewController * VC = [[WebViewController alloc]init];
//        [weakSelf.navigationController pushViewController:VC animated:YES];
//    };
        self.myTableViewDelegate.selectedPhotoBlock = ^(UITableViewCell * cell)
        {
            StatusViewForImageCell * photoCell = (StatusViewForImageCell *)cell;
            photoCell.imageContentView.delegate = weakSelf;
    
        };
    
    self.myTableViewDelegate.dataSource = _dataArray;
}

-(void)conntectNetworkingResult
{
    __block typeof(self)weakself = self;
    [RequsetStatusService shareInstance].successBlock=^(NSData *data , WBHttpRequest *request)
    {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //        [weakself->_hud hide:YES];
        if(!dic[@"error"])
        {
            if([request.tag  isEqual: KTagGetComments])
                [weakself SuccessGetComments:dic];
            else if ([request.tag isEqual:KTagCreatFavorites])
                [weakself SuccessCreatFavorites:dic];
            else if ([request.tag isEqualToString:KtagRemoveFavorites])
                [weakself SuccessRemoveFavorites:dic];
        }
        //        [weakself.table.mj_header endRefreshing];
        //        [weakself.table.mj_footer endRefreshing];
    };
    [RequsetStatusService shareInstance].fialedBlock =^(NSError *error)
    {
        NSLog(@"详情页 出错喽");
        //        weakself->_hud.hidden = YES;
        //        [[GlobalHelper ShareInstance]ShowHUD:_hud WithMessage:@"啊哦~网络请求出错了~" afterDelay:1.5f inView:weakself.view];
        //        [weakself.table.mj_header endRefreshing];
        //        [weakself.table.mj_footer endRefreshing];
    };
}

-(void)SuccessGetComments:(NSDictionary *)dic
{
    NSMutableArray * commentsObjArray = [NSMutableArray arrayWithCapacity:3];
    commentsObjArray = [CommentsObj mj_objectArrayWithKeyValuesArray:dic[@"comments"]];
    
    [_dataArray addObject:commentsObjArray];
    [_tableView reloadData];
}

-(void)SuccessCreatFavorites:(NSDictionary *)dic
{
    self.obj.favorited =dic[Kstatus][Kfavorited];
    [self.baseCell setMoreBtnImageWithImage];
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
    self.obj.favorited =dic[Kstatus][Kfavorited];
    [self.baseCell setMoreBtnImageWithImage];
    MBProgressHUD * hud = [[MBProgressHUD alloc]init];
    [hud setLabelText:@"取消收藏"];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"card_icon_addtogroup_confirm"]];
    [self.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:0.5];
    //    [hud removeFromSuperview];
}
-(void)HandleTapGestureForRetweetedStatusView:(RetweetedStatusView *)retweetedStatusView
{
    WBDetailsController *VC = [[WBDetailsController alloc]init];
    VC.obj = retweetedStatusView.obj;
    VC.type = COMMENTDETAILSTYPE;
    [self.navigationController pushViewController:VC animated:YES];
}

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

-(void)ShowBigViewDismiss:(UIView *)bigView selectedView:(UIView *)view CurrentIndex:(NSInteger)currentIndex images:(NSArray *)images
{
    self.tabBarController.tabBar.hidden = NO;
    NSIndexPath * indexpath = [NSIndexPath indexPathForItem:currentIndex inSection:0];
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
#pragma mark - BottomToolViewDelegate
-(void)SelectedBottomViewBtn:(UIButton *)btn btnType:(CommentType)type
{
    TransmitViewController *VC = [[TransmitViewController alloc]init];
    VC.obj = self.obj;
    VC.type = type;
    [self presentViewController:VC animated:YES completion:nil];
}
#pragma mark --------- 点击了rightNavBtn
-(void)rightBtnClick
{
    [self showShareActionSheet:self.view];
}
- (void)showShareActionSheet:(UIView *)view
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    __weak WBDetailsController *theController = self;
    //1、创建分享参数（必要）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSString * shareText = self.obj.retweeted_status?[NSString stringWithFormat:@"//%@:%@",self.obj.user.name,self.obj.text]:@"说说分享心得...";
    NSArray  *imageURl = self.obj.retweeted_status?self.obj.retweeted_status.pic_urls:self.obj.pic_urls;
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
//    [shareParams SSDKEnableUseClientShare];
    //添加分享平台 及跳转到对应平台的分享页面
    [sheet.directSharePlatforms removeObject:@(SSDKPlatformTypeWechat)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
}
@end
