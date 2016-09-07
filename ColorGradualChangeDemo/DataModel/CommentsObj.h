//
//  CommnetsObj.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/15.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Statuses.h"
#import "User.h"
@interface CommentsObj : NSObject
@property (nonatomic,copy)NSString *created_at;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *text;
@property (nonatomic,copy)NSString *source;
@property (nonatomic,strong)User *user;
@property (nonatomic,copy)NSString *mid;
@property (nonatomic,copy)NSString *idstr;
@property (nonatomic,strong)Statuses *status;
@property (nonatomic,strong)CommentsObj *reply_comment;//评论来源评论，当本评论属于对另一评论的回复时返回此字段
//-(void)setCommentsObjWithData:(NSDictionary *)dic;
-(CGFloat)getHeight;

@end
