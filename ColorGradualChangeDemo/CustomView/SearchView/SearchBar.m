//
//  SearchView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/7.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "SearchBar.h"
#import "UIView+Frame.h"
#import "Config.h"
@implementation SearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        _placeholder =  @"大家都在搜: Selina";
        [self CreatUI];
        
       
    }
    return  self;
}

-(void)CreatUI
{
    CGFloat top = self.height < SearchBarHeight?5:22;
    [self setBackgroundColor:RGB_COLOR(@"#FAFAFA")];
    _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imageBtn setFrame:CGRectMake(5, top, 25, 25)];
    [_imageBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_search"] forState:UIControlStateNormal];
//    [_imageBtn setImage:[UIImage imageNamed:@"navigationbar_search"] forState:UIControlStateNormal];
//    _imageBtn.hidden = YES;
    [_imageBtn setBackgroundColor:RGB_COLOR(@"#E8E7E9")];
    [_imageBtn addTarget:self action:@selector(HandleImageBtn:) forControlEvents:UIControlEventTouchUpInside];
    _imageBtn.userInteractionEnabled = NO;
    [self addSubview:_imageBtn];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(_imageBtn.right, _imageBtn.top, self.width - _imageBtn.right - 5, _imageBtn.height)];
    _textField.placeholder =_placeholder;
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeySearch;
    [_textField setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
    [_textField setBackgroundColor:RGB_COLOR(@"#E8E7E9")];
    [self addSubview:_textField];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setFrame:CGRectMake(self.width - 50, _imageBtn.top, 40, _imageBtn.height)];
    [_cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(HandleCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.hidden = YES;
    [self addSubview:_cancelBtn];
}

-(void)ChangeSearchBarFrame
{
    if(self.type == CanEditType)
    {
    [_imageBtn setBackgroundImage:[UIImage imageNamed:@"searchbar_textfield_down_icon"] forState:UIControlStateNormal];
    _imageBtn.userInteractionEnabled = YES;
    }
    _cancelBtn.hidden = NO;
    CGRect frame = _textField.frame;
    frame.size.width =self.width - _imageBtn.right - _cancelBtn.width-10;
   [_textField setFrame:frame];
}

-(void)RecoverySearchBarFrame
{
    [_imageBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_search"] forState:UIControlStateNormal];
//    [_imageBtn setImage:[UIImage imageNamed:@"navigationbar_search"] forState:UIControlStateNormal];
    _textField.text=@"";
    _textField.placeholder = _placeholder;
    _imageBtn.userInteractionEnabled = NO;
    _cancelBtn.hidden = YES;
    CGRect frame = _textField.frame;
    frame.size.width =self.width - _imageBtn.right - 5;
    [UIView animateWithDuration:0.05 animations:^{
        [_textField setFrame:frame];
    }];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   if(self.type == CanNotEditType)
    {
        if([self.delegate respondsToSelector:@selector(TextFiledBegingEdite)])
        {
            
                [self.delegate TextFiledBegingEdite];
//            }
        }
    }
   else
   {
       NSArray * array = [textField.placeholder componentsSeparatedByString:@":"];
       textField.placeholder = array.count>1?array[1]:textField.placeholder;
       if([_textField isFirstResponder])
       {
           _textField.inputView = nil;
           NSLog(@"textView 变为 第一响应者");
           [self ChangeSearchBarFrame];
       }
//       else{
//           NSLog(@"......");
//       }
   }
}

-(void)HandleCancelBtn:(UIButton *)sender
{
    [_textField resignFirstResponder];
    [self RecoverySearchBarFrame];
    [self.delegate selectedCancelBtn:sender];
}
-(void)HandleImageBtn:(UIButton *)btn
{
    [self.delegate SelectedBtn:btn];
}

-(void)setTextFieldPlacehoder:(NSString *)placehoder
{
    _textField.placeholder = placehoder;
}

-(void)setType:(SearchBarType)type
{
    _type = type;
    if(type == CanNotEditType)
    {
        _textField.userInteractionEnabled = NO;
         UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSearchBar)];
        [self addGestureRecognizer:tap];
    }
    else
    {
        _textField.userInteractionEnabled = YES;
    }

}

-(void)tapSearchBar
{
    if([self.delegate respondsToSelector:@selector(TextFiledBegingEdite)])
    {
        [self.delegate TextFiledBegingEdite];
    }

}

//-(BOOL)becomeFirstResponder
//{
//    [super becomeFirstResponder];
//    
//    return [_textField becomeFirstResponder];
//}

@end
