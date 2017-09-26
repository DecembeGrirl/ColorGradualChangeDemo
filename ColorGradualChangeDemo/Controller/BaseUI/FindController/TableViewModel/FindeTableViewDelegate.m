//
//  TableViewDelegate.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 15/12/23.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import "FindeTableViewDelegate.h"
#import "CycleScrollCell.h"
#import "TopicCell.h"
#import "NormalSearchCell.h"
@implementation FindeTableViewDelegate

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
    [tableView reloadData];
}

#pragma  maek - tableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        NSArray * temp = _dataSource[0];
        return temp.count;
    }
    else if(section == 3)
    {
        NSArray * temp = _dataSource[1];
        return temp.count;
    }
    else if(section == 4)
    {
        NSArray * temp = _dataSource[2];
        return temp.count;
    }
    return  1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    id obj = self.dataSource[indexPath.row];
    static NSString * cycleScrollCellID = @"CycleScrollCellID";
    static NSString * topicCellId = @"TopicCellID";
    static NSString * normalSearchCellID =  @"NormalSearchCellID";
    
    CycleScrollCell *cycleScrollCell =(CycleScrollCell *) [tableView dequeueReusableCellWithIdentifier:cycleScrollCellID];
    TopicCell * topicCell = (TopicCell *)[tableView dequeueReusableCellWithIdentifier:topicCellId];
    NormalSearchCell *normalSearchCell = (NormalSearchCell*)[tableView dequeueReusableCellWithIdentifier:normalSearchCellID];
    
    if(indexPath.section == 0)
    {
        if(!cycleScrollCell)
        cycleScrollCell = [[CycleScrollCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cycleScrollCellID];
         cycleScrollCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cycleScrollCell;
    }
    else if (indexPath.section == 1)
    {
        if(!topicCell)
        topicCell = [[TopicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topicCellId];
         topicCell.selectionStyle = UITableViewCellSelectionStyleNone;
       UIView * lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, KScreenWidth, 0.5)];
        [topicCell addSubview:lineview];
        [lineview setBackgroundColor:[UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:215.0f/255.0f alpha:1]];
        return  topicCell;
    }
    else
    {
        if(!normalSearchCell)
        normalSearchCell = [[NormalSearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalSearchCellID];
        return normalSearchCell;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 100;
    }
    else if(indexPath.section == 1)
    {
        return 50;
    }
    return  40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view=[[UIView alloc]init];
    [view setBackgroundColor:[UIColor colorWithRed:248.0f/255.0f green:248.0f/255.0f blue:248.0f/255.0f alpha:1]];
    UIView  * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 4.5, KScreenWidth, 0.5)];
    [lineView setBackgroundColor:[UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:215.0f/255.0f alpha:1]];
    [view addSubview:lineView];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  5;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.configCellBlock(indexPath,self.dataSource,cell);
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NormalSearchCell *norCell;
    NSString * str = @"点击了";
    if([cell isKindOfClass:[NormalSearchCell class]])
    {
        norCell = (NormalSearchCell *)cell;
        str = norCell.label.text;
    }
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:str delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
    [alert show];
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    self.scrollViewDidScrollBlock(scrollView);
//}

//
//#pragma  BaseCellDelegate 
//-(void)SelectedCell:(BaseCell *)cell
//{
////    if(self)
//    self.selectedCellBolck(cell);
//
//}



@end
