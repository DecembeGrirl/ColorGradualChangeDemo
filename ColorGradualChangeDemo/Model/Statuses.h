//
//  Statuses.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/7/5.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"
#import "Geo.h"
#import "Config.h"
#import "MJExtension.h"
@class  Statuses;
@interface Statuses : NSObject
@property (nonatomic, copy)NSNumber * ID;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, assign) BOOL  favorited;
@property (nonatomic, assign) BOOL  truncated;
@property (nonatomic, copy) NSString *in_reply_to_status_id;
@property (nonatomic, copy) NSString *in_reply_to_user_id;
@property (nonatomic, copy) NSString *in_reply_to_screen_name;
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, copy) NSNumber *reposts_count;
@property (nonatomic, copy) NSNumber *comments_count;
@property (nonatomic, copy) NSArray *annotations;
@property (nonatomic, strong) User *user;
@property (nonatomic, assign)NSInteger biz_feature;

@property (nonatomic, copy) NSArray * biz_ids;
@property (nonatomic, copy) NSArray * hot_weibo_tags;
@property (nonatomic, assign) BOOL isLongText;
@property (nonatomic, assign) NSInteger mlevel;
@property (nonatomic, copy) NSArray * pic_urls;

@property (nonatomic ,copy)NSNumber *attitudes_count;
@property (nonatomic, copy)NSNumber * source_type;
@property (nonatomic, copy)NSArray * darwin_tags;

@property (nonatomic, copy)NSNumber * source_allowclick;
@property (nonatomic, strong)Statuses *retweeted_status;
@property (nonatomic, copy)NSString * cardid;
@property (nonatomic, copy)NSNumber  *userType;
@property (nonatomic, copy)NSArray * text_tag_tips;
@property (nonatomic, copy)NSNumber * positive_recom_flag;
@property (nonatomic, copy)NSDictionary * visible;
@property (nonatomic, copy)NSString * rid;
@property (nonatomic, copy)NSString * thumbnail_pic;

@property (nonatomic, strong)Geo *geo;



-(CGFloat)getStatusesHight;
-(CGFloat)getImageHight;
@end
