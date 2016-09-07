//
//  MyselfTableViewDelegate.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/4/5.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MyselfTableViewDelegate : NSObject<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSArray * dataSource;
-(void)RegistTableView:(UITableView *)tableView;
@end
