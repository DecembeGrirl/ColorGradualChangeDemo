//
//  UserObj.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "UserObj.h"
#import "Config.h"
@implementation UserObj

-(void)setUserWithUserInfo:(NSDictionary *)user
{
    self.name = user[Kname];
    self.screen_name = user[Kscreen_name];
    self.idstr = user[Kidstr];
    self.profile_image_url = user[Kavatar_large_url];
    self.cover_image_phone_url =  user[Kcover_image_phone_url];
    self.location = user[Klocation];
    self.verified_reason = user[Kverified_reason];
    self.statuses_count = user[Kstatuses_count];
    self.followers_count = user[Kfollowers_count];
    self.friends_count = user[Kfriends_count];
    
}



@end
