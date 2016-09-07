//
//  TableViewDelegate.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import "DetailsTableViewDelegate.h"
#import "BaseCell.h"
#import "RetweetedStatusViewCell.h"
#import "StatusViewForImageCell.h"
#import "CommentHeaderView.h"
#import "CommentsCell.h"
#import "Statuses.h"
@implementation DetailsTableViewDelegate

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
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
      self.commentsArray =self.dataSource.count>=2?self.dataSource[1]:nil;
        return self.commentsArray?self.commentsArray.count:0;
    }
    return  1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    static NSString * BaseCellID = @"BaseCellID";
    static NSString * RetweetedSatusCellID = @"RetweetedSatusCellID";
    static NSString * ImageContentCellID = @"ImageContentCellID";
    static NSString * CommentCellID = @"CommentCellID";
    BaseCell *baseCell =(BaseCell *) [tableView dequeueReusableCellWithIdentifier:BaseCellID];
    RetweetedStatusViewCell *retweetedStatusViewCell =[tableView dequeueReusableCellWithIdentifier:RetweetedSatusCellID];
    StatusViewForImageCell * statusViewForImageCell =[tableView dequeueReusableCellWithIdentifier:ImageContentCellID];
    CommentsCell *commentCell =[tableView dequeueReusableCellWithIdentifier:CommentCellID];
    
    if(indexPath.section == 0)
    {
        Statuses * obj = self.dataSource[0];
        if(obj.retweeted_status.user)
        {
            if(!retweetedStatusViewCell)
            {
             retweetedStatusViewCell =[[RetweetedStatusViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RetweetedSatusCellID];
                 retweetedStatusViewCell.type = self.type;
                retweetedStatusViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
                retweetedStatusViewCell.delegate = self;

            }
            [retweetedStatusViewCell ConfigCellWithIndexPath:indexPath Data:self.dataSource[0] cellType:cellTypeOfDetails];
            self.configCellBlock(indexPath,nil,retweetedStatusViewCell);
//            [retweetedStatusViewCell layoutIfNeeded];
            return  retweetedStatusViewCell;
        }
        else if(obj.pic_urls.count > 0)
        {
            if(!statusViewForImageCell)
            {
                statusViewForImageCell =[[StatusViewForImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ImageContentCellID];
                statusViewForImageCell.type = self.type;
                statusViewForImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
                statusViewForImageCell.delegate = self;
            }
        
            [statusViewForImageCell ConfigCellWithIndexPath:indexPath Data:self.dataSource[0] cellType:cellTypeOfDetails];
            self.configCellBlock(indexPath,nil,statusViewForImageCell);
//            [statusViewForImageCell layoutIfNeeded];
            return statusViewForImageCell;
        }
        else
        {
            if(!baseCell)
            {
            baseCell = [[BaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BaseCellID];
                baseCell.type = self.type;
                baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
                baseCell.delegate = self;
            }
            [baseCell ConfigCellWithIndexPath:indexPath Data:self.dataSource[0] cellType:cellTypeOfDetails];
           
            self.configCellBlock(indexPath,nil,baseCell);
            return baseCell;
        }
    }
    else if(indexPath.section ==2)
    {
        if(!commentCell)
        {
        commentCell = [[CommentsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCellID];
        }
        [commentCell ConfigData:self.commentsArray[indexPath.row]];
        return commentCell;
    }
    else
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return  cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        Statuses * obj = _dataSource[indexPath.row];
        CGFloat height =  obj.retweeted_status?[obj getStatusesHight]- 40 + 27:[obj getStatusesHight] - 40 ;
        return height;
    }
    else if(indexPath.section == 1)
    {
        return 80;
    }
    CommentsObj * commentObj = self.commentsArray[indexPath.row];
    return  [commentObj getHeight];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 2)
    {
        return 40;
    }
    return 5;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        cell.textLabel.text = @"相关推荐";
    }
    else if (indexPath.section == 0)
    {
        BaseCell * baseCell = (BaseCell *)cell;
        [baseCell setSubviewsFrame];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 2)
    {
        CommentHeaderView *view = [[CommentHeaderView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
        [view ConfigData:self.dataSource[0]];
        return view;
    }
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell");
}

-(void)SelectedNameOrHeader:(BaseCell *)cell
{
    self.selectedNameOrHeaderBlock(cell);
}
-(void)SelectedCellBtn:(BaseCell *)cell btnType:(CommentType)type
{
//    self.selectedCellBtnBolck(cell,type);
    NSLog(@"跳转到微博正文页面 显示转发 评论部分");
}
-(void)SelectedMoreBtn:(BaseCell *)cell
{
    self.selectedCellMoreBtnBlock(cell);
}



@end
