//
//  MessageCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/4/5.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self CreatUI];
    }
    return self;
}

-(void)CreatUI
{
    _imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_imageView];
    
    _nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_nameLabel];
    
    _detailsLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_detailsLabel];
    
    _dateLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_dateLabel];
}

-(void)ConfigUIWithData:(id)data
{
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    

}
@end
