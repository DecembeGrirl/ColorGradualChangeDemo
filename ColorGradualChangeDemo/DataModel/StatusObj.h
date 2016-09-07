//
//  StatusObj.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/8.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UserObj.h"
@interface StatusObj : NSObject
@property (nonatomic ,copy)NSNumber *wbId;
@property (nonatomic, copy)NSString *text;
@property (nonatomic, copy)NSNumber *favorited;
@property (nonatomic, assign)NSInteger sourceType;
@property (nonatomic, copy)NSString *thumbnail_pic;
@property (nonatomic, copy)NSString *bmiddle_pic;
@property (nonatomic, copy)NSString *original_pic;
@property (nonatomic, copy)NSArray  *pic_urls;
@property (nonatomic, strong)StatusObj *retweeted_status;

@property (nonatomic, copy)NSNumber *reposts_count;
@property (nonatomic, copy)NSNumber *comments_count;
@property (nonatomic, copy)NSNumber *attitudes_count;
@property (nonatomic, strong)UserObj *user;
@property (nonatomic, strong) NSMutableArray * imageArray;
@property (nonatomic, strong) NSMutableArray * thumbnail_pic_urls;
@property (nonatomic, strong) NSMutableArray * bmiddle_pic_urls;
@property (nonatomic, strong) NSMutableArray * original_pic_urls;

-(void)setStatusWithData:(NSDictionary *)status;
@end
