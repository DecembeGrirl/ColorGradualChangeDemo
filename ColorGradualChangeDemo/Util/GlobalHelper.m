//
//  GlobalHelper.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/1/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "GlobalHelper.h"
#import "WeiboSDK.h"
#import "Config.h"
#import "NSAttributedString+YYText.h"
#import "YYLabel.h"

static GlobalHelper * instance = nil;
@implementation GlobalHelper
+(instancetype)ShareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
+(instancetype)defualtGlobalHelpr
{
    if(!instance)
        instance = [[self allocWithZone:NULL]init];
    return instance;
}

+(void)saveSsoInfoValue:(WBAuthorizeResponse *)authorizeInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults  setObject:authorizeInfo.userID forKey:KUid];
    [defaults setObject:authorizeInfo.accessToken forKey:Kaccess_token];
    [defaults setObject:authorizeInfo.expirationDate forKey:KExpirationDate];
    [defaults setObject:authorizeInfo.refreshToken forKey:KRefreshToken];
}

+(void)SaveValue:(id)value Forkey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([value isKindOfClass:[UIImage class]])
    {
        [defaults setObject:UIImagePNGRepresentation(value) forKey:key];
        return;
    }
    [defaults  setObject:value forKey:key];
}

+(id)getValueOfKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id value =[defaults objectForKey:key];
    if([value isKindOfClass:[NSData class]])
    {
        UIImage *image = [UIImage imageWithData:value];
        return image;
    }
    return [defaults objectForKey:key];
}

+(CGSize)boundingRectWithLable:(NSString *)string Size:(CGSize)size font:(CGFloat)font
{
    CGSize textSize ;
        CGRect rect = [string boundingRectWithSize:CGSizeMake(size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:font]} context:nil];
        textSize = rect.size;
    return textSize;
}



//计算富文本文字高度 
+(CGSize)boundingRectString:(NSString *)str Size:(CGSize)size Font:(CGFloat)font
{
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:str];
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont fontWithName:@"Helvetica" size:font]
                   range:NSMakeRange(0, attStr.length)];
    CGSize textSize = [attStr boundingRectWithSize:CGSizeMake(size.width, size.height)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                           context:nil].size;
    return textSize;
}
//设置str中多个位置的文字颜色
-(NSAttributedString *)setStr:(NSString *)str WithColor:(UIColor *)color WithFont:(CGFloat)font
{
    NSMutableAttributedString * atr = [[NSMutableAttributedString alloc]initWithString:str];
    [atr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:font] range:NSMakeRange(0, atr.length)];
    NSArray * arrayColor = [self RegularExpressMatchUseNameWithString:str];
    for (NSTextCheckingResult *result  in arrayColor) {
        atr = [self setText:str withAtr:atr ColorTextCheckingResult:result withFont:font withColor:color];
    }
    return atr;
}


//设置文字颜色
-(NSMutableAttributedString *)setText:(NSString *)str withAtr:(NSAttributedString *)atr ColorTextCheckingResult:(NSTextCheckingResult * )result withFont:(NSInteger)font withColor:(UIColor *)color;
{
    
    NSString * colorStr =[str substringWithRange:NSMakeRange(result.range.location, result.range.length)];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithAttributedString:atr];
    NSArray * array = @[@":",@",",@".",@"!",@"。",@"、",@"?"];
    BOOL hasPuch = NO;
    for (NSString * temp in array ) {
        if([colorStr hasSuffix:temp])
        {
            hasPuch = YES;
            colorStr = [colorStr substringToIndex:colorStr.length-1];
            break;
        }
    }
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:colorStr];
    one.yy_font = [UIFont fontWithName:@"Helvetica" size:font];
    one.yy_underlineStyle = NSUnderlineStyleNone;
    __weak typeof(self) weakSelf = self;
    //[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
    //[UIColor colorWithWhite:0.000 alpha:0.220]
    
    // 改变yylabel 的字体颜色
    [one yy_setTextHighlightRange:one.yy_rangeOfAll
                            color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                  backgroundColor:[UIColor redColor]
                        tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                            NSLog(@"%@",containerView);
                            NSLog(@"---- %@",text);
//                            [weakSelf ShareInstance].selectedYYLabelRangeTextBlock(containerView,text,range,rect);
                            weakSelf.selectedYYLabelRangeTextBlock(containerView,text,range,rect);
                        }];
    
    if(hasPuch)
    {
        [attrStr replaceCharactersInRange:NSMakeRange(result.range.location, result.range.length-1) withAttributedString:one];
    }
    else
    {
        [attrStr replaceCharactersInRange:result.range withAttributedString:one];
    }
    return attrStr;
}

