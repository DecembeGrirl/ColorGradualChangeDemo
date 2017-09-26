//
//  ComboBoxView.m
//  移动物美
//
//  Created by 杨淑园 on 16/9/22.
//  Copyright © 2016年 赵永生. All rights reserved.
//

#import "ComboBoxView.h"
#define cellHeight    50

@implementation ComboBoxView

-(instancetype)init
{
    if(self = [super init])
    {
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        backGroundImage = [[UIImageView alloc]init];
        UIImage * image =[UIImage imageNamed:@"icon_comboBox_bg"];
        UIImage * newImage = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        [backGroundImage setImage:newImage];
        [self addSubview:backGroundImage];

        myTableView = [[UITableView alloc]init];
        myTableView.scrollEnabled = NO;
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:myTableView];
    }
    return  self;
}

-(void)setViewFrame
{
    CGFloat height = cellHeight * self.titleArray.count;
    
    [backGroundImage setFrame:CGRectMake(KScreenWidth - 10- 150, 62, 150, height+ 16)];
    [myTableView setFrame:CGRectMake(KScreenWidth - 10- 150+2, 72, 150-4, height)];
}

#pragma  maek - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self setViewFrame];
    return self.titleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:self.titleImageArray[indexPath.row]]];
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidden = YES;
    if([self.delegate respondsToSelector:@selector(SelectedComboBoxViewItem:)])
    {
        [self.delegate SelectedComboBoxViewItem:indexPath.row];
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath == self.redDotIndexpath)
    {
        UIView * redDotView = [[UIView alloc]init];
        [redDotView setBackgroundColor:[UIColor redColor]];
        redDotView.layer.cornerRadius = 4;
        redDotView.layer.masksToBounds = YES;
        [cell addSubview:redDotView];
        [redDotView setFrame:CGRectMake(40, 5, 8, 8)];
    }
}

-(void)showRedDotAtIndexPath:(NSIndexPath *)indexpath
{
    self.redDotIndexpath = indexpath;
}

-(void)show
{
    self.hidden = NO;
}

-(void)hidden
{
    self.hidden = YES;
//    [self removeFromSuperview];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hidden];
}


@end
