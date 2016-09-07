//
//  UserObj.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObj : NSObject
@property (nonatomic, copy)NSString * idstr;
@property (nonatomic, copy)NSString * screen_name; //用户昵称
@property (nonatomic, copy)NSString * name; //好友显示昵称
@property (nonatomic, copy)NSString * profile_image_url; //用户头像地址
@property (nonatomic ,copy)NSString * cover_image_phone_url;//背景图地址
@property (nonatomic, copy)NSString * location; //所在地
@property (nonatomic, copy)NSNumber * statuses_count;//微博总数
@property (nonatomic, copy)NSString * verified_reason;//微博认证原因
@property (nonatomic, copy)NSNumber * followers_count; //粉丝
@property (nonatomic, copy)NSNumber * friends_count; //关注
-(void)setUserWithUserInfo:(NSDictionary *)user;
@end
