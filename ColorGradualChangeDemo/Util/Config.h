//
//  Config.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/6.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define RGB_COLOR(_STR_) ([UIColor colorWithRed:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(1, 2)] UTF8String], 0, 16)] intValue] / 255.0 green:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(3, 2)] UTF8String], 0, 16)] intValue] / 255.0 blue:[[NSString stringWithFormat:@"%lu", strtoul([[_STR_ substringWithRange:NSMakeRange(5, 2)] UTF8String], 0, 16)] intValue] / 255.0 alpha:1.0])


#define  KAppKey @"2851962511"
//#define  KloginURL @"https://open.weibo.cn/oauth2/authorize?"  //授权登录
#define KLoginURL @"https://api.weibo.com/oauth2/authorize?"
#define KRedirectUri @"http://baidu.com" //授权回调页面
#define KUserAndeFriendWeiBo  @"https://api.weibo.com/2/statuses/friends_timeline.json"//获取当前用户及其关注用户的微博
#define KURLGetWeiBoInfoWithID @"https://api.weibo.com/2/statuses/show.json"  //根据微博ID货物单条微博信息
#define KURLUserInfo  @"https://api.weibo.com/2/users/show.json"//用户个人信息
#define KURLComments  @"https://api.weibo.com/2/comments/show.json" //根据微博ID返回某条微博的评论列表
#define KURLUserStatus @"https://api.weibo.com/2/statuses/user_timeline.json"  //获取指定用户的所有微博
#define KURLCreatFavorites @"https://api.weibo.com/2/favorites/create.json" // 添加收藏
#define  KURLRemoveFavorites @"https://api.weibo.com/2/favorites/destroy.json"  //移除收藏
#define KURLGetUserPhoto   @"https://api.weibo.com/2/place/users/photos.json"  // 获取用户相册
#define KURLShort_urlToLong_url  @"https://api.weibo.com/2/short_url/expand.json"

#define KURLGetTrends_hourly @"https://api.weibo.com/2/trends/hourly.json" // 返回最近一小时内的热门话题







#define Kaccess_token @"access_token"
#define KUid @"uid"
#define KExpirationDate  @"expirationDate"
#define KRefreshToken  @"refreshToken"


#define Kfavorited @"favorited"
#define KRemoveFavorites @"removeFavorites"
#define Kcount @"count"
#define Kpage @"page"
#define Kid @"id"
#define Ktext @"text"
#define Kthumbnail_pic  @"thumbnail_pic"
#define KImageContentView  @"ImageContentView"
#define Kthumbnail_pic_img @"thumbnail_pic_image" //缩略图地址
#define Kthumbnail @"thumbnail"

//#define Kbmiddle_pic_url @"bmiddle_pic" //中等图片地址
#define Kbmiddle @"bmiddle"

//#define Koriginal_pic_url @"original_pic" //原图地址
#define Koriginal @"original"

#define KDisplay_pic  @"displayImage"   // 显示图片

#define Kpic_urls @"pic_urls"
#define Kreposts_count @"reposts_count"
#define Kcomments_count @"comments_count"
#define Kattitudes_count @"attitudes_count"
#define Kretweeted_status @"retweeted_status"
#define Kuser @"user"

#define Kidstr @"idstr"
#define Kscreen_name @"screen_name"
#define Kname @"name"
#define Kprofile_image_url @"profile_image_url"   //用户头像地址  中图 50*50
#define Kavatar_large_url  @"avatar_large"            //用户头像地址  大图 180 * 180
#define Kavatar_large_image @"Kavatar_large_image" //用户头像图片
#define Kcover_image_phone_url  @"cover_image_phone"   //背景图
#define Klocation @"location"
#define Kstatuses_count @"statuses_count"
#define Kverified_reason @"verified_reason"
#define Kfollowers_count @"followers_count"
#define Kfriends_count @"friends_count"
#define Kstatuses @"statuses"
#define Kstatus @"status"
#define KstatusComments @"statutsComments"
#define KShort_URL  @"url_short"


#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define KsigleImageViewWidth (([UIScreen mainScreen].bounds.size.width-5)/3 - 4)

//TAG
#define KTagGetUserInfo  @"userInfo"
#define KTagGetUserAndFriendWeibo  @"userAndFriendWeibo"
#define KTagGetComments  @"StatusComments"
#define KTagGetUserStatus  @"UserStatus"   //获取指定用户的微博
#define KTagCreatFavorites @"CreatFavorites"
#define KtagRemoveFavorites  @"RemoveFavorites"
#define KTagGetSingleWeiboInfoWithID @"GetSingleWeiboInfoWithID"
#define KTagGetUserPhotoInfo     @"GetUserPhotoInfo"
#define KTagShortURLToLongURL    @"ShortURLToLongURL"
#define KTagTrends_hourly        @"Trends_hourly"


#define KComments @"comments"
//评论字段
#define KCommentsCreatAt @"created_at"
#define KCommentsID @"id"
#define KCommentsText @"text"
#define KCommentsSource @"source"
#define KCommentsUser @"user"
#define KCommentsMid @"mid"
#define KCommentsIDStr @"idstr"
#define KCommentsStatus @"status"
#define KCommentsReplyComment @"reply_comment"


#define BottomToolViewHeight 40   //bottomToolViewBtnHeight

typedef enum {
    DEFULTTYPE          = 0,
    REPORTTYPE          = 1,   //转发微博
    COMMENTTYPE         = 2,   //评论
    COMMENTDETAILSTYPE  = 3,   //评论进入正文页面
    DETAILSTYPE               //点击cell进去正文页面
    
}CommentType;

//typedef enum
//{
//
//}headImageViewType;


#endif /* Config_h */
