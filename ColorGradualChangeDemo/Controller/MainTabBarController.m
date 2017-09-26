//
//  ViewController.m
//  WumartLehui
//
//  Created by 杨淑园 on 15/8/7.
//  Copyright (c) 2015年 yangshuyuan. All rights reserved.
//

#import "MainTabBarController.h"
#import "Config.h"
#import "BaseNavController.h"
#import "WBViewControll.h"
#import "FindViewController.h"
#import "MessageViewController.h"
#import "MyselfViewController.h"

#import "addNewStatuesViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>
@property(nonatomic, strong)UIButton * centeBtn;
@property(nonatomic, strong)BaseNavController *addNewStatusVCNav;
//@property(nonatomic, strong)UITabBar * myTabBar;
@end

@implementation MainTabBarController
-(void)viewDidLoad
{
    [super viewDidLoad];
    ;
    [self ConfigUI];
    [self addCenterBtnNotification];
    self.delegate = self;
}
-(void)ConfigUI
{
    
//    _myTabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, KScreenHeight - 49, KScreenWidth, 49)];
//    [self.view addSubview:_myTabBar];
    
    WBViewControll *homeVC = [[WBViewControll alloc]init];
    BaseNavController *homeNav = [[BaseNavController alloc]initWithRootViewController:homeVC];
    //    homeNav.tabBarItem = [UITabBarItem alloc]
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    FindViewController *findVC = [[FindViewController alloc]init];
    BaseNavController *findNav = [[BaseNavController alloc]initWithRootViewController:findVC];
    findNav.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"发现" image:[[UIImage imageNamed:@"tabbar_discover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    addNewStatuesViewController *addNewStatusVC = [[addNewStatuesViewController alloc]init];
    _addNewStatusVCNav = [[BaseNavController alloc]initWithRootViewController:addNewStatusVC];
//    addNewStatusVCNav.tabBarItem.title = @"添加";
//    [self addCenterBtnWithImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] selectedImage:[UIImage imageNamed:@"tabbar_compose_icon_add"]];
    _addNewStatusVCNav.tabBarItem =[[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"timeline_relationship_icon_addattention"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"timeline_relationship_icon_addattention"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    MessageViewController *messageVC = [[MessageViewController alloc]init];
    BaseNavController *messageNav = [[BaseNavController alloc]initWithRootViewController:messageVC];
    messageNav.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"消息" image:[[UIImage imageNamed:@"tabbar_message_center"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_message_center_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    MyselfViewController *myselfVC  = [[MyselfViewController alloc]init];
    BaseNavController *myselfNav = [[BaseNavController alloc]initWithRootViewController:myselfVC];
    myselfNav.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"我" image:[[UIImage imageNamed:@"tabbar_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.viewControllers = @[homeNav,findNav,_addNewStatusVCNav,messageNav,myselfNav];
    self.selectedViewController =self.viewControllers[0];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_COLOR(@"#5f656c")} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_COLOR(@"#e73f5f")} forState:UIControlStateSelected];
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    BaseNavController * VC = tabBarController.selectedViewController;
    UIViewController * visibleVC = VC.visibleViewController;
    
    BaseNavController * showSelectedVC  = (BaseNavController *)viewController;
    _centeBtn.selected = NO;
    if([VC isEqual:viewController] &&([VC.visibleViewController isKindOfClass:[WBViewControll class]]||[VC.visibleViewController isKindOfClass:[MessageViewController class]]))
    {
        if([visibleVC canPerformAction:@selector(refreshData) withSender:nil])
            [visibleVC performSelector:@selector(refreshData)];
        return NO;
    }
    else if([showSelectedVC.visibleViewController isKindOfClass:[addNewStatuesViewController class]])
    {
        UIImage * image = [self captureScreen];
        addNewStatuesViewController * VC = (addNewStatuesViewController*)showSelectedVC.viewControllers[0];
        VC.backGroundImage = image;
        VC.index =tabBarController.selectedIndex;
//        _centeBtn.selected = YES;
        return YES;
    }
    return YES;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"5555555");
}


// 截屏
- (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

// 添加中间突出按钮
-(void)addCenterBtnWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    CGFloat width = 40;
    _centeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_centeBtn addTarget:self action:@selector(selectedCenter:) forControlEvents:UIControlEventTouchUpInside];
    // 自动调整 子控件与父控件的位置距离
    _centeBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleBottomMargin;
    [_centeBtn setBackgroundImage:[UIImage imageNamed:@"camera_image_capture_background_highlighted"] forState:UIControlStateNormal];
    [_centeBtn setFrame:CGRectMake(0, 0, width, width )];
    
    [_centeBtn setImage:image forState:UIControlStateNormal];
    [_centeBtn setImage:selectedImage forState:UIControlStateSelected];
    
    //去掉选中Bt时候的阴影
    _centeBtn.adjustsImageWhenHighlighted = NO;
    
    CGPoint point = self.tabBar.center;
//    point.y = point.y - width / 4;
    _centeBtn.center = point;
    _centeBtn.selected = NO;
    [self.view addSubview:_centeBtn];

}
-(void)selectedCenter:(UIButton *)sender
{
    // 1.必须先调用 delegate的 tabBarController:shouldSelectViewController: 方法
    // 3. 设置selectedIndex的值
    [self.delegate tabBarController:self shouldSelectViewController:self.viewControllers[2]];
     self.selectedIndex = 2;
}

-(void)addCenterBtnNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(centerBtnHidden) name:@"centerBtnHidden" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(centerBtnShow) name:@"centerBtnShow" object:nil];
}
-(void)centerBtnHidden
{
    _centeBtn.hidden = YES;
}

-(void)centerBtnShow
{
    _centeBtn.hidden = NO;
    [self.view bringSubviewToFront:_centeBtn];
    [self performSelector:@selector(showCenterbtn) withObject:nil afterDelay:0.545f];
}

-(void)showCenterbtn
{
    [self.view bringSubviewToFront:_centeBtn];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    _centeBtn.hidden = NO;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"centerBtnShow" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"centerBtnHidden" object:nil];
}


@end
