//
//  RetweetedStatusViewCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/12.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "RetweetedStatusViewCell.h"

@implementation RetweetedStatusViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.retweetedStatusView = [[RetweetedStatusView alloc]init];
        [self.contentView addSubview:self.retweetedStatusView];
    }
    return  self;
}


-(void)ConfigCellWithIndexPath:(NSIndexPath *)indexPath Data:(id)data cellType:(CellType)cellType 
{
    [super ConfigCellWithIndexPath:indexPath Data:data cellType:cellType ];
    Statuses * obj = (Statuses *)data;
    self.retweetedStatusView.canLoad = self.canLoad;
    [self.retweetedStatusView ConfigUIWithData:obj ];
    [self setSubviewsFrame];
}

-(void)setSubviewsFrame
{
    [super setSubviewsFrame];
    [self.retweetedStatusView setFrame:CGRectMake(0, _contentTextLabel.bottom, KScreenWidth, self.statusObj.retweetedContextHeight)];
    [self.retweetedStatusView setSubviewsFrame];
    [_bottomView setFrame:CGRectMake(0, self.retweetedStatusView.bottom, KScreenWidth, BottomToolViewHeight)];
    if(self.type == COMMENTDETAILSTYPE)
    {
        _bottomView.hidden = NO;
        [self ChangeBottomViewFrame];
    }
}

-(CGFloat)cellHeight
{
    return _bottomView.bottom;
}

-(void)ChangeBottomViewFrame
{
    NSArray * array = _bottomView.subviews;
    [_bottomView setFrame:CGRectMake(0, self.retweetedStatusView.bottom, KScreenWidth, 25)];
    int temp = 0;
    CGFloat width = self.width/6;
    for (UIView * view in array) {
        if([view isKindOfClass:[UIButton class]]){
            [view setFrame:CGRectMake(self.width / 2+width * temp ,0 , width, _bottomView.height)];
            temp ++;
        }
        else
        {
            view.hidden =YES;
        }
    }
}
@end