+(UIImage *)CompressImageWithSourceImage:(UIImage *)sourceImage ScaleSize:(CGSize)size
{
    CGSize originalSize = sourceImage.size;
    
    CGFloat widthRation = size.width/originalSize.width;
    CGFloat height = originalSize.height * widthRation;
    size.height = height;
    
    UIGraphicsBeginImageContext(size);
    CGRect thumbRect = CGRectZero;
    thumbRect.size.width  = size.width;
    thumbRect.size.height = height;
    [sourceImage drawInRect:thumbRect];
    
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
   NSData *thumbImageData = UIImagePNGRepresentation(thumbImage);
    UIImage  *image = [UIImage imageWithData:thumbImageData];
    return image;
}


+(NSString *)DateFormatter:(NSString *)str
{
//    NSDictionary * weekDic = @{@"Mon":@"一",@"Tue":@"二",@"Wed":@"三",@"Thu":@"四",@"Fri":@"五",@"Sat":@"六",@"Sun":@"日"};
//    NSDictionary * monthDic =@{@"Jan":@"1",@"Feb":@"2",@"Mar":@"3",@"Apr":@"4",@"May":@"5",@"Jan":@"6",@"Jul":@"7",@"Aug":@"8",@"Sep":@"9",@"Oct":@"10",@"Nov":@"11",@"Dec":@"12"};
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"EEE MMM d HH:mm:ss Z yyyy"];
    NSDate* date = [formatter dateFromString:str];
    date = [date dateByAddingTimeInterval:8*60*60];
    
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString * dateStr = [formatter stringFromDate:date];
    return  dateStr;
}

-(NSArray *)RegularExpressMatchUseNameWithString:(NSString *)string
{
    NSRegularExpression *reg = [[NSRegularExpression alloc]initWithPattern:@"([@].*?([[\\p{P}\\p{S}\\s]&&[^_]&&[^-]]))|(#.*?#)|([http|https]+://[^\\s]*)|([@].*)" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray * array = [reg matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    return array;
}

+(CGSize)CalculateYYlabelHeightAttributedString:(NSAttributedString *)atrText Size:(CGSize)size
{
    NSAttributedString *text = atrText;
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
    return layout.textBoundingSize;
}

-(UIImage *)ClipCirCleImage:(UIImage *)image
{
    CGFloat arcCenterX = image.size.width/ 2;
    CGFloat arcCenterY = image.size.height / 2;
    
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextAddArc(context, arcCenterX , arcCenterY, image.size.width/ 2 , 0.0, 2*M_PI, NO);
    CGContextClip(context);
    CGRect myRect = CGRectMake(0 , 0, image.size.width, image.size.height);
    [image drawInRect:myRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

-(MBProgressHUD *)ShowHUD:(MBProgressHUD *)hud WithMessage:(NSString *)message afterDelay:(CGFloat)delay inView:(UIView *)view
{
    if(!hud)
    {
        hud = [[MBProgressHUD alloc]init];
        [view addSubview:hud];
    }
    hud.labelText = message;
    [hud show:YES];
    if(delay > 0)
        [hud hide:YES afterDelay:delay];
    return hud;
}

+(NSMutableAttributedString *)ConverExpression:(UITextView *)textView andImage:(UIImage *)image
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithAttributedString:textView.attributedText];
    [string addAttribute:@"NSFontAttributeName" value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, string.length)];
    NSTextAttachment * atttachment = [[NSTextAttachment alloc]init];
    atttachment.image = image;
    // 修改 富文本图片的大小
    atttachment.bounds = CGRectMake(0, -4, 16, 16);
    NSAttributedString *temp = [NSAttributedString attributedStringWithAttachment:atttachment];
    
    NSInteger location = [textView offsetFromPosition:textView.beginningOfDocument toPosition:textView.selectedTextRange.start];
    [string insertAttributedString:temp atIndex:location];
    textView.selectedRange = NSMakeRange(location + temp.length + 1, 1);
    return string;
    
}

@end
