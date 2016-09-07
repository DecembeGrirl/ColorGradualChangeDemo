//
//  addNewStatuesViewController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/9/5.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "addNewStatuesViewController.h"
#import "MainTabBarController.h"
#import "TransmitViewController.h"
@implementation addNewStatuesViewController
{
    UIImageView * backView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    backView = [[UIImageView alloc]initWithImage:self.backGroundImage];
    [backView setFrame:self.view.bounds];
    [self.view addSubview:backView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [backView setImage:self.backGroundImage];
    [self CreatUI];
}

-(void)CreatUI
{
    BlurEffectMenuItem *statusItem=[[BlurEffectMenuItem alloc]init];
    [statusItem setTitle:@"文字"];
    [statusItem setIcon:[UIImage imageNamed:@"tabbar_compose_idea"]];
    
    BlurEffectMenuItem *pictureItem=[[BlurEffectMenuItem alloc]init];
    [pictureItem setTitle:@"照片/视频"];
    [pictureItem setIcon:[UIImage imageNamed:@"tabbar_compose_photo"]];
    
    BlurEffectMenuItem *topArticleItem=[[BlurEffectMenuItem alloc]init];
    [topArticleItem setTitle:@"头条文章"];
    [topArticleItem setIcon:[UIImage imageNamed:@"tabbar_compose_headlines"]];
    
    BlurEffectMenuItem *signItem=[[BlurEffectMenuItem alloc]init];
    [signItem setTitle:@"签到"];
    [signItem setIcon:[UIImage imageNamed:@"tabbar_compose_lbs"]];
    
    BlurEffectMenuItem *liveItem=[[BlurEffectMenuItem alloc]init];
    [liveItem setTitle:@"直播"];
    [liveItem setIcon:[UIImage imageNamed:@"tabbar_compose_shooting"]];

    BlurEffectMenuItem *moreItem=[[BlurEffectMenuItem alloc]init];
    [moreItem setTitle:@"更多"];
    [moreItem setIcon:[UIImage imageNamed:@"tabbar_compose_more"]];

    
    BlurEffectMenu *menu=[[BlurEffectMenu alloc]initWithMenus:@[statusItem,pictureItem,topArticleItem,signItem,liveItem,moreItem]];
    menu.delegate = self;
    menu.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [menu setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:menu animated:YES completion:nil];

}

#pragma mark - BlurEffectMenu Delegate
- (void)blurEffectMenuDidTapOnBackground:(BlurEffectMenu *)menu{
    
    MainTabBarController *maintabBarVC =(MainTabBarController*) self.tabBarController;
    maintabBarVC.selectedViewController =maintabBarVC.childViewControllers[self.index];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)blurEffectMenu:(BlurEffectMenu *)menu didTapOnItem:(BlurEffectMenuItem *)item{
    MainTabBarController *maintabBarVC =(MainTabBarController*) self.tabBarController;
    maintabBarVC.selectedViewController =maintabBarVC.childViewControllers[self.index];
    [self dismissViewControllerAnimated:NO completion:^{
        [self goToNextController:item];
    }];
}

-(void)goToNextController:(BlurEffectMenuItem *)item
{
    switch (item.index) {
        case 0:
            [self presentViewController:[[TransmitViewController alloc]init] animated:YES completion:nil];
            break;
        case 1:
            [self presentViewController:[[TransmitViewController alloc]init] animated:YES completion:nil];
            break;
        case 2:
            [self presentViewController:[[TransmitViewController alloc]init] animated:YES completion:nil];
            break;
        case 3:
            [self presentViewController:[[TransmitViewController alloc]init] animated:YES completion:nil];
            break;
        case 4:
            [self presentViewController:[[TransmitViewController alloc]init] animated:YES completion:nil];
            break;
        case 5:
            [self presentViewController:[[TransmitViewController alloc]init] animated:YES completion:nil];
            break;
        case 6:
            [self presentViewController:[[TransmitViewController alloc]init] animated:YES completion:nil];
            break;
        default:
            break;
    }
}





@end