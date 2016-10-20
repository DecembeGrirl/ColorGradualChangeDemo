//
//  YSHYPopoverView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/4/13.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "YSHYPopoverView.h"
#import "UIView+Frame.h"
#import "Config.h"
@implementation YSHYPopoverView

-(instancetype)init
{
    if(self = [super init])
    {
        _tableView = [[UITableView alloc]init];
       
        _tableView .separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 3;
        _tableView.layer.masksToBounds = YES;
        [self addSubview:_tableView];
        self.direction = DirectionFromUP;
    }
    return  self;
}

-(void)ConfigDatasource:(NSArray *)array
{
    self.dataSorce = array;
    [_tableView reloadData];
}

#pragma  maek - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSorce.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellId";
    PopoverCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[PopoverCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSString * str = self.dataSorce[indexPath.row];
    [cell configUIWithText:str image:nil];
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

-(void)showWithView:(UIView *)view
{
     CGFloat heigth = [self getHeight];
   
    self.hidden = NO;
    CGRect frame = [[view superview] convertRect:view.frame toView:[UIScreen mainScreen].focusedView];
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, view.size.width, 0)];
     [_tableView setFrame:CGRectMake(0, 0,self.width,heigth)];
    [UIView animateWithDuration:0.25f animations:^{
        CGRect newFrame = frame;
        newFrame.origin.y = frame.origin.y - heigth;
        newFrame.size.height = heigth;
        [self setFrame:newFrame];
    }];
}

-(void)hiddenWithView:(UIView *)view
{
    CGRect frame = [[view superview] convertRect:view.frame toView:[UIScreen mainScreen].focusedView];
//    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, view.size.width, 0)];
    [UIView animateWithDuration:0.25f animations:^{
        CGRect newFrame = frame;
        newFrame.origin.y = frame.origin.y ;
        [self setFrame:frame];
        
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];


}

-(CGFloat)getHeight
{
    CGFloat height = cellHeight * self.dataSorce.count;
    return  height;
}


@end
