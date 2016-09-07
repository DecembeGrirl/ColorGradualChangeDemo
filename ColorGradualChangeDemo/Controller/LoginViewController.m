//
//  LoginViewController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/6.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "MainTabBarController.h"

@implementation LoginViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginBtn setFrame:CGRectMake(0, 0, 100, 50)];
    [_loginBtn setTitle:@"微博登陆" forState:UIControlStateNormal];
    _loginBtn .center = self.view.center;
    [_loginBtn addTarget:self action:@selector(HandleLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    //    [self fun];
}


-(void)HandleLogin:(id)sender
{
    
    if(![GlobalHelper getValueOfKey:KUid])
    {
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = KRedirectUri;
        request.scope = @"all";
        request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        [WeiboSDK sendRequest:request];
    }else
    {
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [[MainTabBarController alloc]init];
    }
    
    
}

-(void)isLogin
{
    
    
}



@end
