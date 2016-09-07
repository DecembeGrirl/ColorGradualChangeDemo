//
//  FriendFollowingTableViewCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/8/24.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendFollowingTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UILabel * nameLa;
@property (nonatomic, strong) UILabel * descripLa;
@property (nonatomic, strong) UILabel * statusLa;
@property (nonatomic, strong) UIButton * followingBtn;

-(void)ConfigData:(NSDictionary *)dic;
-(void)setSubViewFrame;
@end
