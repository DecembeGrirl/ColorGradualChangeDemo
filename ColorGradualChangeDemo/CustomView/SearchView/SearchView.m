//
//  SearchView.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/21.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "SearchView.h"
#import "UIView+Frame.h"
#import "config.h"
@implementation SearchView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self CreatUI];
    }
    return  self;
}

-(void)CreatUI
{
    [self setBackgroundColor:[UIColor whiteColor]];
    self.searchBar = [[SearchBar alloc]initWithFrame:CGRectMake(0, 0, self.width, SearchBarHeight)];
    self.searchBar.type = CanEditType;
    self.searchBar.delegate = self;
    [self addSubview:self.searchBar];
    
    _hotSearchView = [[UIView alloc]initWithFrame:CGRectMake(0, self.searchBar.bottom, self.width, self.height- self.searchBar.bottom)];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, _hotSearchView.width, 25)];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.text = @"我是热搜榜哈哈哈";
    [_hotSearchView addSubview:label];
    [_hotSearchView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_hotSearchView];
    
    _pullDownView = [[PullDownView alloc]initWithFrame:CGRectMake(0, self.searchBar.bottom, 80, 0)];
    _pullDownView.delegate = self;
    _pullDownView.hidden = YES;
    [self addSubview:_pullDownView];
}
#pragma mark - SearchViewDelegate
-(void)SelectedBtn:(UIButton *)sender
{
    _pullDownView.hidden = !_pullDownView.hidden;
}

-(void)selectedCancelBtn:(UIButton *)sendder
{
    self.hidden = YES;
    self.selectedSearchBarCancelBtnBlock();
}

#pragma mark - PullDownViewDelegate
-(void)SelectedPullDownViewBtn:(UIButton *)btn
{
    [btn setBackgroundColor:RGB_COLOR(@"#E4E4E4")];
    self.searchBar.textField.text= @"";
    _pullDownView.hidden = YES;
    if([btn.titleLabel.text isEqualToString:@"搜全部"])
    {
        _searchBar.textField.placeholder = @"Selina";
    }
    else
    {
        _searchBar.textField.placeholder= btn.titleLabel.text;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _pullDownView.hidden = YES;
}

-(void)SearchBarBecomeFirstResponder
{
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.searchBar.textField becomeFirstResponder];
}


@end