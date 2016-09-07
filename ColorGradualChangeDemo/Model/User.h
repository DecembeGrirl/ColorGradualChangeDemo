//
//  User.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/7/5.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface User : NSObject
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *profile_image_url;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSNumber *followers_count;
@property (nonatomic, copy) NSNumber *friends_count;
@property (nonatomic, copy) NSNumber *statuses_count;
@property (nonatomic, copy) NSNumber *favourites_count;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, assign) BOOL following;
@property (nonatomic, assign) BOOL allow_all_act_msg;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, assign) BOOL geo_enabled;
@property (nonatomic, assign) BOOL verified;
@property (nonatomic, assign) BOOL allow_all_comment;
@property (nonatomic, copy) NSString *avatar_large;
@property (nonatomic, copy) NSString *verified_reason;
@property (nonatomic, assign) BOOL follow_me;
@property (nonatomic, copy) NSNumber *online_status;
@property (nonatomic, copy) NSNumber *bi_followers_count;

@property (nonatomic, copy) NSString * verified_trade;
@property (nonatomic, copy) NSNumber * mbtype;
@property (nonatomic, copy) NSString * idstr;
@property (nonatomic, copy) NSString * lang;
@property (nonatomic, copy) NSString * verified_source_url;
@property (nonatomic, copy) NSString * credit_score;
@property (nonatomic, copy) NSString * block_word;
@property (nonatomic, copy) NSNumber * verified_type;
@property (nonatomic, copy) NSString * avatar_hd;
@property (nonatomic, copy) NSString * cover_image_phone;
@property (nonatomic, copy) NSNumber * star;
@property (nonatomic, copy) NSNumber * block_app;
@property (nonatomic, copy) NSNumber * urank;
@property (nonatomic, copy) NSString * verified_reason_url;
@property (nonatomic, copy) NSString * verified_source;
@property (nonatomic, copy) NSString * weihao;
@property (nonatomic, copy) NSString * pagefriends_count;
@property (nonatomic, copy) NSNumber * mbrank;
@property (nonatomic, copy) NSString * profile_url;
@property (nonatomic, copy) NSNumber * user_ability;
@property (nonatomic, copy) NSString * cardid;
@property (nonatomic, copy) NSNumber * ptype;
@end
