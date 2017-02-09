//
//  UserHomeTableViewDelegate.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/22.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "UserHomeTableViewDelegate.h"
@implementation UserHomeTableViewDelegate

-(void)RegistTableView:(UITableView *)tableView
{
    tableView.delegate = self;
    tableView.dataSource = self;
}

#pragma  maek - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if(self.type == TypeOfUserHomeTableView)
        return self.userObj.location.length>0?2:1;
    else if(self.type == TypeOfUserAlssetsTableView)
    {
        return 10;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.type == TypeOfUserHomeTableView && section ==0 &&self.userObj.location.length>0)
        return 1;
    else if(self.type == TypeOfUserAlssetsTableView)
        return 1;
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Statuses* obj = self.dataSource[indexPath.row];
    static NSString *identifier = @"CellId";
    static NSString * BaseCellID = @"BaseCellID";
    static NSString * RetweetedSatusCellID = @"RetweetedSatusCellID";
    static NSString * ImageContentCellID = @"ImageContentCellID";
    static NSString * PhotoCellID = @"PhotoCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    BaseCell *baseCell =(BaseCell *) [tableView dequeueReusableCellWithIdentifier:BaseCellID];
    RetweetedStatusViewCell *retweetedStatusViewCell =[[RetweetedStatusViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RetweetedSatusCellID];
    StatusViewForImageCell * statusViewForImageCell =[[StatusViewForImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ImageContentCellID];
    userPhotoTableViewCell *  photoCell = [ tableView dequeueReusableCellWithIdentifier:PhotoCellID];
    if (self.type == TypeOfUserAlssetsTableView)
    {
        if(!photoCell)
        {
            photoCell = [[userPhotoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PhotoCellID];
            self.selectedPhotoBlock(photoCell);
        }
        [photoCell ConfigCellWith:nil];
        
        return photoCell;
    }
    else
    {
        if ((indexPath.section !=0&& self.type == TypeOfUserHomeTableView) || self.type == TypeOfUserStatusTableView )
        {
            if(obj.retweeted_status.user)
            {
                if(!retweetedStatusViewCell)
                {
                    retweetedStatusViewCell = [[RetweetedStatusViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RetweetedSatusCellID];
                    [retweetedStatusViewCell setHeadImageUserInterActionEnable:NO];
                }
                retweetedStatusViewCell.delegate = self;
                self.configCellBlock(indexPath,obj,retweetedStatusViewCell);
                //            [retweetedStatusViewCell layoutIfNeeded];
                return retweetedStatusViewCell;
            }
            else if(obj.pic_urls.count > 0)
            {
                if(!statusViewForImageCell)
                {
                    statusViewForImageCell = [[StatusViewForImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ImageContentCellID];
                    [statusViewForImageCell setHeadImageUserInterActionEnable:NO];
                }
                statusViewForImageCell.delegate = self;
                self.configCellBlock(indexPath,obj,statusViewForImageCell);
                //            [statusViewForImageCell layoutIfNeeded];
                return statusViewForImageCell;
            }
            else
            {
                if(!baseCell)
                {
                    baseCell = [[BaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BaseCellID];
                    [baseCell setHeadImageUserInterActionEnable:YES];
                }
                baseCell.delegate = self;
                self.configCellBlock(indexPath,obj,baseCell);
                //            [baseCell layoutIfNeeded];
                return baseCell;
            }
        }
        else
        {
            if(!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0f];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            cell.textLabel.text = [NSString stringWithFormat:@"所在地    %@",self.userObj.location];
            [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16.0]];
            return  cell;
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.type == TypeOfUserAlssetsTableView)
    {
        if(10 %3)
            return (KScreenWidth - 6)/3*(10/3 +1);
        else
            return (KScreenWidth - 6)/3* (10/3);
    }
    else
    {
        if (indexPath.section ==0 && self.userObj.location.length>0 && self.type == TypeOfUserHomeTableView) {
            return 80;
        }
        else{
            Statuses * obj = _dataSource[indexPath.row];
            return [obj getStatusesHight];
        }
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.type == TypeOfUserAlssetsTableView)
        return  30;
    else
        return 0;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.type == TypeOfUserAlssetsTableView)
    {
        userPhotoTableViewCell * myCell =(userPhotoTableViewCell *) cell;
        [myCell setCollectionViewFrame];
    }
    else
    {
        if((indexPath.section == 1 && self.type == TypeOfUserHomeTableView)||self.type == TypeOfUserStatusTableView)
        {
            BaseCell *baseCell = (BaseCell *)cell;
            [baseCell setSubviewsFrame];
        }
    }
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(self.type == TypeOfUserAlssetsTableView)
    {
        UILabel *lab = [[UILabel alloc]init];
        lab.text =[ NSString stringWithFormat:@"%2ld月",section + 1 ];
        lab.font = [UIFont systemFontOfSize:14.0];
        [lab setBackgroundColor:[UIColor whiteColor]];
        return lab;
    }
    
    if(section > 0)
    {
        UIView * view = [[UIView alloc]init];
        [view setBackgroundColor:[UIColor redColor]];
        return  view;
    }
    return  nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section != 0 || indexPath.row != 0)
//    {
        UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        self.selectedCellBlock(cell);
//    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.scrollViewDidScrollBlock(scrollView);
    if(self.type == TypeOfUserAlssetsTableView)
    {
        // 控制sectionHeaderView跟随tableView 一起滑动
        UITableView * tableview = (UITableView *)scrollView;
        CGFloat offsetY = tableview.contentOffset.y ;
        CGFloat tempOffsetY = -headImageheight-20;
        if (offsetY <= 0 && offsetY >= tempOffsetY)
        {
            tableview.contentInset = UIEdgeInsetsMake(-offsetY, 0, -0, 0);
        }
    }
}


-(void)SelectedCellBtn:(BaseCell *)cell btnType:(CommentType)type
{
    //    NSLog(NSString * _Nonnull format, ...)
}
-(void)SelectedMoreBtn:(BaseCell *)cell
{
    self.selectedCellMoreBtnBlock(cell);
}
-(void)SelectedNameOrHeader:(BaseCell *)cell
{
    NSLog(@"点击了 好友信息中的 status 的header");
}

-(void)SelectedUserName:(Statuses *)statusesObj
{
    NSLog(@"点击userName");
    self.selectedUserNameBlock(statusesObj);
    
}



//去掉UItableview headerview黏性(sticky)

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 40;//section的高度
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}


@end
