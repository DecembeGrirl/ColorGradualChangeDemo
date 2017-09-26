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
        _needLoadArray = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
}

-(void)RegistTableView:(UITableView *)tableView
{
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    
    BaseCell *baseCell =[tableView dequeueReusableCellWithIdentifier:BaseCellID];
    RetweetedStatusViewCell *retweetedStatusViewCell =[tableView dequeueReusableCellWithIdentifier:RetweetedSatusCellID];
    StatusViewForImageCell * statusViewForImageCell =[tableView dequeueReusableCellWithIdentifier:ImageContentCellID];;
    
//    BOOL canLoad = tableView.isDecelerating==nil?YES:tableView.isDecelerating;
    NSArray *visibleCells = tableView.indexPathsForVisibleRows;
    BOOL canLoad = [visibleCells containsObject:indexPath];
    
//    BOOL canLoad = YES;
   
    if(obj.retweeted_status.user)
    {
        if(!retweetedStatusViewCell)
        {
            retweetedStatusViewCell = [[RetweetedStatusViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RetweetedSatusCellID];
            retweetedStatusViewCell.delegate = self;
//            NSLog(@" New 了一个  retweetedStatusViewCell");
        }
        retweetedStatusViewCell.canLoad = canLoad;
        self.configCellBlock(indexPath,obj,retweetedStatusViewCell,canLoad);
        [retweetedStatusViewCell SelectLink];
        return retweetedStatusViewCell;
    }
    else if(obj.pic_urls.count > 0)
    {
        if(!statusViewForImageCell)
        {
            statusViewForImageCell = [[StatusViewForImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ImageContentCellID];
            statusViewForImageCell.delegate = self;
//            NSLog(@" New 了一个  statusViewForImageCell");
        }
        statusViewForImageCell.canLoad = canLoad;
        self.configCellBlock(indexPath,obj,statusViewForImageCell,canLoad);
        [statusViewForImageCell SelectLink];
        return statusViewForImageCell;
    }
    else
    {
        if(!baseCell)
        {
            baseCell = [[BaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BaseCellID];
//            NSLog(@" New 了一个  baseCell");
            baseCell.delegate = self;
        }
        baseCell.canLoad = canLoad;
        self.configCellBlock(indexPath,obj,baseCell,canLoad);
         [baseCell SelectLink];
        
        return baseCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Statuses * obj = _dataSource[indexPath.row];
//    NSNumber * height =  _heightDataArray[indexPath.row];
    return  obj.height;
}
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSDate* Start = [NSDate date];
//    BaseCell * baseCell = (BaseCell *)cell;
//    [baseCell setSubviewsFrame];
//    double deltaTime = [[NSDate date] timeIntervalSinceDate:Start];
//    NSLog(@"＊＊＊＊＊运行时间 cost time = %f", deltaTime);
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    self.selectedCellBlock(cell);
}

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    self.canLoad = NO;
//}
//
//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//    self.canLoad = YES;
//}


//按需加载 - 如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定3行加载。
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    NSIndexPath *ip = [self.tableView indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
//    NSIndexPath *cip = [[self.tableView indexPathsForVisibleRows] firstObject];
//    NSInteger skipCount = 8;
//    if (labs(cip.row-ip.row)>skipCount) {
//        NSArray *temp = [self.tableView indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, self.tableView.size.width, self.tableView.size.height)];
//        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
//        if (velocity.y<0) {
//            NSIndexPath *indexPath = [temp lastObject];
//            if (indexPath.row+33) {
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-3 inSection:0]];
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-2 inSection:0]];
//                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0]];
//            }
//        }
//        [_needLoadArray addObjectsFromArray:arr];
//    }
//}




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
