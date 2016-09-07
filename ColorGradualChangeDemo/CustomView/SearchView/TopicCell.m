//
//  TopicCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "TopicCell.h"
#import "UIView+Frame.h"
@implementation TopicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self CreatUI];
    }
    return  self;

}
-(void)CreatUI
{
    _lable1 = [[UILabel alloc]init];
    [_lable1 setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [self addSubview:_lable1];
    
    _lable2 = [[UILabel alloc]init];
    [_lable2 setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [self addSubview:_lable2];
    
    _lable3 = [[UILabel alloc]init];
    [_lable3 setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [self addSubview:_lable3];
    
    _lable4 = [[UILabel alloc]init];
    [_lable4 setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [self addSubview:_lable4];
}

-(void)ConfigData:(id)data
{
    [_lable1 setText:@"#法国小鲜油#"];
    [_lable2 setText:@"#公共场所建母婴室#"];
    [_lable3 setText:@"#bigbang is everything#"];
    [_lable4  setText:@"热门话题"];
    
    [self layoutFrame];
}

-(void)layoutFrame
{
    [_lable1 setFrame:CGRectMake(10, 5, self.width / 2 -20, 20)];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(self.width / 2-0.5, 2, 1, 16)];
    [line1 setBackgroundColor:[UIColor grayColor]];
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(2, _lable1.bottom,self.width / 2 -  8, 1)];
    [line2 setBackgroundColor:[UIColor grayColor]];
    [self addSubview:line2];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(line1.right + 4, line2.top, line2.width, line2.height)];
    [line3 setBackgroundColor:[UIColor grayColor]];
    [self addSubview:line3];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(line1.left, line1.bottom + 12 , line1.width, line1.height)];
    [line4 setBackgroundColor:[UIColor grayColor]];
    [self addSubview:line4];
    
    [_lable2 setFrame:CGRectMake(line1.right + 10, _lable1.top,_lable1.width, 20)];
    [_lable3 setFrame:CGRectMake(_lable1.left, _lable1.bottom, _lable1.width, 20)];
    [_lable4 setFrame:CGRectMake(_lable2.left, _lable3.top, _lable3.width, 20)];
}




@end
