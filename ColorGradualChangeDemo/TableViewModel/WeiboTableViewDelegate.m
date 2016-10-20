        //
//  TableViewDelegate.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import "WeiboTableViewDelegate.h"
#import "RetweetedStatusViewCell.h"
#import "StatusViewForImageCell.h"
#import "SearchBar.h"
@implementation WeiboTableViewDelegate

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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Statuses * obj = self.dataSource[indexPath.row];
    static NSString * BaseCellID = @"BaseCellID";
    static NSString * RetweetedSatusCellID = @"RetweetedSatusCellID";
    static NSString * ImageContentCellID = @"ImageContentCellID";
    
    BaseCell *baseCell =(BaseCell *) [tableView dequeueReusableCellWithIdentifier:BaseCellID];
    RetweetedStatusViewCell *retweetedStatusViewCell =[[RetweetedStatusViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RetweetedSatusCellID];
    StatusViewForImageCell * statusViewForImageCell =[[StatusViewForImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ImageContentCellID];
    
    if(obj.retweeted_status.user)
    {
        if(!retweetedStatusViewCell)
        {
            retweetedStatusViewCell = [[RetweetedStatusViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RetweetedSatusCellID];
        }
        retweetedStatusViewCell.delegate = self;
        self.configCellBlock(indexPath,obj,retweetedStatusViewCell);
        [retweetedStatusViewCell SelectLink];
        return retweetedStatusViewCell;
    }
    else if(obj.pic_urls.count > 0)
    {
        if(!statusViewForImageCell)
        {
            statusViewForImageCell = [[StatusViewForImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ImageContentCellID];
        }
        statusViewForImageCell.delegate = self;
        self.configCellBlock(indexPath,obj,statusViewForImageCell);
         [statusViewForImageCell SelectLink];
        return statusViewForImageCell;
    }
    else
    {
        if(!baseCell)
        {
            baseCell = [[BaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BaseCellID];
        }
        baseCell.delegate = self;
        self.configCellBlock(indexPath,obj,baseCell);
         [baseCell SelectLink];
        return baseCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Statuses * obj = _dataSource[indexPath.row];
    [obj getStatusesHight];
    return [obj getStatusesHight];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCell * baseCell = (BaseCell *)cell;
    [baseCell setSubviewsFrame];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    self.selectedCellBlock(cell);
}
#pragma  BaseCellDelegate
-(void)SelectedCellBtn:(BaseCell *)cell btnType:(CommentType)type
{
    self.selectedCellBtnBolck(cell,type);
}
-(void)SelectedNameOrHeader:(Statuses *)statusObj
{
    self.selectedNameOrHeaderBlock(statusObj);
}
-(void)SelectedMoreBtn:(BaseCell *)cell
{
    self.selectedCellMoreBtnBlock(cell);
}
-(void)SelectedUserName:(Statuses *)statusObj
{
    
    NSLog(@"++++ %@",statusObj.user.name);
    self.selectedNameOrHeaderBlock(statusObj);
}
-(void)SelectedURL:(NSString *)url
{
    self.selectedURL(url);
}
@end
