//
//  RequsetStatusService.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/8.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "RequsetStatusService.h"

static RequsetStatusService *_instance= nil;
@implementation RequsetStatusService
+(RequsetStatusService *)shareInstance
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

+(void)ConnectNetworkingWithURL:(NSString *)url params:(NSDictionary *)params connectType:(NSString *)type  tag:(NSString *)tag
{
    [WBHttpRequest requestWithURL:url httpMethod:type params:params delegate:[RequsetStatusService shareInstance] withTag:tag];
}
-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
{
    //    if([request.tag  isEqualToString:KTagGetUserPhotoInfo])
    //    {
    //        NSArray * array= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    ////        if(!dataDic[@"error"])
    //            self.successBlock(,request);
    //    }
    //    else
    //    {
         NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //    if(!dataDic[@"error"])
    if(data)
    {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.successBlock(data,request);
    });
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.fialedBlock(dataDic[@"error"]);
        });
    }
    
    //    }
}
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.fialedBlock(error);
    });
}
#pragma  mark - 获取微博个人信息
-(void)FetchUserInfo
{
    NSString *accessToken = [GlobalHelper getValueOfKey:Kaccess_token];
    NSString * uid = [GlobalHelper getValueOfKey:KUid];
    NSDictionary * params = @{Kaccess_token:accessToken,KUid:uid};
    [RequsetStatusService ConnectNetworkingWithURL:KURLUserInfo params:params connectType:@"GET" tag:KTagGetUserInfo];
}
#pragma mark - 获取微博
-(void)FetchWeiBo:(NSInteger)page
{
    NSString *accessToken = [GlobalHelper getValueOfKey:Kaccess_token];
    NSDictionary *params = @{Kaccess_token:accessToken,Kpage:[NSString stringWithFormat:@"%ld", (long)page],@"count":@"30"};
    [RequsetStatusService ConnectNetworkingWithURL:KUserAndeFriendWeiBo params:params connectType:@"GET" tag:KTagGetUserAndFriendWeibo];
}
#pragma mark - 根据微博ID 获取微博信息
-(void)FetchWeiBoWithID:(NSString *)wbID
{
    NSString *accessToken = [GlobalHelper getValueOfKey:Kaccess_token];
    NSDictionary *params = @{Kaccess_token:accessToken,Kid:wbID};
    [RequsetStatusService ConnectNetworkingWithURL:KURLGetWeiBoInfoWithID params:params connectType:@"GET" tag:KTagGetSingleWeiboInfoWithID];
}

#pragma mark 获取指定微博的评论
-(void)FetchComments:(NSString *)WBId
{
    NSString *accessToken = [GlobalHelper getValueOfKey:Kaccess_token];
    NSDictionary * params = @{Kaccess_token:accessToken,Kid:[NSString stringWithFormat:@"%@", WBId]};
    [RequsetStatusService ConnectNetworkingWithURL:KURLComments params:params connectType:@"GET"  tag:KTagGetComments];
}
#pragma mark  添加收藏
-(void)CreatFavoriterOfStauts:(Statuses*)obj
{
    NSString *accessToken = [GlobalHelper getValueOfKey:Kaccess_token];
    NSDictionary * params = @{Kaccess_token:accessToken,Kid:[NSString stringWithFormat:@"%@", obj.ID]};
    [RequsetStatusService ConnectNetworkingWithURL:KURLCreatFavorites params:params connectType:@"POST"  tag:KTagCreatFavorites];
}

#pragma mark 取消收藏
-(void)RemoveFavoritesOfStauts:(Statuses *)obj
{
    NSString *accessToken = [GlobalHelper getValueOfKey:Kaccess_token];
    NSDictionary * params = @{Kaccess_token:accessToken,Kid:[NSString stringWithFormat:@"%@", obj.ID]};
    [RequsetStatusService ConnectNetworkingWithURL:KURLRemoveFavorites params:params connectType:@"POST"  tag:KtagRemoveFavorites];
}


#pragma  mark --获取用户相册信息
-(void)GetUserPhotoInfo:(User *)user page:(NSInteger)page
{
    NSString *accessToken = [GlobalHelper getValueOfKey:Kaccess_token];
    NSDictionary * params = @{Kaccess_token:accessToken,KUid:user.idstr,Kpage:[NSString stringWithFormat:@"%ld", (long)page]};
    [RequsetStatusService ConnectNetworkingWithURL:KURLGetUserPhoto params:params connectType:@"GET" tag:KTagGetUserPhotoInfo];
}

#pragma mark --  短连接转为普通链接
-(void)ShortURLToLongURL:(NSString * )shortURL
{
    NSString *accessToken = [GlobalHelper getValueOfKey:Kaccess_token];
    NSDictionary * params = @{Kaccess_token:accessToken,KShort_URL:shortURL};
    [RequsetStatusService ConnectNetworkingWithURL:KURLShort_urlToLong_url params:params connectType:@"GET" tag:KTagShortURLToLongURL];
}
#pragma mark --  获取最近一小时的话题
-(void)getTrendHourly
{
    NSString *accessToken = [GlobalHelper getValueOfKey:Kaccess_token];
    NSDictionary * params = @{Kaccess_token:accessToken};
    [RequsetStatusService ConnectNetworkingWithURL:KURLGetTrends_hourly params:params connectType:@"GET" tag:KTagTrends_hourly];
}
-(void)getNearbyLocation:(NSDictionary *)dic
{
    NSString *accessToken = [GlobalHelper getValueOfKey:Kaccess_token];
    NSDictionary * params = @{Kaccess_token:accessToken,@"lat":dic[@"lat"],@"long":dic[@"long"]};
    [RequsetStatusService ConnectNetworkingWithURL:LURLGetNearByLocation params:params connectType:@"GET" tag:KTagNearbyLocation];
}

@end

