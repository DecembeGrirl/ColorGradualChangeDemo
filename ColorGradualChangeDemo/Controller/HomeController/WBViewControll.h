//
//  ViewController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewDelegate.h"
#import "StatusViewForImageCell.h"
#import "HeadView.h"
#import "WeiboSDK.h"
#import "Config.h"
#import "GlobalHelper.h"
#import "StatusObj.h"
@interface WBViewControll : UIViewController<WBHttpRequestDelegate>
{
    NSMutableArray * _statusArr;
}
@property (nonatomic, strong) UIView *navBar;
@property (nonatomic, strong) UITableView * table;
@property (nonatomic, strong)TableViewDelegate * tableViewDelegate;
@property (nonatomic, strong) HeadView * headView;
-(void)ScaleHeadViewWithScrollView:(UIView *)scrollView;
@end

