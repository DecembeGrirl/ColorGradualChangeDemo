//
//  RequsetStatusService.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/8.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBHttpRequest.h"
#import "Statuses.h"
#import "GlobalHelper.h"
#import "Config.h"

typedef void(^SuccessConnectNetworkingBlock)(NSData *data , WBHttpRequest *request);
typedef void(^FialedConnectNetworkingBlock)(NSError *error);

@interface RequsetStatusService : NSObject<WBHttpRequestDelegate>

@property(nonatomic, copy)SuccessConnectNetworkingBlock successBlock;
@property(nonatomic, copy)FialedConnectNetworkingBlock fialedBlock;
+(RequsetStatusService *)shareInstance;
+(void)ConnectNetworkingWithURL:(NSString *)url params:(NSDictionary *)params connectType:(NSString *)type tag:(NSString *)tag;
-(void)FetchUserInfo;

-(void)FetchWeiBo:(NSInteger)page;

-(void)FetchWeiBoWithID:(NSNumber *)wbID;

-(void)FetchComments:(NSNumber *)WBId;

-(void)CreatFavoriterOfStauts:(Statuses*)obj;

-(void)RemoveFavoritesOfStauts:(Statuses *)obj;

-(void)GetUserPhotoInfo:(User *)user page:(NSInteger)page;

-(void)ShortURLToLongURL:(NSString * )shortURL;

-(void)getTrendHourly;

-(void)getNearbyLocation:(NSDictionary *)dic;
@end
