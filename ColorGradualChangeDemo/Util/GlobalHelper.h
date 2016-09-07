//
//  GlobalHelper.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYLabel.h"
#import "MBProgressHUD.h"
#import "User.h"
typedef void(^SelectedYYLabelRangeText)(UIView * containerView, NSAttributedString * text, NSRange range, CGRect rect);


@interface GlobalHelper : NSObject

@property (nonatomic,strong)User * user;

@property (nonatomic, copy)SelectedYYLabelRangeText selectedYYLabelRangeTextBlock;
+(instancetype)ShareInstance;

+(void)saveSsoInfoValue:(id)value;
+(void)SaveValue:(id)value Forkey:(NSString *)key;
+(id)getValueOfKey:(NSString *)key;


+(CGSize)boundingRectWithLable:(NSString *)string Size:(CGSize)size font:(CGFloat)font;
//计算文字高度
+(CGSize)boundingRectString:(NSString *)str Size:(CGSize)size Font:(CGFloat)font;

-(NSMutableAttributedString *)setText:(NSString *)str withAtr:(NSAttributedString *)atr ColorTextCheckingResult:(NSTextCheckingResult * )result withFont:(NSInteger)font withColor:(UIColor *)color;

-(NSAttributedString *)setStr:(NSString *)str WithColor:(UIColor *)color WithFont:(CGFloat)font;
//压缩图片
+(UIImage *)CompressImageWithSourceImage:(UIImage *)sourceImage ScaleSize:(CGSize)size;
+(NSString *)DateFormatter:(NSString *)str;

//正则表达式获取用户名
-(NSArray * )RegularExpressMatchUseNameWithString:(NSString *)string;

+(CGSize)CalculateYYlabelHeightAttributedString:(NSAttributedString *)atrText Size:(CGSize)size;


-(UIImage *)ClipCirCleImage:(UIImage *)image;

-(MBProgressHUD *)ShowHUD:(MBProgressHUD *)hud WithMessage:(NSString *)message afterDelay:(CGFloat)delay inView:(UIView *)view;

//将图片转换为富文本
+(NSMutableAttributedString *)ConverExpression:(UITextView *)textView andImage:(UIImage *)image;
@end
