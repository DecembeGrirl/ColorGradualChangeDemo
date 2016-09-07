//
//  LoginViewController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/6.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "AFNetworking.h"
#import "WeiboSDK.h"
#import "GlobalHelper.h"

@interface LoginViewController : UIViewController
{
    UIButton * _loginBtn;
}
@property (nonatomic,strong)NSMutableData * webData;
@end
