//
//  BaseNavController.m
//  WumartLehui
//
//  Created by 杨淑园 on 15/8/10.
//  Copyright (c) 2015年 yangshuyuan. All rights reserved.
//

#import "BaseNavController.h"
#import "MainTabBarController.h"

@interface BaseNavController ()

@end

@implementation BaseNavController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //隐藏状态栏
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    [self.navigationBar setHidden:YES];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end
