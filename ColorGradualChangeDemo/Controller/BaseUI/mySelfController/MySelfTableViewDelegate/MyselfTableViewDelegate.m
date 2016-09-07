//
//  MyselfTableViewDelegate.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/4/5.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "MyselfTableViewDelegate.h"
#import "mySelfHeaderCell.h"
#import "GlobalHelper.h"
#import "UIView+Frame.h"
#import "NormalSearchCell.h"
#import "Config.h"
@implementation MyselfTableViewDelegate

-(instancetype)init
{
    if(self = [super init])
    {
        self.dataSource = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
}

-(void)RegistTableView:(UITableView *)tableView
{
    tableView.delegate = self;
    tableView.dataSource = self;
}

#pragma  maek - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section == 0)
    {
        return  1;
    }
    else
    {
    
        NSArray * array= self.dataSource[section];
        return array.count;
    }
//    if(section == 0)
//    {
//    return 1;
//    }
//    else
//    {
//       return  10;
//    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellId";
    static NSString *headerId = @"headerId";
    NormalSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    mySelfHeaderCell * headerCell = [tableView dequeueReusableCellWithIdentifier:headerId];
    if(!cell)
    {
        cell = [[NormalSearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    if(!headerCell)
    {
        headerCell = [[mySelfHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerId];
        
    }
    
   
    if(indexPath.section == 0)
    {
         id data = self.dataSource[indexPath.section];
        [headerCell configData:data];
        return headerCell;
    }
    else
    {
         id data = self.dataSource[indexPath.section][indexPath.row];
        NSDictionary * dic = data;
        [cell ConfigData:dic];
        return  cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return  100;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0,0, tableView.width, 10)];
    [view setBackgroundColor:RGB_COLOR(@"#E4E4E4")];
    view.alpha = 0.2;
    return view;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell isKindOfClass:[mySelfHeaderCell class]])
    {
        mySelfHeaderCell * headerCell = (mySelfHeaderCell *)cell;
        [headerCell setSubViewsFrame];
    }
}



@end
