//
//  SearchView.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  SearchBarHeight 55
typedef enum {
    CanEditType    =0,
    CanNotEditType = 1,
    CanNotPullDown
}SearchBarType;

@protocol SearchBarDelegate <NSObject>
@optional
-(void)SelectedBtn:(UIButton *)sender;
-(void)TextFiledBegingEdite;
-(void)selectedCancelBtn:(UIButton *)sendder;
@end
@interface SearchBar : UIView<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UIButton * _imageBtn;
    UIButton * _cancelBtn;
    NSString * _placeholder;
}
@property (nonatomic, assign)SearchBarType type;

@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, weak)id<SearchBarDelegate>delegate;

-(void)setTextFieldPlacehoder:(NSString *)placehoder;

@end
