//
//  UserSsoObj.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSsoObj : NSObject
@property (nonatomic ,copy) NSString * userID;
@property (nonatomic ,copy) NSString * accessToken;
@property (nonatomic ,copy) NSDate * exporationDate;
@property (nonatomic ,copy) NSString * refreshToken;

@end
