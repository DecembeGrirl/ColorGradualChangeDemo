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

@end

@implementation MainTabBarController
-(void)viewDidLoad
{
    [super viewDidLoad];
    ;
    [self ConfigUI];
    self.delegate = self;
}
-(void)ConfigUI
{
    WBViewControll *homeVC = [[WBViewControll alloc]init];
    BaseNavController *homeNav = [[BaseNavController alloc]initWithRootViewController:homeVC];
    //    homeNav.tabBarItem = [UITabBarItem alloc]
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"tabbar_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    FindViewController *findVC = [[FindViewController alloc]init];
    BaseNavController *findNav = [[BaseNavController alloc]initWithRootViewController:findVC];
    findNav.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"发现" image:[[UIImage imageNamed:@"tabbar_discover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    addNewStatuesViewController *addNewStatusVC = [[addNewStatuesViewController alloc]init];
    BaseNavController *addNewStatusVCNav = [[BaseNavController alloc]initWithRootViewController:addNewStatusVC];
    addNewStatusVCNav.tabBarItem =[[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"timeline_relationship_icon_addattention"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"timeline_relationship_icon_addattention"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    MessageViewController *messageVC = [[MessageViewController alloc]init];
    BaseNavController *messageNav = [[BaseNavController alloc]initWithRootViewController:messageVC];
    messageNav.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"消息" image:[[UIImage imageNamed:@"tabbar_message_center"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_message_center_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    MyselfViewController *myselfVC  = [[MyselfViewController alloc]init];
    BaseNavController *myselfNav = [[BaseNavController alloc]initWithRootViewController:myselfVC];
    myselfNav.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"我" image:[[UIImage imageNamed:@"tabbar_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.viewControllers = @[homeNav,findNav,addNewStatusVCNav,messageNav,myselfNav];
    self.selectedViewController =self.viewControllers[0];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_COLOR(@"#5f656c")} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_COLOR(@"#e73f5f")} forState:UIControlStateSelected];
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    BaseNavController * VC = tabBarController.selectedViewController;
    UIViewController * visibleVC = VC.visibleViewController;
    BaseNavController * showSelectedVC  = (BaseNavController *)viewController;
    if([VC isEqual:viewController] &&([VC.visibleViewController isKindOfClass:[WBViewControll class]]||[VC.visibleViewController isKindOfClass:[MessageViewController class]]))
    {
        if([visibleVC canPerformAction:@selector(refreshData) withSender:nil])
            [visibleVC performSelector:@selector(refreshData)];
        return NO;
    }
    else if([showSelectedVC.visibleViewController isKindOfClass:[addNewStatuesViewController class]])
    {
        UIImage * image = [self captureScreen];
        addNewStatuesViewController * VC = (addNewStatuesViewController*)showSelectedVC.visibleViewController;
        VC.backGroundImage = image;
        VC.index =tabBarController.selectedIndex;
        return YES;
    }
    return YES;
}
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
@end
