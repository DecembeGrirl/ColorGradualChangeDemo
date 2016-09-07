//
//  AppDelegate.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
static NSString *appKey = @"cab189499305648c398e8e9d";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;


@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

