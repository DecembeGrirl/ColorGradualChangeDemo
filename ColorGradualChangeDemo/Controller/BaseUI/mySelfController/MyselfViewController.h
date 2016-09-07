//
//  MyselfViewController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/18.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "BaseController.h"
#import "MyselfTableViewDelegate.h"
@interface MyselfViewController : BaseController
{
    UITableView * _tableView;
}
@property (nonatomic, strong)MyselfTableViewDelegate * delegate;
@property (nonatomic, strong)NSMutableArray * arrayData;
@end
