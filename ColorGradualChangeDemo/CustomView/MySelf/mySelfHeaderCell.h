//
//  mySelfHeaderCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/7/11.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface mySelfHeaderCell : UITableViewCell

@property(nonatomic, strong)UIImageView * headImage;
@property(nonatomic, strong)UILabel * nameLa;
@property(nonatomic, strong)UILabel * decriptionLa;
@property(nonatomic, strong)UIImageView * VipImage;
@property(nonatomic, strong)UIView *lineView;
@property(nonatomic, strong)UIButton * weiBoBtn;
@property(nonatomic, strong)UIButton * followBtn;
@property(nonatomic, strong)UIButton *fansBtn;

-(void)setSubViewsFrame;
-(void)configData:(id)data;

@end
