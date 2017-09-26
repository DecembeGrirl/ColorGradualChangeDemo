//
//  MessageTableViewDelegate.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/4/5.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "MessageTableViewDelegate.h"
#import "NormalSearchCell.h"
@implementation MessageTableViewDelegate

-(instancetype)init
{
    if(self = [super init])
    {
    
    }
    return self;
}

-(void)registTableView:(UITableView *)tableView Data:(NSArray *)array;
{
    tableView.delegate = self;
    tableView.dataSource = self;
    self.dataSource = array;
   
//    self.dataSource = @[@"@我的",@"评论",@"赞",@"新浪新闻",@"微博运动",@"网易云课堂"];
    self.dataSource = @[@{@"image":@"messagescenter_at",@"title":@"@我的",@"description":@""},@{@"image":@"messagescenter_comments",@"title":@"评论",@"description":@""},@{@"image":@"messagescenter_good",@"title":@"赞",@"description":@""},@{@"image":@"messagescenter_subscription",@"title":@"订阅消息",@"description":@""}];
}


#pragma  maek - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellId";
    NormalSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[NormalSearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lineView.hidden = YES;
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(45, 43.5, KScreenWidth - 45, 0.5)];
        [lineView  setBackgroundColor:[UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:215.0f/255.0f alpha:215.0f/255.0f]];
        [cell addSubview:lineView];
    }
    
    NSDictionary * dic = self.dataSource[indexPath.row];
    [cell ConfigData:dic];
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  44;
}


@end
