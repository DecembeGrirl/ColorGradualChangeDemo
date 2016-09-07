//
//  FriendFollowingHeaderView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/8/24.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLabel.h"
@protocol FriendFollowingHeaderViewDelegate <NSObject>

-(void)selectedfollowingBtn:(NSInteger )section;

@end

@interface FriendFollowingHeaderView : UIView
@property (nonatomic, strong)YYLabel *label;
@property (nonatomic, strong)UIButton * imageViewBtn;
@property (nonatomic, assign)NSInteger section;
@property (nonatomic, assign)id<FriendFollowingHeaderViewDelegate>delegate;
-(void)configData:(NSArray *)dataArray section:(NSInteger )section;
@end
