//
//  NomarlFindCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "NormalSearchCell.h"
#import "UIView+Frame.h"
#import "GlobalHelper.h"
@implementation NormalSearchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self CreatUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return  self;
    
}

-(void)CreatUI
{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    [self addSubview:_imageView];
    
    
    _label = [[UILabel alloc]init];
    [_label setFont:[UIFont fontWithName:@"Helvetica" size:14.0f]];
    [self addSubview:_label];
    
    _sublabel = [[UILabel alloc]init];
    [_sublabel setFont:[UIFont fontWithName:@"Helvetica" size:10.0f]];
    [_sublabel setTextColor:[UIColor grayColor]];
    [self addSubview:_sublabel];
    
    _lineView = [[UIView alloc]init];
    [self addSubview:_lineView];
    [_lineView setBackgroundColor:[UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:215.0f/255.0f alpha:1]];
}


-(void)ConfigData:(NSDictionary *)dic
{
    [_imageView setImage:[UIImage imageNamed:dic[@"image"]]];
    [_label setText:dic[@"title"]];
    [_sublabel setText:dic[@"description"]];
    
    CGSize titleSize = [GlobalHelper boundingRectString:_label.text Size:CGSizeMake(CGFLOAT_MAX, 15) Font:14.0f];
    [_label setFrame:CGRectMake(_imageView.right + 5, _imageView.top + 5, titleSize.width, titleSize.height)];
    CGSize descriptionSize = [GlobalHelper boundingRectString:_sublabel.text Size:CGSizeMake(CGFLOAT_MAX, 15) Font:10.0f];
    [_sublabel setFrame:CGRectMake(_label.right+3, _label.top + 3, descriptionSize.width, descriptionSize.height)];
    [_lineView setFrame:CGRectMake(0, self.frame.size.height-0.5, KScreenWidth, 0.5)];
}

@end
